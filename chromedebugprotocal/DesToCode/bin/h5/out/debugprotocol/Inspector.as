package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Inspector 
	{
		
		public function Inspector() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  		/**
  		 * detached
  		 * Fired when remote debugging connection is about to be terminated. Contains detach reason.
  		 * @param reason:string optional:{#@optional#} The reason why connection has been terminated.
  		 * @return 
  		 */
  		public static const detached:String = "Inspector.detached";
  	
  		/**
  		 * targetCrashed
  		 * Fired when debugging target has crashed
  		 * @return 
  		 */
  		public static const targetCrashed:String = "Inspector.targetCrashed";
  	
  		/**
  		 * targetReloadedAfterCrash
  		 * Fired when debugging target has reloaded after crash
  		 * @return 
  		 */
  		public static const targetReloadedAfterCrash:String = "Inspector.targetReloadedAfterCrash";
  		/**
  		 * disable
  		 * Disables inspector domain notifications.
  		 * @return 
  		 */	
  		public static function disable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Inspector.disable", paramO);
  		}
  		
  		/**
  		 * enable
  		 * Enables inspector domain notifications.
  		 * @return 
  		 */	
  		public static function enable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Inspector.enable", paramO);
  		}
  		
	}

}