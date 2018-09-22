package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Storage 
	{
		
		public function Storage() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  		/**
  		 * cacheStorageContentUpdated
  		 * A cache's contents have been modified.
  		 * @param origin:string optional:{#@optional#} Origin to update.
  		 * @param cacheName:string optional:{#@optional#} Name of cache in origin.
  		 * @return 
  		 */
  		public static const cacheStorageContentUpdated:String = "Storage.cacheStorageContentUpdated";
  	
  		/**
  		 * cacheStorageListUpdated
  		 * A cache has been added/deleted.
  		 * @param origin:string optional:{#@optional#} Origin to update.
  		 * @return 
  		 */
  		public static const cacheStorageListUpdated:String = "Storage.cacheStorageListUpdated";
  	
  		/**
  		 * indexedDBContentUpdated
  		 * The origin's IndexedDB object store has been modified.
  		 * @param origin:string optional:{#@optional#} Origin to update.
  		 * @param databaseName:string optional:{#@optional#} Database to update.
  		 * @param objectStoreName:string optional:{#@optional#} ObjectStore to update.
  		 * @return 
  		 */
  		public static const indexedDBContentUpdated:String = "Storage.indexedDBContentUpdated";
  	
  		/**
  		 * indexedDBListUpdated
  		 * The origin's IndexedDB database list has been modified.
  		 * @param origin:string optional:{#@optional#} Origin to update.
  		 * @return 
  		 */
  		public static const indexedDBListUpdated:String = "Storage.indexedDBListUpdated";
  		/**
  		 * clearDataForOrigin
  		 * Clears storage for origin.
  		 * @param origin:string optional:{#@optional#} Security origin.
  		 * @param storageTypes:string optional:{#@optional#} Comma separated origin names.
  		 * @return 
  		 */	
  		public static function clearDataForOrigin(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Storage.clearDataForOrigin", paramO);
  		}
  		
  		/**
  		 * getUsageAndQuota
  		 * Returns usage and quota in bytes.
  		 * @param origin:string optional:{#@optional#} Security origin.
  		 * @return usage:number optional:{#@optional#} Storage usage (bytes).
  		 */	
  		public static function getUsageAndQuota(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Storage.getUsageAndQuota", paramO);
  		}
  		
  		/**
  		 * trackCacheStorageForOrigin
  		 * Registers origin to be notified when an update occurs to its cache storage list.
  		 * @param origin:string optional:{#@optional#} Security origin.
  		 * @return 
  		 */	
  		public static function trackCacheStorageForOrigin(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Storage.trackCacheStorageForOrigin", paramO);
  		}
  		
  		/**
  		 * trackIndexedDBForOrigin
  		 * Registers origin to be notified when an update occurs to its IndexedDB.
  		 * @param origin:string optional:{#@optional#} Security origin.
  		 * @return 
  		 */	
  		public static function trackIndexedDBForOrigin(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Storage.trackIndexedDBForOrigin", paramO);
  		}
  		
  		/**
  		 * untrackCacheStorageForOrigin
  		 * Unregisters origin from receiving notifications for cache storage.
  		 * @param origin:string optional:{#@optional#} Security origin.
  		 * @return 
  		 */	
  		public static function untrackCacheStorageForOrigin(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Storage.untrackCacheStorageForOrigin", paramO);
  		}
  		
  		/**
  		 * untrackIndexedDBForOrigin
  		 * Unregisters origin from receiving notifications for IndexedDB.
  		 * @param origin:string optional:{#@optional#} Security origin.
  		 * @return 
  		 */	
  		public static function untrackIndexedDBForOrigin(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Storage.untrackIndexedDBForOrigin", paramO);
  		}
  		
	}

}