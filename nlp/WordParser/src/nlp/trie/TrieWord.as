package nlp.trie 
{
	import nlp.WordOne;
	/**
	 * ...
	 * @author ww
	 */
	public class TrieWord 
	{
		public var words:Array;
		public var word:String;
		public function TrieWord() 
		{
			words = [];
		}
		
		public function addWord(word:WordOne):void
		{
			words.push(word);
		}
		
		public static function createByWord(word:String):TrieWord
		{
			var rst:TrieWord;
			rst = new TrieWord();
			rst.word = word;
			return rst;
		}
		
		public static function createTrieWordList(wordList:Array):Array
		{
			var wordDic:Object;
			wordDic = { };
			var i:int, len:int;
			len = wordList.length;
			var tWord:WordOne;
			var tTrieWord:TrieWord;
			for (i = 0; i < len; i++)
			{
				tWord = wordList[i];
				if (!wordDic[tWord.word])
				{
					wordDic[tWord.word] = createByWord(tWord.word);
				}
				tTrieWord = wordDic[tWord.word];
				tTrieWord.addWord(tWord);
			}
			var twList:Array;
			twList = [];
			var key:String;
			for (key in wordDic)
			{
				tTrieWord = wordDic[key];
				twList.push(tTrieWord);
			}
			twList.sort(sortWordByLen);
			return twList;
		}
		
		private static function sortWordByLen(word0:WordOne, word1:WordOne):int
		{
			return word0.word.length - word1.word.length;
		}
	}

}