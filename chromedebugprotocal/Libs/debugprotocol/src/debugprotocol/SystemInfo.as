package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class SystemInfo 
	{
		
		public function SystemInfo() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  		/**
  		 * getInfo
  		 * Returns information about the system.
  		 * @return gpu:{#@type#} optional:{#@optional#} Information about the GPUs on the system.
  		 */	
  		public static function getInfo(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("SystemInfo.getInfo", paramO);
  		}
  		
	}

}