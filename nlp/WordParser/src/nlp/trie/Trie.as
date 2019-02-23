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
		
		public var root:TrieNode;
		public function addWord(word:TrieWord):void
		{
			root.addWord(0, word);
		}
		
		public function buildByWordList(wordList:Array):void
		{
			root = new TrieNode();
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
		
		public function findByChar(char:String):TrieNode
		{
			return root.findByChar(char);
		}
	}

}