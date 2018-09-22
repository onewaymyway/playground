package debugprotocol.CacheStorage 
{



	public class CacheStorage 
	{
		
		public function CacheStorage() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  	
  		/**
  		 * deleteCache
  		 * Deletes a cache.
  		 * @param cacheId:{#@type#} optional:{#@optional#} Id of cache for deletion.
  		 * @return 
  		 */
  		public static const deleteCache:String = "CacheStorage.deleteCache";
  	
  		/**
  		 * deleteEntry
  		 * Deletes a cache entry.
  		 * @param cacheId:{#@type#} optional:{#@optional#} Id of cache where the entry will be deleted.
  		 * @param request:string optional:{#@optional#} URL spec of the request.
  		 * @return 
  		 */
  		public static const deleteEntry:String = "CacheStorage.deleteEntry";
  	
  		/**
  		 * requestCacheNames
  		 * Requests cache names.
  		 * @param securityOrigin:string optional:{#@optional#} Security origin.
  		 * @return caches:array optional:{#@optional#} Caches for the security origin.
  		 */
  		public static const requestCacheNames:String = "CacheStorage.requestCacheNames";
  	
  		/**
  		 * requestCachedResponse
  		 * Fetches cache entry.
  		 * @param cacheId:{#@type#} optional:{#@optional#} Id of cache that contains the enty.
  		 * @param requestURL:string optional:{#@optional#} URL spec of the request.
  		 * @return response:{#@type#} optional:{#@optional#} Response read from the cache.
  		 */
  		public static const requestCachedResponse:String = "CacheStorage.requestCachedResponse";
  	
  		/**
  		 * requestEntries
  		 * Requests data from cache.
  		 * @param cacheId:{#@type#} optional:{#@optional#} ID of cache to get entries from.
  		 * @param skipCount:integer optional:{#@optional#} Number of records to skip.
  		 * @param pageSize:integer optional:{#@optional#} Number of records to fetch.
  		 * @return cacheDataEntries:array optional:{#@optional#} Array of object store data entries.
  		 */
  		public static const requestEntries:String = "CacheStorage.requestEntries";
	}

}