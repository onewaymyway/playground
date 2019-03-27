package nlp 
{
	/**
	 * ...
	 * @author ww
	 */
	public class WordOne 
	{
		public var oWord:WordParser;
		public var word:String;
		public var pinyin:String;
		public var twPY:String;
		public var type:String;
		public var detail:String;
		public var lines:Array;
		public var des:Array;
		public var detailParsed:Boolean = false;
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
			//parseDetail();
		}
		
		public static var DesKeyWords:Array = ["：", "如:", "∶表示", "同\“", "另见"];
		public static var DesKeyStartWords:Array = ["∶","：","用在","姓"];
		public static function getKeyWords(str:String):String
		{
			var i:int, len:int;
			len = DesKeyWords.length;
			for (i = 0; i < len; i++)
			{
				if (str.indexOf(DesKeyWords[i]) >= 0)
				{
					return DesKeyWords[i];
				}
			}
			return null;
		}
		public static function getKeyStartWords(str:String):String
		{
			var i:int, len:int;
			len = DesKeyStartWords.length;
			for (i = 0; i < len; i++)
			{
				if (str.indexOf(DesKeyStartWords[i]) == 0)
				{
					return DesKeyStartWords[i];
				}
			}
			return null;
		}
		public function parseDetail():void
		{
			if (detailParsed) return;
			detailParsed = true;
			des = [];
			var i:int, len:int;
			len = lines.length;
			var tDes:Array;
			var tLine:String;
			for (i = 0; i < len; i++)
			{
				tLine = lines[i];
				if (tLine.length == 1)
				{
					trace("one:",tLine);
				} 
				if (getKeyStartWords(tLine))
				{
					tDes = [];
					tDes.push(tLine);
					des.push(tDes);
				}else
				if (getKeyWords(tLine))
				{
					tDes = [];
					tDes.push(tLine);
					des.push(tDes);
				}else
				{
					if (!tDes)
					{
						tDes = [];
						des.push(tDes);
					}
					
					tDes.push(tLine);
				}
			}
		}
	}

}