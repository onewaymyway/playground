package filetoolkit 
{
	import laya.events.EventDispatcher;
	import laya.utils.Handler;
	/**
	 * ...
	 * @author ww
	 */
	public class FileKit extends EventDispatcher
	{
		public static const Logined:String = "Logined";
		public static const LoginFail:String = "LoginFail";
		public static var root:String = "";
		public var username:String;
		public var pwd:String;
		public var token:String;
		public function FileKit() 
		{
			
		}
		
		public function login():void
		{
			var dataO:Object;
			dataO = { };
			dataO.action = "login";
			dataO.username = username;
			dataO.pwd = SMD5.md5(pwd,username);
			HttpRequestTool.request(root, dataO,Handler.create(this,onLogin));
		}
		
		private function onLogin(dataO:Object):void
		{
			//debugger;
			if (dataO.success)
			{
				token = dataO.data.token;
				event(Logined)
			}else
			{
				event(LoginFail);
			}
		}
		
		public function getFileList(path:String,completeHandler:Handler):void
		{
			var dataO:Object;
			dataO = { };
			dataO.action = "getFileList";
			dataO.token = token;
			dataO.path = path;
			HttpRequestTool.request(root, dataO,completeHandler);
		}
		
		public function getFile(path:String, completeHandler:Handler,isJson:Boolean=false):void
		{
			var dataO:Object;
			dataO = { };
			dataO.action = "getFile";
			dataO.token = token;
			dataO.path = path;
			HttpRequestTool.request(root, dataO,Handler.create(this,onGetFileComplete,[completeHandler,isJson]));
		}
		
		private function onGetFileComplete(completHandler:Handler, isJson:Boolean, dataO:Object):void
		{
			if (dataO.success&&dataO.data.success)
			{
				var content:String;
				content = dataO.data.content;
				if (isJson)
				{
					content = JSON.parse(content);
					
				}
				completHandler.runWith(content);
			}else
			{
				completHandler.runWith(null);
			}
		
		}
		
		public function addFile(path:String, content:*, completeHandler:Handler):void
		{
			if (content is Object)
			{
				content = JSON.stringify(content);
			}
			var dataO:Object;
			dataO = { };
			dataO.action = "addFile";
			dataO.token = token;
			dataO.path = path;
			dataO.content = content;
			HttpRequestTool.request(root, dataO,completeHandler);
		}
		
		public function addFolder(path:String, completeHandler:Handler):void
		{
			if (content is Object)
			{
				content = JSON.stringify(content);
			}
			var dataO:Object;
			dataO = { };
			dataO.action = "addFolder";
			dataO.token = token;
			dataO.path = path;
			HttpRequestTool.request(root, dataO,completeHandler);
		}
	}

}