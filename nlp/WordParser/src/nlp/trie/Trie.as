package nlp.trie 
{
	import nlp.WordOne;
	/**
	 * ...
	 * @author ww
	 */
	public class Trie 
	{
		
		public function Trie() 
		{
			
		}
		
		public function addWord(word:TrieWord):void
		{
			
		}
		
		public function buildByWordList(wordList:Array):void
		{
			var twList:Array;
			twList = TrieWord.createTrieWordList(wordList);
			var i:int, len:int;
			len = twList.length;
			var tWord:TrieWord;
			for (i = 0; i < len; i++)
			{
				tWord = twList[i];
				addWord(tWord);
			}
		}
	}

}