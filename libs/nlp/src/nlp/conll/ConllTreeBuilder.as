package nlp.conll 
{
	import laya.debug.tools.ObjectTools;
	import nlp.WordDicParser;
	import nlp.WordUtils;
	import nlp.algorithm.datastruct.AutoTensor;
	import nlp.cutwords.WordPiece;
	/**
	 * ...
	 * @author ww
	 */
	public class ConllTreeBuilder 
	{
		public var treeAnalyseer:ConllTreeAnalyse;
		public var arcAnalyser:ConllTreeArcAnalyser;
		public function ConllTreeBuilder() 
		{
			arcAnalyser = new ConllTreeArcAnalyser();
		}
		
		public function cutStringToTree(str:String,useDP:Boolean=false):ConllTree
		{
			var words:Array;
			words = WordDicParser.I.cut(str);
			var i:int, len:int;
			len = words.length;
			var tWordPiece:WordPiece;
			var tConllWord:ConllWord;
			var wordList:Array;
			wordList = [];
			for (i = 0; i < len; i++)
			{
				tWordPiece = words[i];
				tConllWord = new ConllWord();
				tConllWord.id = i;
				tConllWord.form = tWordPiece.word;
				tConllWord.word = tWordPiece.word;
				tConllWord.postag = WordUtils.typeDic.getWordTypeStr(tConllWord.word);
				tConllWord.refers = [];
				tConllWord.head =-1;
				wordList.push(tConllWord);
			}
			return buildConllTree(wordList,useDP);
		}
		public function scoreRelation(wordA:ConllWord, wordB:ConllWord, type:int):void
		{
			return treeAnalyseer.scoreUtils.getScore(wordA, wordB);
			//return treeAnalyseer.dependCounter.getKeyNum(wordA.postag, wordB.postag, wordB.id>wordA.id);
		}
		
		public function rebuildConllTree(tree:ConllTree,useDP:Boolean=false):ConllTree
		{
			arcAnalyser.analyseTree(tree);
			return buildConllTree(tree.getConllWordForRebuild(),useDP);
		}
		
		public function buildWordRelation(wordList:Array,useDP:Boolean=false):void
		{
			var wList:Array;
			wList = ObjectTools.concatArr([], wordList);
			
			if (useDP)
			{
				buildByDP(wList);
				return;
			}
			
			var i:int, len:int;
			len = wList.length;
			var tSelectWord:ConllWord;
			var tSelectRWord:ConllWord;
			var tSelectScore:Number;
			var tSelectIndex:int =-1;
			var tDir:int =-1;
			var tWord:ConllWord;
			var tRWord:ConllWord;
			var tScore:Number;
			var j:int, jLen:int;
			var k:int;
			jLen = wList.length-1;
			for (j = 0; j < jLen; j++)
			{
				len = wList.length;
				tSelectWord = null;
				tSelectIndex =-1;
				for (i = 0; i < len; i++)
				{
					tWord = wList[i];
					for (k = 0; k < len; k++)
					{
						if (i == k) continue;
						if (Math.abs(i - k) > 1) continue;
						tRWord = wList[k];
						if (tRWord)
						{
							tScore = scoreRelation(tWord, tRWord, 1);
							if (!tSelectWord || tScore > tSelectScore)
							{
								tSelectWord = tWord;
								tSelectScore = tScore;
								tSelectRWord = tRWord;
								tDir = 1;
								tSelectIndex = i;
							}
						}
					}
					
				}
				if (tSelectWord)
				{
					tSelectWord.head = tSelectRWord.id;
					wList.splice(tSelectIndex, 1);
					tSelectWord.deprel = "ds"+tSelectScore.toFixed(3);
				}
			}
			
		}
		
		private var valueTensor:AutoTensor;
		private var relationTensor:AutoTensor;
		private var wordList:Array;
		public function buildByDP(wordList:Array):void
		{
			this.wordList = wordList;
			//f(i,j,k) i-j之间以k为根的最大值
			//遍历根节点
			valueTensor = new AutoTensor();
			relationTensor = new AutoTensor();
			var i:int, len:int;
			len = wordList.length;
			var tSelectRoot:int =-1;
			var tRoot:int;
			var tScore:Number;
			var tSelectScore:Number;
			var start:int, end:int;
			start = 0;
			end = wordList.length-1;
			for (i = 0; i < len; i++)
			{
				tRoot = i;
				tScore = getMaxTree(start, end, tRoot)+treeAnalyseer.scoreUtils.getRootScore(wordList[tRoot]);
				if (tSelectRoot<0||tScore>tSelectScore)
				{
					tSelectScore = tScore;
					tSelectRoot = tRoot;
				}
			}
			decodeTreeInfo(start, end, tSelectRoot);
			
		}
		private function decodeTreeInfo(start:int, end:int, root:int):void
		{
			if (start == end) return;
			if (!relationTensor.hasValue(start, end, root))
			{
				trace("noRelation":start,end,root);
				debugger;
				return;
			}
			var info:Array;
			info = relationTensor.getValue(start, end, root);
			trace("decodeTreeInfo", info);
			//[start, tSelectBound, end, oRoot]
			var oRoot:int;
			oRoot = info[3];
			var bound:int;
			bound = info[1];
			var wordStart:ConllWord;
			wordStart = wordList[oRoot];
			var wordEnd:ConllWord;
			wordEnd = wordList[root];
			
			if (wordStart && wordEnd)
			{
				wordStart.head = wordEnd.id;
				wordStart.deprel = "depends";
			}
			
			
			if (oRoot > root)
			{
				var temp:Number;
				temp = root;
				root = oRoot;
				oRoot = temp;
			}
			
			decodeTreeInfo(start, bound - 1, oRoot);
			decodeTreeInfo(bound, end, root);
		}
		private function scoreRelationByIndex(start:int, end:int):Number
		{
			return scoreRelation(wordList[start], wordList[end], 1);
		}
		private function getMaxTree(start:int, end:int, root:int):Number
		{
			if (root > end) debugger;
			if (start == end) return 0;
			if (valueTensor.hasValue(start, end, root)) return valueTensor.getValue(start, end, root);
			var tValue:Number;
			var i:int, len:int;
			var oRoot:int;
			var bound:int;
			var tScore:Number;
			var selectScore:Number;
			var tSelectORoot:int;
			var tSelectBound:int;
			var hasValue:Boolean;
			hasValue = true;
			selectScore =-10000000;
			for (oRoot = start; oRoot <= end;oRoot++ )
			{
				if (oRoot != root)
				{
					if (oRoot < root)
					{
						for (bound = oRoot + 1; bound <= root;bound++ )
						{
							tScore = getMaxTree(start, bound - 1, oRoot) + getMaxTree(bound, end,root)+scoreRelationByIndex(oRoot,root);
							if (!hasValue||tScore > selectScore)
							{
								hasValue = true;
								selectScore = tScore;
								tSelectORoot = oRoot;
								tSelectBound = bound;
							}
						}
					}else
					{
						for (bound = root + 1; bound <= oRoot;bound++ )
						{
							tScore = getMaxTree(start, bound - 1, root) + getMaxTree(bound, end,oRoot)+scoreRelationByIndex(oRoot,root);;
							if (!hasValue||tScore > selectScore)
							{
								hasValue = true;
								selectScore = tScore;
								tSelectORoot = oRoot;
								tSelectBound = bound;
							}
						}
					}
					
					
				}
			}
			valueTensor.setValue(selectScore, start, end, root);
			relationTensor.setValue([start, tSelectBound, end, tSelectORoot], start, end, root);
			return selectScore;
			
		}
		public function buildConllTree(wordList:Array,useDP:Boolean=false):ConllTree
		{
			var conllTree:ConllTree;
			conllTree = new ConllTree();
			buildWordRelation(wordList,useDP);
			conllTree.wordList = wordList;
			return conllTree;
		}
	}

}