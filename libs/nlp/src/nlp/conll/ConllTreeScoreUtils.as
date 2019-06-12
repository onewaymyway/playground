package nlp.conll 
{
	import nlp.WordUtils;
	import nlp.algorithm.KeysCounter;
	/**
	 * ...
	 * @author ww
	 */
	public class ConllTreeScoreUtils 
	{
		public var word2wordCounter:KeysCounter;
		public var tag2wordCounter:KeysCounter;
		public var word2tagCounter:KeysCounter;
		public var tag2tagCounter:KeysCounter;
		
		private function getAdptWordType(word:ConllWord):String
		{
			if (WordUtils.typeDic.getWordType(word.word))
			{
				return WordUtils.typeDic.getWordTypeStr(word.word);
			}else
			{
				return word.postag;
			}
		}
		
		public function ConllTreeScoreUtils() 
		{
			word2wordCounter = new KeysCounter();
			tag2wordCounter = new KeysCounter();
			word2tagCounter = new KeysCounter();
			tag2tagCounter = new KeysCounter();
		}
		
		public function addRelation(startWord:ConllWord, endWord:ConllWord):void
		{
			var type:*;
			type = endWord.id > startWord.id;
			tag2tagCounter.addKey(getAdptWordType(startWord.postag), getAdptWordType(endWord.postag), type);
			word2wordCounter.addKey(startWord.form, endWord.form, type);
			tag2wordCounter.addKey(getAdptWordType(startWord.postag), endWord.form, type);
			word2tagCounter.addKey(startWord.form, getAdptWordType(endWord.postag), type);
		}
		
		public function getScore(startWord:ConllWord, endWord:ConllWord):Number
		{
			var type:*;
			type = endWord.id > startWord.id;
			var rst:Number;
			rst = word2wordCounter.getKeyLogNum(startWord.form, endWord.form, type);
			//rst = 0;
			rst += word2tagCounter.getKeyLogNum(startWord.form, getAdptWordType(endWord.postag), type)*0.01;
			rst += tag2wordCounter.getKeyLogNum(getAdptWordType(startWord.postag), endWord.form, type)*0.01;
			rst += tag2tagCounter.getKeyLogNum(getAdptWordType(startWord.postag), getAdptWordType(endWord.postag), type) * 0.0001;
			rst += -Math.abs(startWord.id - endWord.id) * 0.1;
			return rst;
		}
	}

}