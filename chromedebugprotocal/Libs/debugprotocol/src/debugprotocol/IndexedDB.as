package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class IndexedDB 
	{
		
		public function IndexedDB() 
		{
			
		}
		public static const DependDomains:Array=[Runtime];
  	
  		/**
  		 * clearObjectStore
  		 * Clears all entries from an object store.
  		 * @param securityOrigin:string optional:{#@optional#} Security origin.
  		 * @param databaseName:string optional:{#@optional#} Database name.
  		 * @param objectStoreName:string optional:{#@optional#} Object store name.
  		 * @return 
  		 */	
  		public static function clearObjectStore(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("IndexedDB.clearObjectStore", paramO);
  		}
  		
  		/**
  		 * deleteDatabase
  		 * Deletes a database.
  		 * @param securityOrigin:string optional:{#@optional#} Security origin.
  		 * @param databaseName:string optional:{#@optional#} Database name.
  		 * @return 
  		 */	
  		public static function deleteDatabase(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("IndexedDB.deleteDatabase", paramO);
  		}
  		
  		/**
  		 * deleteObjectStoreEntries
  		 * Delete a range of entries from an object store
  		 * @param securityOrigin:string optional:{#@optional#} {#@description#}
  		 * @param databaseName:string optional:{#@optional#} {#@description#}
  		 * @param objectStoreName:string optional:{#@optional#} {#@description#}
  		 * @param keyRange:{#@type#} optional:{#@optional#} Range of entry keys to delete
  		 * @return 
  		 */	
  		public static function deleteObjectStoreEntries(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("IndexedDB.deleteObjectStoreEntries", paramO);
  		}
  		
  		/**
  		 * disable
  		 * Disables events from backend.
  		 * @return 
  		 */	
  		public static function disable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("IndexedDB.disable", paramO);
  		}
  		
  		/**
  		 * enable
  		 * Enables events from backend.
  		 * @return 
  		 */	
  		public static function enable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("IndexedDB.enable", paramO);
  		}
  		
  		/**
  		 * requestData
  		 * Requests data from object store or index.
  		 * @param securityOrigin:string optional:{#@optional#} Security origin.
  		 * @param databaseName:string optional:{#@optional#} Database name.
  		 * @param objectStoreName:string optional:{#@optional#} Object store name.
  		 * @param indexName:string optional:{#@optional#} Index name, empty string for object store data requests.
  		 * @param skipCount:integer optional:{#@optional#} Number of records to skip.
  		 * @param pageSize:integer optional:{#@optional#} Number of records to fetch.
  		 * @param keyRange:{#@type#} optional:true Key range.
  		 * @return objectStoreDataEntries:array optional:{#@optional#} Array of object store data entries.
  		 */	
  		public static function requestData(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("IndexedDB.requestData", paramO);
  		}
  		
  		/**
  		 * requestDatabase
  		 * Requests database with given name in given frame.
  		 * @param securityOrigin:string optional:{#@optional#} Security origin.
  		 * @param databaseName:string optional:{#@optional#} Database name.
  		 * @return databaseWithObjectStores:{#@type#} optional:{#@optional#} Database with an array of object stores.
  		 */	
  		public static function requestDatabase(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("IndexedDB.requestDatabase", paramO);
  		}
  		
  		/**
  		 * requestDatabaseNames
  		 * Requests database names for given security origin.
  		 * @param securityOrigin:string optional:{#@optional#} Security origin.
  		 * @return databaseNames:array optional:{#@optional#} Database names for origin.
  		 */	
  		public static function requestDatabaseNames(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("IndexedDB.requestDatabaseNames", paramO);
  		}
  		
	}

}