package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Console 
	{
		
		public function Console() 
		{
			
		}
		public static const DependDomains:Array=[Runtime];
  	
  		/**
  		 * messageAdded
  		 * Issued when new console message is added.
  		 * @param message:{#@type#} optional:{#@optional#} Console message that has been added.
  		 * @return 
  		 */
  		public static const messageAdded:String = "Console.messageAdded";
  		/**
  		 * clearMessages
  		 * Does nothing.
  		 * @return 
  		 */	
  		public static function clearMessages(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Console.clearMessages", paramO);
  		}
  		
  		/**
  		 * disable
  		 * Disables console domain, prevents further console messages from being reported to the client.
  		 * @return 
  		 */	
  		public static function disable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Console.disable", paramO);
  		}
  		
  		/**
  		 * enable
  		 * Enables console domain, sends the messages collected so far to the client by means of the
  	`messageAdded` notification.
  		 * @return 
  		 */	
  		public static function enable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Console.enable", paramO);
  		}
  		
	}

}