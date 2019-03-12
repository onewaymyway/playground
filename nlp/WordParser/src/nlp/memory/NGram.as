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
		public var wordDic:Object={};
		public function getWord(word:String):MemoryNode
		{
			if (!wordDic[word]) wordDic[word] = MemoryNode.createByWord(word);
			return wordDic[word];
		}
		public function workWordList(wordList:Array):void
		{
			var i:int, len:int;
			len = wordList.length;
			for (i = 0; i < len; i++)
			{
				
			}
		}
	}

}