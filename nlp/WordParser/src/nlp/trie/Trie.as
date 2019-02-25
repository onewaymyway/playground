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
		public var rootR:TrieNode;
		public function addWord(word:TrieWord):void
		{
			root.addWord(0, word);
			rootR.addWordR(0, word);
		}
		
		public function addWordIfNotExist(wordOne:TrieWord):void
		{
			if (getWord(wordOne.word))
			{
				
				return;
			} 
			//trace("addWord:",wordOne.word,wordOne);
			addWord(wordOne);
		}
		public function addWordOneList(wordList:Array):void
		{
			var trieWordList:Array;
			trieWordList = TrieWord.createTrieWordList(wordList);
			var i:int, len:int;
			len = trieWordList.length;
			for (i = 0; i < len; i++)
			{
				addWordIfNotExist(trieWordList[i]);
			}
		}
		public function getWord(word:String):TrieNode
		{
			if (!word) return null;
			var tWord:TrieNode;
			var tchar:String;
			var tPos:int;
			tPos = 0;
			tchar = word.charAt(tPos);
			tWord = findByChar(tchar);
			while (tWord)
			{
				tPos++;
				if (tPos >= word.length) break;
				tchar = word.charAt(tPos);
				tWord = findByChar(tchar);
				
			}
			if (tWord && tWord.isWord() && tWord.word == word)
			{
				return tWord;
			}
			return null;
		}
		
		public function buildByWordList(wordList:Array):void
		{
			root = new TrieNode();
			rootR = new TrieNode();
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
		
		public function findByCharR(char:String):TrieNode
		{
			return rootR.findByChar(char);
		}
	}

}