package nlp.conll 
{
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
		public function analyse(treeList:Array):void
		{
			var i:int, len:int;
			len = treeList.length;
			var tKey:String;
			var tree:ConllTree;
			
			for (i = 0; i < len; i++)
			{
				tree = treeList[i];
				analyseWordLists(splitWordListByPu(tree.wordList));
			}
			keys = WordUtils.getDicKeys(keyDic);
			keys.sort();
			trace("keys:",keys);
		}
		
		private function analyseWordLists(lists:Array):void
		{
			var i:int, len:int;
			len = lists.length;
			var tKey:String;
			for (i = 0; i < len; i++)
			{
				tKey = getWordListKey(lists[i]);
				keyDic[tKey] = tree;
			}
		}
	}

}