package  
{
	import filetoolkit.FileKit;
	import laya.utils.Handler;
	/**
	 * ...
	 * @author ww
	 */
	public class Test 
	{
		
		public function Test() 
		{
			Laya.init(1000, 900);
			test();
		}
		private var fileKit:FileKit;
		private function test():void
		{
			
			fileKit = new FileKit();
			FileKit.root = "http://127.0.0.1:8081";
			fileKit.username = "test";
			fileKit.pwd = "test123";
			fileKit.on(FileKit.Logined,this,onLogin);
			fileKit.login();
		}
		
		private function onLogin():void
		{
			fileKit.getFileList("./",Handler.create(this,onGetFileList));
		}
		
		private function onGetFileList(dataO:Object):void
		{
			debugger;
			if (dataO.success)
			{
				dataO = dataO.data;
				var root:String;
				root = dataO.root;
				var childs:Array;
				childs = dataO.childs;
				if (childs && childs[0])
				{
					var filePath:String;
					filePath = root + childs[0];
					fileKit.getFile(filePath, Handler.create(this, onGetFile));
				}
				
			}
		}
		
		private var addPath:String = "bb/cc.abc";
		private function onGetFile(dataO:Object):void
		{
			debugger;
			trace("onGetFile", dataO);
			fileKit.addFile(addPath, "hello1", Handler.create(this, onAddFile));
		}
		
		private function onAddFile(dataO:Object):void
		{
			trace("onAddFile:", dataO);
			fileKit.getFile(addPath, Handler.create(this, onGetAddedFile));
		}
		
		private function onGetAddedFile(dataO:Object):void
		{
			trace("onGetAddedFile:", dataO);
		}
		private function onClick():void
		{
			
		}
		
	}

}