package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Tethering 
	{
		
		public function Tethering() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  		/**
  		 * accepted
  		 * Informs that port was successfully bound and got a specified connection id.
  		 * @param port:integer optional:{#@optional#} Port number that was successfully bound.
  		 * @param connectionId:string optional:{#@optional#} Connection id to be used.
  		 * @return 
  		 */
  		public static const accepted:String = "Tethering.accepted";
  		/**
  		 * bind
  		 * Request browser port binding.
  		 * @param port:integer optional:{#@optional#} Port number to bind.
  		 * @return 
  		 */	
  		public static function bind(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Tethering.bind", paramO);
  		}
  		
  		/**
  		 * unbind
  		 * Request browser port unbinding.
  		 * @param port:integer optional:{#@optional#} Port number to unbind.
  		 * @return 
  		 */	
  		public static function unbind(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Tethering.unbind", paramO);
  		}
  		
	}

}