package nlp.wordmap 
{
	/**
	 * ...
	 * @author ww
	 */
	public class SimpleWordMap 
	{
		public var wordMap:Object = { };
		public function SimpleWordMap() 
		{
			
		}
		public function addWordList(arr:Array):void
		{
			var i:int, len:int;
			len = arr.length;
			for (i = 1;i < len; i++)
			{
				addWordPair(arr[i-1],arr[i]);
			}
		}
		
		private function addWordPair(wordA:String, wordB:String):void
		{
			if (!wordMap[wordA])
			{
				wordMap[wordA] = { };
			}
			var tWordDic:Object;
			tWordDic = wordMap[wordA];
			if (!tWordDic[wordB])
			{
				tWordDic[wordB] = 1;
			}else
			{
				tWordDic[wordB] = tWordDic[wordB] + 1;
			}
		}
		
		public function info():void
		{
			var eList:Array;
			eList = [];
			var startCount:int;
			startCount = 0;
			var tWordDic:Object;
			var key:String;
			var key2:String;
			for (key in wordMap)
			{
				startCount++;
				tWordDic = wordMap[key];
				for (key2 in tWordDic)
				{
					eList.push([key,key2,tWordDic[key2]);
				}
			}
			trace("Info: startCount:"+startCount+" eList:",eList);
		}
		
	}

}