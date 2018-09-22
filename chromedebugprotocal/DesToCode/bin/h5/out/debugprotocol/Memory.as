package debugprotocol 
{



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
  		public static const getDOMCounters:String = "Memory.getDOMCounters";
  	
  		/**
  		 * prepareForLeakDetection
  		 * @return 
  		 */
  		public static const prepareForLeakDetection:String = "Memory.prepareForLeakDetection";
  	
  		/**
  		 * setPressureNotificationsSuppressed
  		 * Enable/disable suppressing memory pressure notifications in all processes.
  		 * @param suppressed:boolean optional:{#@optional#} If true, memory pressure notifications will be suppressed.
  		 * @return 
  		 */
  		public static const setPressureNotificationsSuppressed:String = "Memory.setPressureNotificationsSuppressed";
  	
  		/**
  		 * simulatePressureNotification
  		 * Simulate a memory pressure notification in all processes.
  		 * @param level:{#@type#} optional:{#@optional#} Memory pressure level of the notification.
  		 * @return 
  		 */
  		public static const simulatePressureNotification:String = "Memory.simulatePressureNotification";
  	
  		/**
  		 * startSampling
  		 * Start collecting native memory profile.
  		 * @param samplingInterval:integer optional:true Average number of bytes between samples.
  		 * @param suppressRandomness:boolean optional:true Do not randomize intervals between samples.
  		 * @return 
  		 */
  		public static const startSampling:String = "Memory.startSampling";
  	
  		/**
  		 * stopSampling
  		 * Stop collecting native memory profile.
  		 * @return 
  		 */
  		public static const stopSampling:String = "Memory.stopSampling";
  	
  		/**
  		 * getAllTimeSamplingProfile
  		 * Retrieve native memory allocations profile
  	collected since renderer process startup.
  		 * @return profile:{#@type#} optional:{#@optional#} {#@description#}
  		 */
  		public static const getAllTimeSamplingProfile:String = "Memory.getAllTimeSamplingProfile";
  	
  		/**
  		 * getBrowserSamplingProfile
  		 * Retrieve native memory allocations profile
  	collected since browser process startup.
  		 * @return profile:{#@type#} optional:{#@optional#} {#@description#}
  		 */
  		public static const getBrowserSamplingProfile:String = "Memory.getBrowserSamplingProfile";
  	
  		/**
  		 * getSamplingProfile
  		 * Retrieve native memory allocations profile collected since last
  	`startSampling` call.
  		 * @return profile:{#@type#} optional:{#@optional#} {#@description#}
  		 */
  		public static const getSamplingProfile:String = "Memory.getSamplingProfile";
	}

}