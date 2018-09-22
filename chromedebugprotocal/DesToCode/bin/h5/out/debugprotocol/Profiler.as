package debugprotocol 
{



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
  		public static const disable:String = "Profiler.disable";
  	
  		/**
  		 * enable
  		 * @return 
  		 */
  		public static const enable:String = "Profiler.enable";
  	
  		/**
  		 * getBestEffortCoverage
  		 * Collect coverage data for the current isolate. The coverage data may be incomplete due to
  	garbage collection.
  		 * @return result:array optional:{#@optional#} Coverage data for the current isolate.
  		 */
  		public static const getBestEffortCoverage:String = "Profiler.getBestEffortCoverage";
  	
  		/**
  		 * setSamplingInterval
  		 * Changes CPU profiler sampling interval. Must be called before CPU profiles recording started.
  		 * @param interval:integer optional:{#@optional#} New sampling interval in microseconds.
  		 * @return 
  		 */
  		public static const setSamplingInterval:String = "Profiler.setSamplingInterval";
  	
  		/**
  		 * start
  		 * @return 
  		 */
  		public static const start:String = "Profiler.start";
  	
  		/**
  		 * startPreciseCoverage
  		 * Enable precise code coverage. Coverage data for JavaScript executed before enabling precise code
  	coverage may be incomplete. Enabling prevents running optimized code and resets execution
  	counters.
  		 * @param callCount:boolean optional:true Collect accurate call counts beyond simple 'covered' or 'not covered'.
  		 * @param detailed:boolean optional:true Collect block-based coverage.
  		 * @return 
  		 */
  		public static const startPreciseCoverage:String = "Profiler.startPreciseCoverage";
  	
  		/**
  		 * startTypeProfile
  		 * Enable type profile.
  		 * @return 
  		 */
  		public static const startTypeProfile:String = "Profiler.startTypeProfile";
  	
  		/**
  		 * stop
  		 * @return profile:{#@type#} optional:{#@optional#} Recorded profile.
  		 */
  		public static const stop:String = "Profiler.stop";
  	
  		/**
  		 * stopPreciseCoverage
  		 * Disable precise code coverage. Disabling releases unnecessary execution count records and allows
  	executing optimized code.
  		 * @return 
  		 */
  		public static const stopPreciseCoverage:String = "Profiler.stopPreciseCoverage";
  	
  		/**
  		 * stopTypeProfile
  		 * Disable type profile. Disabling releases type profile data collected so far.
  		 * @return 
  		 */
  		public static const stopTypeProfile:String = "Profiler.stopTypeProfile";
  	
  		/**
  		 * takePreciseCoverage
  		 * Collect coverage data for the current isolate, and resets execution counters. Precise code
  	coverage needs to have started.
  		 * @return result:array optional:{#@optional#} Coverage data for the current isolate.
  		 */
  		public static const takePreciseCoverage:String = "Profiler.takePreciseCoverage";
  	
  		/**
  		 * takeTypeProfile
  		 * Collect type profile.
  		 * @return result:array optional:{#@optional#} Type profile for all scripts since startTypeProfile() was turned on.
  		 */
  		public static const takeTypeProfile:String = "Profiler.takeTypeProfile";
	}

}