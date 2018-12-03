package webfile 
{
	import laya.debug.tools.StringTool;
	/**
	 * ...
	 * @author ww
	 */
	public class FilePathUtils 
	{
		
		public function FilePathUtils() 
		{
			
		}
		
		/**
		 * 判断路径是否是绝对路径 
		 * @param path
		 * @return 
		 * 
		 */
		public static function isAbsPath(path:String):Boolean
		{
			if(!path) return false;
			if(path.indexOf(":")>0) return true;
			if(path.substr(0,1)=="/") return true;
			return false;
		}
		
		
		/**
		 * 获取扩展名 
		 * @param path
		 * @return 
		 * 
		 */
		public static function getExtensionName(path:String):String
		{
			if (path == null)
				return null;
			var a:Array = path.split(".");
			var file:String = a[a.length - 1];
			return file;
		}
		
		/**
		 * 获取带扩展名的文件名 
		 * @param path
		 * @return 
		 * 
		*/
		public static function getFileNameWithExtension(path:String):String
		{
			if (path == null)
				return null;
			path = adptToCommonUrl(path);
			var a:Array = path.split("/");
			var file:String = a[a.length - 1];
			return file;
		}
		
		public static function adptToCommonUrl(url:String):String
		{
			return StringTool.getReplace(url,"\\\\","/");
		}
		
		public static function getParent(url:String):String
		{
			url = adptToCommonUrl(url);
			var a:Array;
			a = url.split("/");
			a.pop();
			return a.join("/");
		}
	}

}