package nlp.cutwords 
{
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
		public var wordRef:WordOne;
		public var type:String;
		public function WordPiece() 
		{
			
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