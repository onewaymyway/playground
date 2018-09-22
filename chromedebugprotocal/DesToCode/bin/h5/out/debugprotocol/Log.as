package debugprotocol.Log 
{



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
  		public static const clear:String = "Log.clear";
  	
  		/**
  		 * disable
  		 * Disables log domain, prevents further log entries from being reported to the client.
  		 * @return 
  		 */
  		public static const disable:String = "Log.disable";
  	
  		/**
  		 * enable
  		 * Enables log domain, sends the entries collected so far to the client by means of the
  	`entryAdded` notification.
  		 * @return 
  		 */
  		public static const enable:String = "Log.enable";
  	
  		/**
  		 * startViolationsReport
  		 * start violation reporting.
  		 * @param config:array optional:{#@optional#} Configuration for violations.
  		 * @return 
  		 */
  		public static const startViolationsReport:String = "Log.startViolationsReport";
  	
  		/**
  		 * stopViolationsReport
  		 * Stop violation reporting.
  		 * @return 
  		 */
  		public static const stopViolationsReport:String = "Log.stopViolationsReport";
	}

}