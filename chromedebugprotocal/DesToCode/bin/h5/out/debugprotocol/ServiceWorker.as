package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class ServiceWorker 
	{
		
		public function ServiceWorker() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  		/**
  		 * workerErrorReported
  		 * @param errorMessage:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const workerErrorReported:String = "ServiceWorker.workerErrorReported";
  	
  		/**
  		 * workerRegistrationUpdated
  		 * @param registrations:array optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const workerRegistrationUpdated:String = "ServiceWorker.workerRegistrationUpdated";
  	
  		/**
  		 * workerVersionUpdated
  		 * @param versions:array optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const workerVersionUpdated:String = "ServiceWorker.workerVersionUpdated";
  		/**
  		 * deliverPushMessage
  		 * @param origin:string optional:{#@optional#} {#@description#}
  		 * @param registrationId:string optional:{#@optional#} {#@description#}
  		 * @param data:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function deliverPushMessage(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("ServiceWorker.deliverPushMessage", paramO);
  		}
  		
  		/**
  		 * disable
  		 * @return 
  		 */	
  		public static function disable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("ServiceWorker.disable", paramO);
  		}
  		
  		/**
  		 * dispatchSyncEvent
  		 * @param origin:string optional:{#@optional#} {#@description#}
  		 * @param registrationId:string optional:{#@optional#} {#@description#}
  		 * @param tag:string optional:{#@optional#} {#@description#}
  		 * @param lastChance:boolean optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function dispatchSyncEvent(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("ServiceWorker.dispatchSyncEvent", paramO);
  		}
  		
  		/**
  		 * enable
  		 * @return 
  		 */	
  		public static function enable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("ServiceWorker.enable", paramO);
  		}
  		
  		/**
  		 * inspectWorker
  		 * @param versionId:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function inspectWorker(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("ServiceWorker.inspectWorker", paramO);
  		}
  		
  		/**
  		 * setForceUpdateOnPageLoad
  		 * @param forceUpdateOnPageLoad:boolean optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function setForceUpdateOnPageLoad(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("ServiceWorker.setForceUpdateOnPageLoad", paramO);
  		}
  		
  		/**
  		 * skipWaiting
  		 * @param scopeURL:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function skipWaiting(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("ServiceWorker.skipWaiting", paramO);
  		}
  		
  		/**
  		 * startWorker
  		 * @param scopeURL:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function startWorker(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("ServiceWorker.startWorker", paramO);
  		}
  		
  		/**
  		 * stopAllWorkers
  		 * @return 
  		 */	
  		public static function stopAllWorkers(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("ServiceWorker.stopAllWorkers", paramO);
  		}
  		
  		/**
  		 * stopWorker
  		 * @param versionId:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function stopWorker(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("ServiceWorker.stopWorker", paramO);
  		}
  		
  		/**
  		 * unregister
  		 * @param scopeURL:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function unregister(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("ServiceWorker.unregister", paramO);
  		}
  		
  		/**
  		 * updateRegistration
  		 * @param scopeURL:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function updateRegistration(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("ServiceWorker.updateRegistration", paramO);
  		}
  		
	}

}