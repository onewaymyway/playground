/*[IF-FLASH]*/package nodetools.devices 
{
	
	

	/**
	 * ...
	 * @author ww
	 */
	public class File 
	{

		public static var applicationDirectory:File=new File("");
		public static var applicationStorageDirectory:File=new File("");
		public static var userDirectory:File=new File("");
		
		public var nativePath:String;
		public function File(path:String) 
		{
			nativePath=path;
		}
		
		
		public function get extension():String
		{
			 return FileTools.getExtensionName(nativePath);
		}
		
		public function get isDirectory():Boolean
		{
			return FileTools.isDirectory(nativePath);
		}
		
		public function get exists():Boolean
		{
			return FileTools.exist(nativePath);
		}
		
		public function get name():String
		{
			return FileTools.getFileNameWithExtension(nativePath);
		}
		
		public function get parent():File
		{
			return new File(FileTools.getParent(nativePath));
		}
		public function copyTo(path:String,overwrite:Boolean=false):void
		{
			FileTools.copyE(nativePath,path);
		}
		
		public function deleteFile():void
		{
			FileTools.removeE(nativePath);
		}
		public function  moveToTrash():void
		{
			deleteFile();
		}
		public function  getRelativePath(path:String):String
		{
			return FileTools.getRelativePath(nativePath,path);
		}
		public function moveTo(path:String,overwrite:Boolean=false):void
		{
			FileTools.rename(nativePath,path);
		}
		
		public function  resolvePath(path:String):File
		{
			return new File(FileTools.getPath(nativePath,path));
		}
	}

}