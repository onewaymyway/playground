package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Schema 
	{
		
		public function Schema() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  		/**
  		 * getDomains
  		 * Returns supported domains.
  		 * @return domains:array optional:{#@optional#} List of supported domains.
  		 */	
  		public static function getDomains(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Schema.getDomains", paramO);
  		}
  		
	}

}