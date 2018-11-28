package  
{
	import filetoolkit.FileKit;
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
		
		private function test():void
		{
			var fileKit:FileKit;
			fileKit = new FileKit();
			FileKit.root = "http://127.0.0.1:8081";
			fileKit.username = "test";
			fileKit.pwd = "test123";
			fileKit.login();
		}
		
	}

}