package debugprotocol 
{
	import chromedebug.ChromeMsg;



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
  		public static function compositingReasons(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("LayerTree.compositingReasons", paramO);
  		}
  		
  		/**
  		 * disable
  		 * Disables compositing tree inspection.
  		 * @return 
  		 */	
  		public static function disable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("LayerTree.disable", paramO);
  		}
  		
  		/**
  		 * enable
  		 * Enables compositing tree inspection.
  		 * @return 
  		 */	
  		public static function enable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("LayerTree.enable", paramO);
  		}
  		
  		/**
  		 * loadSnapshot
  		 * Returns the snapshot identifier.
  		 * @param tiles:array optional:{#@optional#} An array of tiles composing the snapshot.
  		 * @return snapshotId:{#@type#} optional:{#@optional#} The id of the snapshot.
  		 */	
  		public static function loadSnapshot(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("LayerTree.loadSnapshot", paramO);
  		}
  		
  		/**
  		 * makeSnapshot
  		 * Returns the layer snapshot identifier.
  		 * @param layerId:{#@type#} optional:{#@optional#} The id of the layer.
  		 * @return snapshotId:{#@type#} optional:{#@optional#} The id of the layer snapshot.
  		 */	
  		public static function makeSnapshot(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("LayerTree.makeSnapshot", paramO);
  		}
  		
  		/**
  		 * profileSnapshot
  		 * @param snapshotId:{#@type#} optional:{#@optional#} The id of the layer snapshot.
  		 * @param minRepeatCount:integer optional:true The maximum number of times to replay the snapshot (1, if not specified).
  		 * @param minDuration:number optional:true The minimum duration (in seconds) to replay the snapshot.
  		 * @param clipRect:{#@type#} optional:true The clip rectangle to apply when replaying the snapshot.
  		 * @return timings:array optional:{#@optional#} The array of paint profiles, one per run.
  		 */	
  		public static function profileSnapshot(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("LayerTree.profileSnapshot", paramO);
  		}
  		
  		/**
  		 * releaseSnapshot
  		 * Releases layer snapshot captured by the back-end.
  		 * @param snapshotId:{#@type#} optional:{#@optional#} The id of the layer snapshot.
  		 * @return 
  		 */	
  		public static function releaseSnapshot(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("LayerTree.releaseSnapshot", paramO);
  		}
  		
  		/**
  		 * replaySnapshot
  		 * Replays the layer snapshot and returns the resulting bitmap.
  		 * @param snapshotId:{#@type#} optional:{#@optional#} The id of the layer snapshot.
  		 * @param fromStep:integer optional:true The first step to replay from (replay from the very start if not specified).
  		 * @param toStep:integer optional:true The last step to replay to (replay till the end if not specified).
  		 * @param scale:number optional:true The scale to apply while replaying (defaults to 1).
  		 * @return dataURL:string optional:{#@optional#} A data: URL for resulting image.
  		 */	
  		public static function replaySnapshot(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("LayerTree.replaySnapshot", paramO);
  		}
  		
  		/**
  		 * snapshotCommandLog
  		 * Replays the layer snapshot and returns canvas log.
  		 * @param snapshotId:{#@type#} optional:{#@optional#} The id of the layer snapshot.
  		 * @return commandLog:array optional:{#@optional#} The array of canvas function calls.
  		 */	
  		public static function snapshotCommandLog(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("LayerTree.snapshotCommandLog", paramO);
  		}
  		
	}

}