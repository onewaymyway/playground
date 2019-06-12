package nlp.conll 
{
	import laya.debug.tools.ObjectTools;
	import nlp.WordDicParser;
	import nlp.WordUtils;
	import nlp.cutwords.WordPiece;
	/**
	 * ...
	 * @author ww
	 */
	public class ConllTreeBuilder 
	{
		public var treeAnalyseer:ConllTreeAnalyse;
		public function ConllTreeBuilder() 
		{
			
		}
		
		public function cutStringToTree(str:String):ConllTree
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
				wordList.push(tConllWord);
			}
			return buildConllTree(wordList);
		}
		public function scoreRelation(wordA:ConllWord, wordB:ConllWord, type:int):void
		{
			return treeAnalyseer.scoreUtils.getScore(wordA, wordB);
			//return treeAnalyseer.dependCounter.getKeyNum(wordA.postag, wordB.postag, wordB.id>wordA.id);
		}
		
		public function rebuildConllTree(tree:ConllTree):ConllTree
		{
			return buildConllTree(tree.getConllWordForRebuild());
		}
		
		public function buildWordRelation(wordList:Array):void
		{
			var wList:Array;
			wList = ObjectTools.concatArr([],wordList);
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
			jLen = wList.length;
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
		public function buildConllTree(wordList:Array):ConllTree
		{
			var conllTree:ConllTree;
			conllTree = new ConllTree();
			buildWordRelation(wordList);
			conllTree.wordList = wordList;
			return conllTree;
		}
	}

}