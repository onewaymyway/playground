package debugprotocol.DOMStorage 
{



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
  		public static const clear:String = "DOMStorage.clear";
  	
  		/**
  		 * disable
  		 * Disables storage tracking, prevents storage events from being sent to the client.
  		 * @return 
  		 */
  		public static const disable:String = "DOMStorage.disable";
  	
  		/**
  		 * enable
  		 * Enables storage tracking, storage events will now be delivered to the client.
  		 * @return 
  		 */
  		public static const enable:String = "DOMStorage.enable";
  	
  		/**
  		 * getDOMStorageItems
  		 * @param storageId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return entries:array optional:{#@optional#} {#@description#}
  		 */
  		public static const getDOMStorageItems:String = "DOMStorage.getDOMStorageItems";
  	
  		/**
  		 * removeDOMStorageItem
  		 * @param storageId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param key:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const removeDOMStorageItem:String = "DOMStorage.removeDOMStorageItem";
  	
  		/**
  		 * setDOMStorageItem
  		 * @param storageId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param key:string optional:{#@optional#} {#@description#}
  		 * @param value:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const setDOMStorageItem:String = "DOMStorage.setDOMStorageItem";
	}

}