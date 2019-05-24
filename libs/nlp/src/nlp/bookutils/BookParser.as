package nlp.bookutils 
{
	/**
	 * ...
	 * @author ww
	 */
	public class BookParser 
	{
		
		public function BookParser() 
		{
			
		}
		
		public var lines:Array;
		public var index:int;
		public function setTxt(txt:String):void
		{
			txt = txt.replace("\r", "");
			lines = txt.split("\n");
			index = 0;
		}
		
		public function reset():void
		{
			index = 0;
		}
		
		public function getCurLine():String
		{
			return lines[index];
		}
		
		public function pre():String
		{
			index--;
			normalIndex();
			return getCurLine();
		}
		
		public function next():String
		{
			index++;
			normalIndex();
			return getCurLine();
		}
		
		private function normalIndex():void
		{
			if (index < 0) index = 0;
			if (index >= lines.length) index = lines.length - 1;
		}
		public static function createByTxt(txt:String):BookParser
		{
			var rst:BookParser;
			rst = new BookParser();
			rst.setTxt(txt);
			return rst;
		}
		
	}

}