package nlp.conll 
{
	import nlp.WordUtils;
	/**
	 * ...
	 * @author ww
	 */
	public class ConllDesParser 
	{
		
		public function ConllDesParser() 
		{
			
		}
		public static var I:ConllDesParser;
		public static function getCNType(type:String):String
		{
			if (I && I.desDic[type]) return I.desDic[type].desCN;
			return type;
		}
		public static function hasCNType(type:String):Boolean
		{
			if (I && I.desDic[type]) return true;
			return false;
		}
		public var desDic:Object;
		public static const KeyList:Array = ["desCN","type","desEN","detail"];
		public function parseLine(line:String):Object
		{
			var data:Object;
			data = WordUtils.arr2keyObj(line.split("\t"), KeyList);
			desDic[data.type] = data;
			return data;
			
		}
		public function parseTxt(txt:String):void
		{
			desDic = {};
			var lines:Array;
			lines = txt.split("\n");
			var i:int, len:int;
			len = lines.length;
			var tLine:String;
			
			
			for (i = 0; i < len; i++)
			{
				tLine = lines[i];
				parseLine(tLine);
				//if (tLine.indexOf("\t")<0)
				//trace("t",tArr);
				
			}
			trace("ConllDesParser:",this);
		}
		
	}

}