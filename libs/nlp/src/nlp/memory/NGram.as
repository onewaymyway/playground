package nlp.memory 
{
	/**
	 * ww
	 * @author 
	 */
	public class NGram 
	{
		
		public function NGram() 
		{
			
		}
		public var firstKey:String;
		public var secondKey:String;
		public var wordDic:Object = { };
		public var key:String;
		public function getWord(word:String):MemoryNode
		{
			if (!wordDic[word]) wordDic[word] = MemoryNode.createByWord(word);
			return wordDic[word];
		}
		public function getWordStrFromWord(wordO:*):String
		{
			if (wordO is String) return wordO;
			return wordO[key];
		}
		public function workWordList(wordList:Array):void
		{
			var i:int, len:int;
			len = wordList.length;
			var tWordO:Object;
			for (i = 0; i < len; i++)
			{
				addWord(i,wordList);
				
			}
		}
		public function addWord(pos:int,wordList:Array):void
		{
			if (pos >= wordList.length - 1) return;
			var start:String;
			var end:String;
			start = getWordStrFromWord(wordList[i]);
			end = getWordStrFromWord(wordList[i + 1]);
			var startNode:MemoryNode;
			startNode = getWord(start);
			startNode.addConnect(end);
		}
		
		public function getWordPairScore(wordStart:String, wordEnd:String):Number
		{
			var tMemoryNode:MemoryNode;
			tMemoryNode = wordDic[wordStart];
			if (!tMemoryNode) return 0;
			return tMemoryNode.getScore(wordEnd);
		}
		public function reCalculate():void
		{
			
		}
	}

}