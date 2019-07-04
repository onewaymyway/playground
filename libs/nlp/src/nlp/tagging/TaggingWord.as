package nlp.tagging 
{
	import laya.debug.tools.ObjectTools;
	import nlp.WordDicParser;
	import nlp.cutwords.WordPiece;
	/**
	 * ...
	 * @author ww
	 */
	public class TaggingWord 
	{
		public static const KEYS:Array = ["word","type","meaning","relations","id","head","deprel"];
		public var word:String;
		public var type:String;
		public var meaning:String;
		public var relations:Array = [];
		public var head:int=0;
		public var deprel:String;
		public var id:int;
		public function TaggingWord() 
		{
			
		}
		
		public function toData():Object
		{
			return ObjectTools.toData(this, KEYS);
		}
		
		public static function fromData(data:Object):TaggingWord
		{
			return ObjectTools.fromData(new TaggingWord(), data, KEYS);
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
			wordPiece=WordDicParser.I.cutter.findWordPiece(word);
			return createByWordPiece(wordPiece);
			
		}
		
	}

}