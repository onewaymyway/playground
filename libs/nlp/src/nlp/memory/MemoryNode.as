package nlp.memory 
{
	/**
	 * ww
	 * @author 
	 */
	public class MemoryNode 
	{
		public var word:String;
		public var connectDic:Object = {};
		public function MemoryNode() 
		{
			
		}
		public function getScore(word:String):Number
		{
			return connectDic[word] || 0;
		}
		public function addConnect(word:String):void
		{
			if (!connectDic[word]) connectDic[word] = 0;
			connectDic[word] = connectDic[word] + 1;
		}
		public static function createByWord(word:String):MemoryNode
		{
			var rst:MemoryNode;
			rst = new MemoryNode();
			rst.word = word;
			return rst;
		}
	}

}