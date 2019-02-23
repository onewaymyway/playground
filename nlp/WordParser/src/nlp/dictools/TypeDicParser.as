package nlp.dictools 
{
	/**
	 * ...
	 * @author ww
	 */
	public class TypeDicParser 
	{
		
		public function TypeDicParser() 
		{
			wordDic = { };
		}
		public function getWordType(word:String):Object
		{
			var typeO:Object;
			typeO = wordDic[word];
			if (!typeO) return null;
			return typeO.type;
		}
		public var wordDic:Object;
		public static const Tab:String = "	";
		public function initByTxt(txt:String):void
		{
			var lines:Array;
			lines = txt.split("\n");
			var i:int, len:int;
			len = lines.length;
			var tLine:String;
			var tWordO:Object;
			for (i = 0; i < len; i++)
			{
				tLine = lines[i];
				tLine = tLine.replace("\r", "");
				tWordO = parseLine(tLine);
				wordDic[tWordO.word] = tWordO;
				//if (i > 100) break;
			}
		}
		
		public function parseLine(line:String):Object
		{
			var arr:Array;
			arr = line.split(Tab);
			//trace("line:", arr, line.length);
			var rst:Object;
			rst = { };
			rst.word = arr[0];
			rst.type = {};
			var i:int, len:int;
			len = arr.length;
			for (i = 1; i < len; i += 2)
			{
				rst.type[arr[i]] = arr[i + 1];
				rst.type[TypeDefine.getCHType(arr[i])] = arr[i + 1];
			}
			
			return rst;
		}
	}

}