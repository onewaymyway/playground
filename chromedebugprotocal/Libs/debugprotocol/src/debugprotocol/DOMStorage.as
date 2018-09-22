package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class DOMStorage 
	{
		
		public function DOMStorage() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  		/**
  		 * domStorageItemAdded
  		 * @param storageId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param key:string optional:{#@optional#} {#@description#}
  		 * @param newValue:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const domStorageItemAdded:String = "DOMStorage.domStorageItemAdded";
  	
  		/**
  		 * domStorageItemRemoved
  		 * @param storageId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param key:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const domStorageItemRemoved:String = "DOMStorage.domStorageItemRemoved";
  	
  		/**
  		 * domStorageItemUpdated
  		 * @param storageId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param key:string optional:{#@optional#} {#@description#}
  		 * @param oldValue:string optional:{#@optional#} {#@description#}
  		 * @param newValue:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const domStorageItemUpdated:String = "DOMStorage.domStorageItemUpdated";
  	
  		/**
  		 * domStorageItemsCleared
  		 * @param storageId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const domStorageItemsCleared:String = "DOMStorage.domStorageItemsCleared";
  		/**
  		 * clear
  		 * @param storageId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function clear(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMStorage.clear", paramO);
  		}
  		
  		/**
  		 * disable
  		 * Disables storage tracking, prevents storage events from being sent to the client.
  		 * @return 
  		 */	
  		public static function disable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMStorage.disable", paramO);
  		}
  		
  		/**
  		 * enable
  		 * Enables storage tracking, storage events will now be delivered to the client.
  		 * @return 
  		 */	
  		public static function enable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMStorage.enable", paramO);
  		}
  		
  		/**
  		 * getDOMStorageItems
  		 * @param storageId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return entries:array optional:{#@optional#} {#@description#}
  		 */	
  		public static function getDOMStorageItems(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMStorage.getDOMStorageItems", paramO);
  		}
  		
  		/**
  		 * removeDOMStorageItem
  		 * @param storageId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param key:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function removeDOMStorageItem(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMStorage.removeDOMStorageItem", paramO);
  		}
  		
  		/**
  		 * setDOMStorageItem
  		 * @param storageId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param key:string optional:{#@optional#} {#@description#}
  		 * @param value:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function setDOMStorageItem(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMStorage.setDOMStorageItem", paramO);
  		}
  		
	}

}