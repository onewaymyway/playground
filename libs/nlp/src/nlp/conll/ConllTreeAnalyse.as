package nlp.conll 
{
	import laya.maths.MathUtil;
	import nlp.algorithm.KeysCounter;
	import nlp.dictools.TypeDefine;
	import nlp.dictools.TypeDicParser;
	import nlp.WordUtils;
	/**
	 * ...
	 * @author ww
	 */
	public class ConllTreeAnalyse 
	{
		
		public function ConllTreeAnalyse() 
		{
			
		}
		
		public static var typeDic:TypeDicParser;
		
		public static function getTreeKey(tree:ConllTree):String
		{
			var wordList:Array;
			wordList = tree.wordList;
			return getWordListKey(wordList);
		}
		
		public static function getWordListKey(wordList:Array):String
		{
			var i:int, len:int;
			len = wordList.length;
			var signList:Array;
			signList = [];
			var tword:ConllWord;
			for (i = 0; i < len; i++)
			{
				tword = wordList[i];
				
				signList.push(tword.postag);
				//signList.push(typeDic.getWordTypeStr(tword.word));
			}
			WordUtils.removeSameNB(signList);
			return signList.join(",");
		}
		
		public static function splitWordListByPu(wordList:Array):Array
		{
			var rst:Array;
			rst = [];
			var tarr:Array;
			var i:int, len:int;
			len = wordList.length;
			var tword:ConllWord;
			for (i = 0; i < len; i++)
			{
				tword = wordList[i];
				if (tword.postag == "PU")
				{
					if (tarr && tarr.length)
					{
						tarr = null;
					}
				}else
				{
					if (!tarr)
					{
						tarr = [];
						rst.push(tarr);
					}
					tarr.push(tword);
				}
			}
			return rst;
			
		}
		
		public var keyDic:Object = { };
		public var keys:Array;
		public var dependDic:Object = { };
		public var depends:Array;
		public var wordDic:Object;
		public var wordDic2:Object;
		public var word2wordCounter:KeysCounter=new KeysCounter();
		public var relationCounter:KeysCounter=new KeysCounter();
		public var noneCNRelationCounter:KeysCounter=new KeysCounter();
		public var noneCNTypeCounter:KeysCounter = new KeysCounter();
		public var dependCounter:KeysCounter = new KeysCounter();
		public var unkknowTypeCounter:KeysCounter = new KeysCounter();
		public var scoreUtils:ConllTreeScoreUtils = new ConllTreeScoreUtils();
		public function analyse(treeList:Array):void
		{
			var i:int, len:int;
			len = treeList.length;
			var tKey:String;
			var tree:ConllTree;
			wordDic = {};
			wordDic2 = {};
			for (i = 0; i < len; i++)
			{
				tree = treeList[i];
				tree.buildRelation();
				analyseRelation(tree);
				analyseWordLists(splitWordListByPu(tree.wordList));
				analyseWords(tree.wordList);
			}
			keys = WordUtils.getDicKeys(keyDic);
			keys.sort();
			trace("keys:", keys);
			
			depends = WordUtils.dic2Arr(dependDic);
			depends.sort(MathUtil.sortByKey("value"));
			trace("depends", depends);
			trace("depends", dependCounter);
			
			var wList:Array;
			wList = WordUtils.getDicKeys(wordDic);
			trace("wordList:",wList);
			
			var wList2:Array;
			wList2 = WordUtils.getDicKeys(wordDic2);
			trace("wordList2:", wList2);
			
			trace("word2word:",word2wordCounter);
			
			trace("wordDic:", ConllWordDic.I);

			trace("relation:", relationCounter);
			
			trace("noneCNRelationCounter:", noneCNRelationCounter);
			
			trace("noneCNTypeCounter:", noneCNTypeCounter);
			trace("unkknowTypeCounter:", unkknowTypeCounter);
			trace("scoreUtils", scoreUtils);
		}
		
		private function analyseWords(wordList:Array):void
		{
			var i:int, len:int;
			len = wordList.length;
			var  tWord:ConllWord;
			var key:String;
			for (i = 0; i < len; i++)
			{
				tWord = wordList[i];
				key = tWord.form;
				wordDic[key] = wordDic[key]?wordDic[key] + 1:1;
				
				key = tWord.form+"_"+tWord.cpostag;
				wordDic2[key]=wordDic2[key]?wordDic2[key]+1:1;
			}
		}
		
		
		private function getWordTypeEx(word:ConllWord):String
		{
			if (!word) return "null";
			return word.postag;
			return typeDic.getWordTypeCNStr(word.word);
		}
		
		private function getAdptWordType(word:ConllWord):String
		{
			if (typeDic.getWordType(word.word))
			{
				return typeDic.getWordTypeStr(word.word);
			}else
			{
				return word.postag;
			}
		}
		private function getRelationKey(relation:ConllRelation, tree:ConllTree):String
		{
			var startWord:ConllWord;
			var endWord:ConllWord;
			startWord = tree.getWordByIndex(relation.start);
			endWord = tree.getWordByIndex(relation.end);
			var tType:String;
			tType = startWord.postag;
			if (!typeDic.getWordType(startWord.word))
			{
				unkknowTypeCounter.addKey(startWord.postag, startWord.form);
			}
			//if (!TypeDefine.hasCHType(tType)){
				noneCNTypeCounter.addKey(tType,startWord.form);
			//}
			if (endWord)
			{
				word2wordCounter.addKey(startWord.form, endWord.form, relation.end > relation.start);
				scoreUtils.addRelation(startWord, endWord);
				
				
			}else
			{
				dependCounter.addKey("Root",startWord.postag,true);
			}
			
			
			//return getWordTypeEx(startWord) + ":" +getWordTypeEx(endWord) + ":" + (relation.end > relation.start);
			return getWordRelationKey(startWord, endWord, relation.end - relation.start);
			//if (startWord && endWord)
			//{
				//return startWord.postag + ":" + endWord.postag;
				//
				//return typeDic.getWordTypeStr(startWord.word) + ":" + typeDic.getWordTypeStr(endWord.word);
			//}
			return "unknow";
		}
		
		private function getWordRelationKey(startWord:ConllWord, endWord:ConllWord, pos:int):String
		{
			return getWordTypeEx(startWord) + ":" +getWordTypeEx(endWord)+":"+(pos>0);
		}
		
		public function getWordRelationScore(start:ConllWord, end:ConllWord, pos:int):Number
		{
			var key:String;
			key = getWordRelationKey(start, end,pos);
			if (dependDic[key])
			{
				return dependDic[key];
			}
			return 0;
		}
		private function analyseRelation(tree:ConllTree):void
		{
			var relations:Array;
			relations = tree.relations;
			var i:int, len:int;
			len = relations.length;
			var tRelation:ConllRelation;
			var tkey:String;
			
			for (i = 0; i < len; i++)
			{
				tRelation = relations[i];
				tkey = getRelationKey(tRelation, tree);
				if (!dependDic[tkey])
				{
					dependDic[tkey] = 1;
				}else
				{
					dependDic[tkey] = dependDic[tkey]+1;
				}
				relationCounter.addKey(tRelation.type,tkey);

				if (!ConllDesParser.hasCNType(tRelation.type))
				{
					noneCNRelationCounter.addKey(tRelation.type);
				}
				
			}
		}
		
		private function analyseWordLists(lists:Array):void
		{
			var i:int, len:int;
			len = lists.length;
			var tKey:String;
			for (i = 0; i < len; i++)
			{
				tKey = getWordListKey(lists[i]);
				keyDic[tKey] = lists;
			}
		}
	}

}