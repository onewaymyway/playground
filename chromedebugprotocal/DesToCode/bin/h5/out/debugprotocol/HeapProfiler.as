package debugprotocol 
{



	public class HeapProfiler 
	{
		
		public function HeapProfiler() 
		{
			
		}
		public static const DependDomains:Array=[Runtime];
  	
  		/**
  		 * addHeapSnapshotChunk
  		 * @param chunk:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const addHeapSnapshotChunk:String = "HeapProfiler.addHeapSnapshotChunk";
  	
  		/**
  		 * heapStatsUpdate
  		 * If heap objects tracking has been started then backend may send update for one or more fragments
  		 * @param statsUpdate:array optional:{#@optional#} An array of triplets. Each triplet describes a fragment. The first integer is the fragment
  	index, the second integer is a total count of objects for the fragment, the third integer is
  	a total size of the objects for the fragment.
  		 * @return 
  		 */
  		public static const heapStatsUpdate:String = "HeapProfiler.heapStatsUpdate";
  	
  		/**
  		 * lastSeenObjectId
  		 * If heap objects tracking has been started then backend regularly sends a current value for last
  	seen object id and corresponding timestamp. If the were changes in the heap since last event
  	then one or more heapStatsUpdate events will be sent before a new lastSeenObjectId event.
  		 * @param lastSeenObjectId:integer optional:{#@optional#} {#@description#}
  		 * @param timestamp:number optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const lastSeenObjectId:String = "HeapProfiler.lastSeenObjectId";
  	
  		/**
  		 * reportHeapSnapshotProgress
  		 * @param done:integer optional:{#@optional#} {#@description#}
  		 * @param total:integer optional:{#@optional#} {#@description#}
  		 * @param finished:boolean optional:true {#@description#}
  		 * @return 
  		 */
  		public static const reportHeapSnapshotProgress:String = "HeapProfiler.reportHeapSnapshotProgress";
  	
  		/**
  		 * resetProfiles
  		 * @return 
  		 */
  		public static const resetProfiles:String = "HeapProfiler.resetProfiles";
  	
  		/**
  		 * addInspectedHeapObject
  		 * Enables console to refer to the node with given id via $x (see Command Line API for more details
  	$x functions).
  		 * @param heapObjectId:{#@type#} optional:{#@optional#} Heap snapshot object id to be accessible by means of $x command line API.
  		 * @return 
  		 */
  		public static const addInspectedHeapObject:String = "HeapProfiler.addInspectedHeapObject";
  	
  		/**
  		 * collectGarbage
  		 * @return 
  		 */
  		public static const collectGarbage:String = "HeapProfiler.collectGarbage";
  	
  		/**
  		 * disable
  		 * @return 
  		 */
  		public static const disable:String = "HeapProfiler.disable";
  	
  		/**
  		 * enable
  		 * @return 
  		 */
  		public static const enable:String = "HeapProfiler.enable";
  	
  		/**
  		 * getHeapObjectId
  		 * @param objectId:{#@type#} optional:{#@optional#} Identifier of the object to get heap object id for.
  		 * @return heapSnapshotObjectId:{#@type#} optional:{#@optional#} Id of the heap snapshot object corresponding to the passed remote object id.
  		 */
  		public static const getHeapObjectId:String = "HeapProfiler.getHeapObjectId";
  	
  		/**
  		 * getObjectByHeapObjectId
  		 * @param objectId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param objectGroup:string optional:true Symbolic group name that can be used to release multiple objects.
  		 * @return result:{#@type#} optional:{#@optional#} Evaluation result.
  		 */
  		public static const getObjectByHeapObjectId:String = "HeapProfiler.getObjectByHeapObjectId";
  	
  		/**
  		 * getSamplingProfile
  		 * @return profile:{#@type#} optional:{#@optional#} Return the sampling profile being collected.
  		 */
  		public static const getSamplingProfile:String = "HeapProfiler.getSamplingProfile";
  	
  		/**
  		 * startSampling
  		 * @param samplingInterval:number optional:true Average sample interval in bytes. Poisson distribution is used for the intervals. The
  	default value is 32768 bytes.
  		 * @return 
  		 */
  		public static const startSampling:String = "HeapProfiler.startSampling";
  	
  		/**
  		 * startTrackingHeapObjects
  		 * @param trackAllocations:boolean optional:true {#@description#}
  		 * @return 
  		 */
  		public static const startTrackingHeapObjects:String = "HeapProfiler.startTrackingHeapObjects";
  	
  		/**
  		 * stopSampling
  		 * @return profile:{#@type#} optional:{#@optional#} Recorded sampling heap profile.
  		 */
  		public static const stopSampling:String = "HeapProfiler.stopSampling";
  	
  		/**
  		 * stopTrackingHeapObjects
  		 * @param reportProgress:boolean optional:true If true 'reportHeapSnapshotProgress' events will be generated while snapshot is being taken
  	when the tracking is stopped.
  		 * @return 
  		 */
  		public static const stopTrackingHeapObjects:String = "HeapProfiler.stopTrackingHeapObjects";
  	
  		/**
  		 * takeHeapSnapshot
  		 * @param reportProgress:boolean optional:true If true 'reportHeapSnapshotProgress' events will be generated while snapshot is being taken.
  		 * @return 
  		 */
  		public static const takeHeapSnapshot:String = "HeapProfiler.takeHeapSnapshot";
	}

}