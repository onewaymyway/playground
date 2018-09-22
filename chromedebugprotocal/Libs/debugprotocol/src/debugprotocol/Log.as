package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Log 
	{
		
		public function Log() 
		{
			
		}
		public static const DependDomains:Array=[Runtime,Network];
  	
  		/**
  		 * entryAdded
  		 * Issued when new message was logged.
  		 * @param entry:{#@type#} optional:{#@optional#} The entry.
  		 * @return 
  		 */
  		public static const entryAdded:String = "Log.entryAdded";
  		/**
  		 * clear
  		 * Clears the log.
  		 * @return 
  		 */	
  		public static function clear(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Log.clear", paramO);
  		}
  		
  		/**
  		 * disable
  		 * Disables log domain, prevents further log entries from being reported to the client.
  		 * @return 
  		 */	
  		public static function disable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Log.disable", paramO);
  		}
  		
  		/**
  		 * enable
  		 * Enables log domain, sends the entries collected so far to the client by means of the
  	`entryAdded` notification.
  		 * @return 
  		 */	
  		public static function enable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Log.enable", paramO);
  		}
  		
  		/**
  		 * startViolationsReport
  		 * start violation reporting.
  		 * @param config:array optional:{#@optional#} Configuration for violations.
  		 * @return 
  		 */	
  		public static function startViolationsReport(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Log.startViolationsReport", paramO);
  		}
  		
  		/**
  		 * stopViolationsReport
  		 * Stop violation reporting.
  		 * @return 
  		 */	
  		public static function stopViolationsReport(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Log.stopViolationsReport", paramO);
  		}
  		
	}

}