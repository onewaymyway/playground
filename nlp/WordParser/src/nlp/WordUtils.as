package nlp 
{
	/**
	 * ...
	 * @author ww
	 */
	public class WordUtils 
	{
		
		public function WordUtils() 
		{
			
		}
		
		public static function printLines(lines:Array):void
		{
			var i:int, len:int;
			len = lines.length;
			for (i = 0; i < len; i++)
			{
				trace(lines[i]);
			}
		}
		
		public static function showChars(start:int, end:int):void
		{
			var i:int;
			for (i = start; i <= end; i++)
			{
				trace("char:",i,":(",String.fromCharCode(i),")");
			}
		}
		
		public static function arrToDic(arr:Array):Object
		{
			var rst:Object;
			rst = { };
			var i:int, len:int;
			len = arr.length;
			for (i = 0; i < len; i++)
			{
				rst[arr[i]] = arr[i];
			}
			return rst;
		}
		
	}

}