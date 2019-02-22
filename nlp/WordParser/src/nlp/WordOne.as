package nlp 
{
	/**
	 * ...
	 * @author ww
	 */
	public class WordOne 
	{
		public var word:String;
		public var pinyin:String;
		public var type:String;
		public var detail:String;
		public var lines:Array;
		public function WordOne() 
		{
			lines = [];
		}
		
		public function addLine(line:String):void
		{
			lines.push(line);
		}
		public function parseEnd(removeLast:Boolean):void
		{
			if (removeLast) lines.pop();
			parseDetail();
		}
		
		public function parseDetail():void
		{
			
		}
	}

}