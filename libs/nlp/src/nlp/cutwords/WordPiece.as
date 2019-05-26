package nlp.cutwords 
{
	import nlp.trie.TrieWord;
	import nlp.WordOne;
	/**
	 * ...
	 * @author ww
	 */
	public class WordPiece 
	{
		public var word:String;
		public var start:int;
		public var end:int;
		public var wordRef:TrieWord;
		public var type:String;
		public var typeO:Object;
		public function WordPiece() 
		{
			
		}
		
		public function getWordTypeStr(word:WordPiece):String
		{
			if (!this.typeO) return "unknow";
			return this.typeO.typecns.join(":");
		}
		
		public function update():WordPiece
		{
			if (wordRef)
			{
				word = wordRef.word;
			}
			return this;
		}
		
	}

}