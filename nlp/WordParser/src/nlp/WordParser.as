package nlp 
{
	/**
	 * ...
	 * @author ww
	 */
	public class WordParser 
	{
		public var word:String;
		public function WordParser() 
		{
			lines = [];
		}
		
		public var lines:Array;
		public function addLine(line:String):void
		{
			lines.push(line);
		}
		
		public function addHead(line:String):void
		{
			
		}
	}

}