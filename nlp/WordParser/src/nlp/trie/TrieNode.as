package nlp.trie 
{
	import nlp.WordOne;
	/**
	 * ...
	 * @author ww
	 */
	public class TrieNode 
	{
		public var childDic:Object;
		public var char:String = "";
		public var word:TrieWord;
		public var wordStr:String;
		public function TrieNode() 
		{
			childDic = { };
		}
		
		public function findByChar(char:String):TrieNode
		{
			return childDic[char];
		}
		
		public function isWord():Boolean
		{
			return word?true:false;
		}
		public function getChildByChar(char:String):TrieNode
		{
			if (!childDic[char])
			{
				childDic[char] = createByChar(char);
			}
			return childDic[char];
		}
		public function addWord(pos:int,word:TrieWord):void
		{
			if (pos == word.word.length)
			{
				this.word = word;
				this.wordStr = word.word;
				return;
			}
			var tchar:String;
			tchar = word.word.charAt(pos);
			var tChild:TrieNode;
			tChild = getChildByChar(tchar);
			tChild.addWord(pos + 1, word);
		}
		
		public function addWordR(pos:int,word:TrieWord):void
		{
			if (pos == word.word.length)
			{
				this.word = word;
				this.wordStr = word.word;
				return;
			}
			var tchar:String;
			tchar = word.word.charAt(word.word.length-1-pos);
			var tChild:TrieNode;
			tChild = getChildByChar(tchar);
			tChild.addWordR(pos + 1, word);
		}
		
		public static function createByChar(char:String):TrieNode
		{
			var rst:TrieNode;
			rst = new TrieNode();
			rst.char = char;
			return rst;
		}
		
	}

}