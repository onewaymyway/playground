package debugprotocol.Tracing 
{



	public class Tracing 
	{
		
		public function Tracing() 
		{
			
		}
		public static const DependDomains:Array=[IO];
  	
  		/**
  		 * bufferUsage
  		 * @param percentFull:number optional:true A number in range [0..1] that indicates the used size of event buffer as a fraction of its
  	total size.
  		 * @param eventCount:number optional:true An approximate number of events in the trace log.
  		 * @param value:number optional:true A number in range [0..1] that indicates the used size of event buffer as a fraction of its
  	total size.
  		 * @return 
  		 */
  		public static const bufferUsage:String = "Tracing.bufferUsage";
  	
  		/**
  		 * dataCollected
  		 * Contains an bucket of collected trace events. When tracing is stopped collected events will be
  	send as a sequence of dataCollected events followed by tracingComplete event.
  		 * @param value:array optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const dataCollected:String = "Tracing.dataCollected";
  	
  		/**
  		 * tracingComplete
  		 * Signals that tracing is stopped and there is no trace buffers pending flush, all data were
  	delivered via dataCollected events.
  		 * @param stream:{#@type#} optional:true A handle of the stream that holds resulting trace data.
  		 * @param streamCompression:{#@type#} optional:true Compression format of returned stream.
  		 * @return 
  		 */
  		public static const tracingComplete:String = "Tracing.tracingComplete";
  	
  		/**
  		 * end
  		 * Stop trace events collection.
  		 * @return 
  		 */
  		public static const end:String = "Tracing.end";
  	
  		/**
  		 * getCategories
  		 * Gets supported tracing categories.
  		 * @return categories:array optional:{#@optional#} A list of supported tracing categories.
  		 */
  		public static const getCategories:String = "Tracing.getCategories";
  	
  		/**
  		 * recordClockSyncMarker
  		 * Record a clock sync marker in the trace.
  		 * @param syncId:string optional:{#@optional#} The ID of this clock sync marker
  		 * @return 
  		 */
  		public static const recordClockSyncMarker:String = "Tracing.recordClockSyncMarker";
  	
  		/**
  		 * requestMemoryDump
  		 * Request a global memory dump.
  		 * @return dumpGuid:string optional:{#@optional#} GUID of the resulting global memory dump.
  		 */
  		public static const requestMemoryDump:String = "Tracing.requestMemoryDump";
  	
  		/**
  		 * start
  		 * Start trace events collection.
  		 * @param categories:string optional:true Category/tag filter
  		 * @param options:string optional:true Tracing options
  		 * @param bufferUsageReportingInterval:number optional:true If set, the agent will issue bufferUsage events at this interval, specified in milliseconds
  		 * @param transferMode:string optional:true Whether to report trace events as series of dataCollected events or to save trace to a
  	stream (defaults to `ReportEvents`).
  		 * @param streamCompression:{#@type#} optional:true Compression format to use. This only applies when using `ReturnAsStream`
  	transfer mode (defaults to `none`)
  		 * @param traceConfig:{#@type#} optional:true {#@description#}
  		 * @return 
  		 */
  		public static const start:String = "Tracing.start";
	}

}