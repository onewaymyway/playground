package debugprotocol 
{



	public class LayerTree 
	{
		
		public function LayerTree() 
		{
			
		}
		public static const DependDomains:Array=[DOM];
  	
  		/**
  		 * layerPainted
  		 * @param layerId:{#@type#} optional:{#@optional#} The id of the painted layer.
  		 * @param clip:{#@type#} optional:{#@optional#} Clip rectangle.
  		 * @return 
  		 */
  		public static const layerPainted:String = "LayerTree.layerPainted";
  	
  		/**
  		 * layerTreeDidChange
  		 * @param layers:array optional:true Layer tree, absent if not in the comspositing mode.
  		 * @return 
  		 */
  		public static const layerTreeDidChange:String = "LayerTree.layerTreeDidChange";
  	
  		/**
  		 * compositingReasons
  		 * Provides the reasons why the given layer was composited.
  		 * @param layerId:{#@type#} optional:{#@optional#} The id of the layer for which we want to get the reasons it was composited.
  		 * @return compositingReasons:array optional:{#@optional#} A list of strings specifying reasons for the given layer to become composited.
  		 */
  		public static const compositingReasons:String = "LayerTree.compositingReasons";
  	
  		/**
  		 * disable
  		 * Disables compositing tree inspection.
  		 * @return 
  		 */
  		public static const disable:String = "LayerTree.disable";
  	
  		/**
  		 * enable
  		 * Enables compositing tree inspection.
  		 * @return 
  		 */
  		public static const enable:String = "LayerTree.enable";
  	
  		/**
  		 * loadSnapshot
  		 * Returns the snapshot identifier.
  		 * @param tiles:array optional:{#@optional#} An array of tiles composing the snapshot.
  		 * @return snapshotId:{#@type#} optional:{#@optional#} The id of the snapshot.
  		 */
  		public static const loadSnapshot:String = "LayerTree.loadSnapshot";
  	
  		/**
  		 * makeSnapshot
  		 * Returns the layer snapshot identifier.
  		 * @param layerId:{#@type#} optional:{#@optional#} The id of the layer.
  		 * @return snapshotId:{#@type#} optional:{#@optional#} The id of the layer snapshot.
  		 */
  		public static const makeSnapshot:String = "LayerTree.makeSnapshot";
  	
  		/**
  		 * profileSnapshot
  		 * @param snapshotId:{#@type#} optional:{#@optional#} The id of the layer snapshot.
  		 * @param minRepeatCount:integer optional:true The maximum number of times to replay the snapshot (1, if not specified).
  		 * @param minDuration:number optional:true The minimum duration (in seconds) to replay the snapshot.
  		 * @param clipRect:{#@type#} optional:true The clip rectangle to apply when replaying the snapshot.
  		 * @return timings:array optional:{#@optional#} The array of paint profiles, one per run.
  		 */
  		public static const profileSnapshot:String = "LayerTree.profileSnapshot";
  	
  		/**
  		 * releaseSnapshot
  		 * Releases layer snapshot captured by the back-end.
  		 * @param snapshotId:{#@type#} optional:{#@optional#} The id of the layer snapshot.
  		 * @return 
  		 */
  		public static const releaseSnapshot:String = "LayerTree.releaseSnapshot";
  	
  		/**
  		 * replaySnapshot
  		 * Replays the layer snapshot and returns the resulting bitmap.
  		 * @param snapshotId:{#@type#} optional:{#@optional#} The id of the layer snapshot.
  		 * @param fromStep:integer optional:true The first step to replay from (replay from the very start if not specified).
  		 * @param toStep:integer optional:true The last step to replay to (replay till the end if not specified).
  		 * @param scale:number optional:true The scale to apply while replaying (defaults to 1).
  		 * @return dataURL:string optional:{#@optional#} A data: URL for resulting image.
  		 */
  		public static const replaySnapshot:String = "LayerTree.replaySnapshot";
  	
  		/**
  		 * snapshotCommandLog
  		 * Replays the layer snapshot and returns canvas log.
  		 * @param snapshotId:{#@type#} optional:{#@optional#} The id of the layer snapshot.
  		 * @return commandLog:array optional:{#@optional#} The array of canvas function calls.
  		 */
  		public static const snapshotCommandLog:String = "LayerTree.snapshotCommandLog";
	}

}