package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Memory 
	{
		
		public function Memory() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  		/**
  		 * getDOMCounters
  		 * @return documents:integer optional:{#@optional#} {#@description#}
  		 */	
  		public static function getDOMCounters(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Memory.getDOMCounters", paramO);
  		}
  		
  		/**
  		 * prepareForLeakDetection
  		 * @return 
  		 */	
  		public static function prepareForLeakDetection(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Memory.prepareForLeakDetection", paramO);
  		}
  		
  		/**
  		 * setPressureNotificationsSuppressed
  		 * Enable/disable suppressing memory pressure notifications in all processes.
  		 * @param suppressed:boolean optional:{#@optional#} If true, memory pressure notifications will be suppressed.
  		 * @return 
  		 */	
  		public static function setPressureNotificationsSuppressed(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Memory.setPressureNotificationsSuppressed", paramO);
  		}
  		
  		/**
  		 * simulatePressureNotification
  		 * Simulate a memory pressure notification in all processes.
  		 * @param level:{#@type#} optional:{#@optional#} Memory pressure level of the notification.
  		 * @return 
  		 */	
  		public static function simulatePressureNotification(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Memory.simulatePressureNotification", paramO);
  		}
  		
  		/**
  		 * startSampling
  		 * Start collecting native memory profile.
  		 * @param samplingInterval:integer optional:true Average number of bytes between samples.
  		 * @param suppressRandomness:boolean optional:true Do not randomize intervals between samples.
  		 * @return 
  		 */	
  		public static function startSampling(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Memory.startSampling", paramO);
  		}
  		
  		/**
  		 * stopSampling
  		 * Stop collecting native memory profile.
  		 * @return 
  		 */	
  		public static function stopSampling(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Memory.stopSampling", paramO);
  		}
  		
  		/**
  		 * getAllTimeSamplingProfile
  		 * Retrieve native memory allocations profile
  	collected since renderer process startup.
  		 * @return profile:{#@type#} optional:{#@optional#} {#@description#}
  		 */	
  		public static function getAllTimeSamplingProfile(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Memory.getAllTimeSamplingProfile", paramO);
  		}
  		
  		/**
  		 * getBrowserSamplingProfile
  		 * Retrieve native memory allocations profile
  	collected since browser process startup.
  		 * @return profile:{#@type#} optional:{#@optional#} {#@description#}
  		 */	
  		public static function getBrowserSamplingProfile(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Memory.getBrowserSamplingProfile", paramO);
  		}
  		
  		/**
  		 * getSamplingProfile
  		 * Retrieve native memory allocations profile collected since last
  	`startSampling` call.
  		 * @return profile:{#@type#} optional:{#@optional#} {#@description#}
  		 */	
  		public static function getSamplingProfile(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Memory.getSamplingProfile", paramO);
  		}
  		
	}

}