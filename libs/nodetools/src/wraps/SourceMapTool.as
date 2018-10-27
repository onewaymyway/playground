package wraps 
{
	/**
	 * ...
	 * @author ww
	 */
	public class SourceMapTool 
	{
		public var version:int = 3;
		public var file:String = "min.js";
		public var names:Array = [];
		private var _nameDic:Object={};
		public var sourceRoot:String = "";
		public var sources:Array = [];
		private var _sourcesDic:Object = { };
		public var sourcesContent:Array;
		public var mappings:String;
		
		private var _mappings:Array = [];
		public function SourceMapTool() 
		{
			
		}
		
		public function addSourceFile(name:String):int
		{
			if (!_sourcesDic.hasOwnProperty(name))
			{
				sources.push(name);
				_sourcesDic[name] = sources.length - 1;
			}
			return _sourcesDic[name];
		}
		
		private function getFileNameIndex(name:String):int
		{
			if (!name) return 0;
			return addSourceFile(name);
		}
		
		
		public function addName(name:String):int
		{
			if (!_nameDic.hasOwnProperty(name))
			{
				names.push(name);
				_nameDic[name] = names.length - 1;
			}
			return _nameDic[name];
		}
		
		private function getNameIndex(name:String):int
		{
			if (!name) name = "";
			return addName(name);
		}
		public function createSouceMap():Object
		{
			var obj:Object;
			obj = { };
			var keys:Array = ["version", "file", "names", "sourceRoot", "sources"];
			var i:int, len:int;
			len = keys.length;
			var key:String;
			for (i = 0; i < len; i++)
			{
				key = keys[i];
				obj[key] = this[key];
			}
			
			obj["mappings"] = createMappingStr();
			
			return obj;
		}
		
		public function createSourceMapStr():String
		{
			return JSON.stringify(createSouceMap());
		}
		public function addLine(LineNum:int=-1):Array
		{
			if (LineNum < 0)
			{
				LineNum = _mappings.length;
			}
			if (!_mappings[LineNum])
			{
				var i:int, len:int;
				len = LineNum + 1;
				for (i = _mappings.length; i< len; i++)
				{
					_mappings.push([]);
				}
			}
			return _mappings[LineNum];
		}
		/**
		 * 添加代码映射
		 * @param	FileColumn 当前代码列
		 * @param	SourceFileLine 原代码行
		 * @param	SourceFileColumn 原代码列
		 * @param	nameIndex 名字索引
		 * @param	sourceFileID 原文件索引
		 */
		public function addMappingPoint(FileColumn:int, SourceFileLine:int=-1, SourceFileColumn:int=-1, nameIndex:int=-1,sourceFileID:int=0):void
		{
			var line:Array;
			line = _mappings[_mappings.length - 1];
			if (SourceFileLine >= 0)
			{
				if (nameIndex >= 0)
				{
					line.push([FileColumn, sourceFileID, SourceFileLine, SourceFileColumn,nameIndex]);
				}else
				{
					line.push([FileColumn, sourceFileID, SourceFileLine, SourceFileColumn]);
				}
				
			}else
			{
				line.push([FileColumn]);
			}
		}
		
		/**
		 * 添加代码映射
		 * @param	FileColumn 代码列
		 * @param	SourceFileLine 原代码行
		 * @param	SourceFileColumn 原代码列
		 * @param	name 原代码名
		 * @param	SourceFile 原代码文件
		 */
		public function addMappintPointEx(FileColumn:int, SourceFileLine:int = -1, SourceFileColumn:int = -1, name:String = null, SourceFile:String = null):void
		{
			addMappingPoint(FileColumn, SourceFileLine, SourceFileColumn, name?getNameIndex(name):-1, getFileNameIndex(SourceFile));
		}
		
		private var _temp:Array=[];
		private function createPosLine(curPosArr:Array, prePosArr:Array):String
		{
			_temp.length = curPosArr.length;
			var i:int, len:int;
			len = curPosArr.length;
			for (i = 0; i < len; i++)
			{
				_temp[i] = curPosArr[i] - prePosArr[i];
			}
			return Base64VlqTool.encodeVlqArr(_temp);
		}
		private function createMappingStr():String
		{
			var rst:String;
			rst = "";
			var i:int, len:int;
			var prePosLine:Array;
			var curPosLine:Array;
			len = _mappings.length;
			var lineStrs:Array;
			lineStrs = [];
			var j:int, jLen:int;
			var tLineArr:Array;
			var tLineStrs:Array;
			prePosLine = [0,0,0,0,0];

			
			for (i = 0; i < len; i++)
			{
				tLineArr = _mappings[i];
				if (tLineArr && tLineArr.length > 0)
				{
					tLineStrs = [];
					jLen = tLineArr.length;
					for(j = 0; j < jLen; j++)
					{
						curPosLine = tLineArr[j];
						tLineStrs.push(createPosLine(curPosLine, prePosLine));
						prePosLine = curPosLine;
					}
					lineStrs.push(tLineStrs.join(","));
				}else
				{
					lineStrs.push("");
				}
			}
			return lineStrs.join(";");
		}
	}

}