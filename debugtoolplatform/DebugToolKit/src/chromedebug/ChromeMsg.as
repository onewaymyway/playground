package chromedebug 
{
	/**
	 * ...
	 * @author ww
	 */
	public class ChromeMsg 
	{
		
		public function ChromeMsg() 
		{
			
		}
		private static var _msgID:int = 1;
		public static function createCmd(method:String, params:Object):Object
		{
			var dataO:Object;
			dataO = { };
			dataO.id = _msgID;
			dataO.method = method;
			if(params)
			dataO.params = params;
			_msgID++;
			return dataO;
		}
	}

}