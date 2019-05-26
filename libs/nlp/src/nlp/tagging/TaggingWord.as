package nlp.tagging 
{
	import nlp.cutwords.WordPiece;
	/**
	 * ...
	 * @author ww
	 */
	public class TaggingWord 
	{
		public var word:String;
		public var type:String;
		public var meaning:String;
		public var relations:Array=[];
		public var id:int;
		public function TaggingWord() 
		{
			
		}
		
		public static function createByWordPiece(word:WordPiece):TaggingWord
		{
			var rst:TaggingWord;
			rst = new TaggingWord();
			rst.word = word.word;
			rst.type = word.getWordTypeStr();
			return rst;
		}
		
		public static function createByWordStr(word:String):TaggingWord
		{
			var wordPiece:WordPiece;
			
		}
		
	}

}