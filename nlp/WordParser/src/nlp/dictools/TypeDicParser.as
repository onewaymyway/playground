package nlp.dictools 
{
	import nlp.WordOne;
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
			return typeO;
		}
		public var wordDic:Object;
		public var wordList:Array;
		public static const Tab:String = "	";
		public function initByTxt(txt:String):void
		{
			wordList = [];
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
				wordList.push(createWordOneByTypeO(tWordO));
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
			rst.types = [];
			rst.typecns = [];
			var i:int, len:int;
			len = arr.length;
			var score:Number;
			var ttype:String;
			for (i = 1; i < len; i += 2)
			{
				score = parseInt(arr[i + 1]);
				ttype = arr[i];
				rst.type[ttype] = score;
				rst.type[TypeDefine.getCHType(ttype)] = score;
				rst.types.push(ttype);
				rst.typecns.push(TypeDefine.getCHType(ttype));
			}
			
			return rst;
		}
		
		public function createWordOneByTypeO(typeO:Object):WordOne
		{
			var rst:WordOne;
			rst = new WordOne();
			rst.word = typeO.word;
			return rst;
		}
	}

}