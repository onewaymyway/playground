package webfile 
{
	import laya.utils.Handler;
	/**
	 * ...
	 * @author ww
	 */
	public class FileReaderTool 
	{
		
		public function FileReaderTool() 
		{
			
		}
		
		public static function readAsString(file:*,complete:Handler):void
		{
			var reader:Object;
			__JS__("reader= new FileReader();");
			reader.onload = function(e:*):void
			{
				complete.runWith(reader.result);
			}
			reader.readAsText(file);
		}
		//public static function getFile(file:Object, complete:Handler ):void
		//{
			//var reader:Object;
			//__JS__("reader= new FileReader();");
			//reader.readAsDataURL(file);
			//
			//reader.onload = function(e:*):void
			//{
				//
				//var txt:Texture;
				//txt = new Texture();
				//txt.load(reader.result);
				//sprite.graphics.drawTexture(txt, 0, 0,width,height);
			//}
			//return sprite;
		//}
	}

}