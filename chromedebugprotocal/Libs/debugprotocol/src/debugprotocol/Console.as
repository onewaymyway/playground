package debugprotocol.Console 
{



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
  		public static const clearMessages:String = "Console.clearMessages";
  	
  		/**
  		 * disable
  		 * Disables console domain, prevents further console messages from being reported to the client.
  		 * @return 
  		 */
  		public static const disable:String = "Console.disable";
  	
  		/**
  		 * enable
  		 * Enables console domain, sends the messages collected so far to the client by means of the
  	`messageAdded` notification.
  		 * @return 
  		 */
  		public static const enable:String = "Console.enable";
	}

}