package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Profiler 
	{
		
		public function Profiler() 
		{
			
		}
		public static const DependDomains:Array=[Runtime,Debugger];
  	
  		/**
  		 * consoleProfileFinished
  		 * @param id:string optional:{#@optional#} {#@description#}
  		 * @param location:{#@type#} optional:{#@optional#} Location of console.profileEnd().
  		 * @param profile:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param title:string optional:true Profile title passed as an argument to console.profile().
  		 * @return 
  		 */
  		public static const consoleProfileFinished:String = "Profiler.consoleProfileFinished";
  	
  		/**
  		 * consoleProfileStarted
  		 * Sent when new profile recording is started using console.profile() call.
  		 * @param id:string optional:{#@optional#} {#@description#}
  		 * @param location:{#@type#} optional:{#@optional#} Location of console.profile().
  		 * @param title:string optional:true Profile title passed as an argument to console.profile().
  		 * @return 
  		 */
  		public static const consoleProfileStarted:String = "Profiler.consoleProfileStarted";
  		/**
  		 * disable
  		 * @return 
  		 */	
  		public static function disable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Profiler.disable", paramO);
  		}
  		
  		/**
  		 * enable
  		 * @return 
  		 */	
  		public static function enable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Profiler.enable", paramO);
  		}
  		
  		/**
  		 * getBestEffortCoverage
  		 * Collect coverage data for the current isolate. The coverage data may be incomplete due to
  	garbage collection.
  		 * @return result:array optional:{#@optional#} Coverage data for the current isolate.
  		 */	
  		public static function getBestEffortCoverage(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Profiler.getBestEffortCoverage", paramO);
  		}
  		
  		/**
  		 * setSamplingInterval
  		 * Changes CPU profiler sampling interval. Must be called before CPU profiles recording started.
  		 * @param interval:integer optional:{#@optional#} New sampling interval in microseconds.
  		 * @return 
  		 */	
  		public static function setSamplingInterval(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Profiler.setSamplingInterval", paramO);
  		}
  		
  		/**
  		 * start
  		 * @return 
  		 */	
  		public static function start(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Profiler.start", paramO);
  		}
  		
  		/**
  		 * startPreciseCoverage
  		 * Enable precise code coverage. Coverage data for JavaScript executed before enabling precise code
  	coverage may be incomplete. Enabling prevents running optimized code and resets execution
  	counters.
  		 * @param callCount:boolean optional:true Collect accurate call counts beyond simple 'covered' or 'not covered'.
  		 * @param detailed:boolean optional:true Collect block-based coverage.
  		 * @return 
  		 */	
  		public static function startPreciseCoverage(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Profiler.startPreciseCoverage", paramO);
  		}
  		
  		/**
  		 * startTypeProfile
  		 * Enable type profile.
  		 * @return 
  		 */	
  		public static function startTypeProfile(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Profiler.startTypeProfile", paramO);
  		}
  		
  		/**
  		 * stop
  		 * @return profile:{#@type#} optional:{#@optional#} Recorded profile.
  		 */	
  		public static function stop(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Profiler.stop", paramO);
  		}
  		
  		/**
  		 * stopPreciseCoverage
  		 * Disable precise code coverage. Disabling releases unnecessary execution count records and allows
  	executing optimized code.
  		 * @return 
  		 */	
  		public static function stopPreciseCoverage(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Profiler.stopPreciseCoverage", paramO);
  		}
  		
  		/**
  		 * stopTypeProfile
  		 * Disable type profile. Disabling releases type profile data collected so far.
  		 * @return 
  		 */	
  		public static function stopTypeProfile(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Profiler.stopTypeProfile", paramO);
  		}
  		
  		/**
  		 * takePreciseCoverage
  		 * Collect coverage data for the current isolate, and resets execution counters. Precise code
  	coverage needs to have started.
  		 * @return result:array optional:{#@optional#} Coverage data for the current isolate.
  		 */	
  		public static function takePreciseCoverage(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Profiler.takePreciseCoverage", paramO);
  		}
  		
  		/**
  		 * takeTypeProfile
  		 * Collect type profile.
  		 * @return result:array optional:{#@optional#} Type profile for all scripts since startTypeProfile() was turned on.
  		 */	
  		public static function takeTypeProfile(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Profiler.takeTypeProfile", paramO);
  		}
  		
	}

}