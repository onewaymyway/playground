package nlp.conll 
{
	/**
	 * ...
	 * @author ww
	 */
	public class ConllWordDic 
	{
		public static var I:ConllWordDic = new ConllWordDic();
		public var wordDic:Object = { };
		public var wordList:Array = [];
		public var typeDic:Object = { };
		public function ConllWordDic() 
		{
			
		}
		
		private function getWordCacheKey(word:ConllWord):String
		{
			return word.word + "@" + word.postag;
		}
		
		public function addToTypeDic(word:ConllWord):void
		{
			var tType:String;
			tType = word.postag;
			if (!typeDic[tType]) typeDic[tType] = [];
			var typeList:Array;
			typeList = typeDic[tType];
			typeList.push(word);
		}
		
		public function addWord(word:ConllWord):void
		{
			var key:String;
			key = getWordCacheKey(word);
			if (wordDic[key]) return;
			
			wordDic[key] = word;
			wordList.push(word);
			addToTypeDic(word);
		}
	}

}