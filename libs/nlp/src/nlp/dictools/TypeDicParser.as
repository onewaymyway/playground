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
		
		public function getWordTypeStr(word:String):String
		{
			var typeO:Object;
			typeO = getWordType(word);
			if (!typeO) return "unknow";
			//return typeO.types[0];
			return typeO.types.join(";");
		}
		
		public function getWordTypeCNStr(word:String):String
		{
			var typeO:Object;
			typeO = getWordType(word);
			if (!typeO) return "unknow";
			return typeO.typecns[0];
			return typeO.typecns.join(";");
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
			rst.types.sort();
			return rst;
		}
		
		public function createWordOneByTypeO(typeO:Object):WordOne
		{
			var rst:WordOne;
			rst = new WordOne();
			rst.word = typeO.word;
			return rst;
		}
		
		public function addType(wordList:Array, types:Array, typecns:Array = null):void
		{
			var tWordO:Object;
			var i:int, len:int;
			len = wordList.length;
			for (i = 0; i < len; i++)
			{
				tWordO = { };
				tWordO.word = wordList[i];
				tWordO.type = { };
				tWordO.types = types;
				tWordO.typecns = typecns || types;
				if(!wordDic[tWordO.word])
				wordDic[tWordO.word] = tWordO;
			}
		}
		
		public function addDefaultTypes():void
		{
			this.addType([":", "/", ".", "。"], ["punk"], ["标点"]);
			this.addType(["\t"], ["TAB"], ["TAB"]);
			this.addType([" ", "　"], ["EMPTY"], ["空格"]);
			this.addType(["\n"], ["\\n"], ["换行"]);
			this.addType(["\r"], ["\\r"], ["回车"]);
		}
	}

}