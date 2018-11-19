package nodetools 
{
	import nodetools.devices.FileManager;
	/**
	 * ...
	 * @author ww
	 */
	public class NodeJSTools 
	{
		
		public function NodeJSTools() 
		{
			
		}
		public static function require(str:String):*
		{
			__JS__("return require(str);");
		}
		public static function getArgv():Array
		{
			var argv:*;
			__JS__("argv = process.argv;");
			trace("argv:", argv);
			return argv;
		}
		public static function parseArgToObj(args:Array, start:int = 0, target:Object):void
		{
			var i:int, len:int;
			len = args.length;
			var tParam:String;
			var pArr:Array;
			for (i = start; i < len; i++) {
				tParam = args[i];
				if (tParam.indexOf("=") > 0) {
					pArr = tParam.split("=");
					if (target[pArr[0]] && typeof(target[pArr[0]]) == "number")
					{
						 pArr[1] = Sys.mParseFloat( pArr[1]);
					}
					trace(pArr);
					target[pArr[0]] = pArr[1];
				}
			}
		}
		public static function getMyPath():String
		{
			return __JS__("__dirname");
		}
		public static function eval(codeStr:String):*
		{
			return __JS__("eval(codeStr)");
		}
		
		public static function getAbsPath(path:String,root:String=null):String
		{
			if (path.indexOf(":") >= 0) return path;
			if (!root) root = getMyPath();
			return FileManager.getPath(root, path);
		}
	}

}