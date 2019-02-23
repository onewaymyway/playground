package nlp.cutwords 
{
	import nlp.trie.Trie;
	import nlp.trie.TrieNode;
	/**
	 * ...
	 * @author ww
	 */
	public class WordCutter 
	{
		public var trie:Trie;
		public function WordCutter() 
		{
			
		}
		
		public function cut(str:String):Array
		{
			var tPos:int;
			tPos = 0;
			var rst:Array;
			rst = [];
			var tPiece:WordPiece;
			while (tPos < str.length)
			{
				tPiece = findMaxWord(str, tPos);
				if (!tPiece) break;
				rst.push(tPiece);
				tPos = tPiece.end;
			}
			
			return rst;
		}
		
		public function findMaxWord(str:String, pos:int = 0):WordPiece
		{
			var tchar:String;
			tchar = str.charAt(pos);
			var tTrieNode:TrieNode;
			tTrieNode = trie.findByChar(tchar);
			
			var tPiece:WordPiece;
			tPiece = new WordPiece();
			tPiece.start = pos;
			tPiece.end = pos + 1;
			if (!tTrieNode)
			{
				tPiece.word = tchar;
				tPiece.type = "new";
				return tPiece.update();
			} 
			
			//tPiece
			if (tTrieNode.isWord())
			{
				tPiece.end = pos+1;
				tPiece.wordRef = tTrieNode.word;
			}
			var end:int;
			end = pos;
			var next:TrieNode;
			while (tTrieNode)
			{
				end++;
				if (end >= str.length)
				{
					break;
				}
				tchar = str.charAt(end);
				next = tTrieNode.findByChar(tchar);
				if (!next) break;
				tTrieNode = next;
				if (tTrieNode.isWord())
				{
					tPiece.end = end+1;
					tPiece.wordRef = tTrieNode.word;
				}
			}
			return tPiece.update();
		}
		
		
	}

}