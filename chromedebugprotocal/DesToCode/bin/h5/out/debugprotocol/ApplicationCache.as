package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class ApplicationCache 
	{
		
		public function ApplicationCache() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  		/**
  		 * applicationCacheStatusUpdated
  		 * @param frameId:{#@type#} optional:{#@optional#} Identifier of the frame containing document whose application cache updated status.
  		 * @param manifestURL:string optional:{#@optional#} Manifest URL.
  		 * @param status:integer optional:{#@optional#} Updated application cache status.
  		 * @return 
  		 */
  		public static const applicationCacheStatusUpdated:String = "ApplicationCache.applicationCacheStatusUpdated";
  	
  		/**
  		 * networkStateUpdated
  		 * @param isNowOnline:boolean optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const networkStateUpdated:String = "ApplicationCache.networkStateUpdated";
  		/**
  		 * enable
  		 * Enables application cache domain notifications.
  		 * @return 
  		 */	
  		public static function enable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("ApplicationCache.enable", paramO);
  		}
  		
  		/**
  		 * getApplicationCacheForFrame
  		 * Returns relevant application cache data for the document in given frame.
  		 * @param frameId:{#@type#} optional:{#@optional#} Identifier of the frame containing document whose application cache is retrieved.
  		 * @return applicationCache:{#@type#} optional:{#@optional#} Relevant application cache data for the document in given frame.
  		 */	
  		public static function getApplicationCacheForFrame(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("ApplicationCache.getApplicationCacheForFrame", paramO);
  		}
  		
  		/**
  		 * getFramesWithManifests
  		 * Returns array of frame identifiers with manifest urls for each frame containing a document
  	associated with some application cache.
  		 * @return frameIds:array optional:{#@optional#} Array of frame identifiers with manifest urls for each frame containing a document
  	associated with some application cache.
  		 */	
  		public static function getFramesWithManifests(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("ApplicationCache.getFramesWithManifests", paramO);
  		}
  		
  		/**
  		 * getManifestForFrame
  		 * Returns manifest URL for document in the given frame.
  		 * @param frameId:{#@type#} optional:{#@optional#} Identifier of the frame containing document whose manifest is retrieved.
  		 * @return manifestURL:string optional:{#@optional#} Manifest URL for document in the given frame.
  		 */	
  		public static function getManifestForFrame(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("ApplicationCache.getManifestForFrame", paramO);
  		}
  		
	}

}