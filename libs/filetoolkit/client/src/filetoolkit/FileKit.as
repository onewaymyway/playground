package filetoolkit 
{
	/**
	 * ...
	 * @author ww
	 */
	public class FileKit 
	{
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
			dataO.pwd = pwd;
			HttpRequestTool.request(root, dataO);
		}
		
	}

}