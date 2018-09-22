package debugprotocol.ServiceWorker 
{



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
  		public static const deliverPushMessage:String = "ServiceWorker.deliverPushMessage";
  	
  		/**
  		 * disable
  		 * @return 
  		 */
  		public static const disable:String = "ServiceWorker.disable";
  	
  		/**
  		 * dispatchSyncEvent
  		 * @param origin:string optional:{#@optional#} {#@description#}
  		 * @param registrationId:string optional:{#@optional#} {#@description#}
  		 * @param tag:string optional:{#@optional#} {#@description#}
  		 * @param lastChance:boolean optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const dispatchSyncEvent:String = "ServiceWorker.dispatchSyncEvent";
  	
  		/**
  		 * enable
  		 * @return 
  		 */
  		public static const enable:String = "ServiceWorker.enable";
  	
  		/**
  		 * inspectWorker
  		 * @param versionId:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const inspectWorker:String = "ServiceWorker.inspectWorker";
  	
  		/**
  		 * setForceUpdateOnPageLoad
  		 * @param forceUpdateOnPageLoad:boolean optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const setForceUpdateOnPageLoad:String = "ServiceWorker.setForceUpdateOnPageLoad";
  	
  		/**
  		 * skipWaiting
  		 * @param scopeURL:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const skipWaiting:String = "ServiceWorker.skipWaiting";
  	
  		/**
  		 * startWorker
  		 * @param scopeURL:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const startWorker:String = "ServiceWorker.startWorker";
  	
  		/**
  		 * stopAllWorkers
  		 * @return 
  		 */
  		public static const stopAllWorkers:String = "ServiceWorker.stopAllWorkers";
  	
  		/**
  		 * stopWorker
  		 * @param versionId:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const stopWorker:String = "ServiceWorker.stopWorker";
  	
  		/**
  		 * unregister
  		 * @param scopeURL:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const unregister:String = "ServiceWorker.unregister";
  	
  		/**
  		 * updateRegistration
  		 * @param scopeURL:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const updateRegistration:String = "ServiceWorker.updateRegistration";
	}

}