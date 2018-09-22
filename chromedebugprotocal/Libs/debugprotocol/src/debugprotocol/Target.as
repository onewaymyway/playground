package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Target 
	{
		
		public function Target() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  		/**
  		 * attachedToTarget
  		 * Issued when attached to target because of auto-attach or `attachToTarget` command.
  		 * @param sessionId:{#@type#} optional:{#@optional#} Identifier assigned to the session used to send/receive messages.
  		 * @param targetInfo:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param waitingForDebugger:boolean optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const attachedToTarget:String = "Target.attachedToTarget";
  	
  		/**
  		 * detachedFromTarget
  		 * Issued when detached from target for any reason (including `detachFromTarget` command). Can be
  	issued multiple times per target if multiple sessions have been attached to it.
  		 * @param sessionId:{#@type#} optional:{#@optional#} Detached session identifier.
  		 * @param targetId:{#@type#} optional:true Deprecated.
  		 * @return 
  		 */
  		public static const detachedFromTarget:String = "Target.detachedFromTarget";
  	
  		/**
  		 * receivedMessageFromTarget
  		 * Notifies about a new protocol message received from the session (as reported in
  	`attachedToTarget` event).
  		 * @param sessionId:{#@type#} optional:{#@optional#} Identifier of a session which sends a message.
  		 * @param message:string optional:{#@optional#} {#@description#}
  		 * @param targetId:{#@type#} optional:true Deprecated.
  		 * @return 
  		 */
  		public static const receivedMessageFromTarget:String = "Target.receivedMessageFromTarget";
  	
  		/**
  		 * targetCreated
  		 * Issued when a possible inspection target is created.
  		 * @param targetInfo:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const targetCreated:String = "Target.targetCreated";
  	
  		/**
  		 * targetDestroyed
  		 * Issued when a target is destroyed.
  		 * @param targetId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const targetDestroyed:String = "Target.targetDestroyed";
  	
  		/**
  		 * targetCrashed
  		 * Issued when a target has crashed.
  		 * @param targetId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param status:string optional:{#@optional#} Termination status type.
  		 * @param errorCode:integer optional:{#@optional#} Termination error code.
  		 * @return 
  		 */
  		public static const targetCrashed:String = "Target.targetCrashed";
  	
  		/**
  		 * targetInfoChanged
  		 * Issued when some information about a target has changed. This only happens between
  	`targetCreated` and `targetDestroyed`.
  		 * @param targetInfo:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const targetInfoChanged:String = "Target.targetInfoChanged";
  		/**
  		 * activateTarget
  		 * Activates (focuses) the target.
  		 * @param targetId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function activateTarget(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Target.activateTarget", paramO);
  		}
  		
  		/**
  		 * attachToTarget
  		 * Attaches to the target with given id.
  		 * @param targetId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param flatten:boolean optional:true Enables "flat" access to the session via specifying sessionId attribute in the commands.
  		 * @return sessionId:{#@type#} optional:{#@optional#} Id assigned to the session.
  		 */	
  		public static function attachToTarget(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Target.attachToTarget", paramO);
  		}
  		
  		/**
  		 * attachToBrowserTarget
  		 * Attaches to the browser target, only uses flat sessionId mode.
  		 * @return sessionId:{#@type#} optional:{#@optional#} Id assigned to the session.
  		 */	
  		public static function attachToBrowserTarget(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Target.attachToBrowserTarget", paramO);
  		}
  		
  		/**
  		 * closeTarget
  		 * Closes the target. If the target is a page that gets closed too.
  		 * @param targetId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return success:boolean optional:{#@optional#} {#@description#}
  		 */	
  		public static function closeTarget(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Target.closeTarget", paramO);
  		}
  		
  		/**
  		 * exposeDevToolsProtocol
  		 * Inject object to the target's main frame that provides a communication
  	channel with browser target.
  	
  	Injected object will be available as `window[bindingName]`.
  	
  	The object has the follwing API:
  	- `binding.send(json)` - a method to send messages over the remote debugging protocol
  	- `binding.onmessage = json => handleMessage(json)` - a callback that will be called for the protocol notifications and command responses.
  		 * @param targetId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param bindingName:string optional:true Binding name, 'cdp' if not specified.
  		 * @return 
  		 */	
  		public static function exposeDevToolsProtocol(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Target.exposeDevToolsProtocol", paramO);
  		}
  		
  		/**
  		 * createBrowserContext
  		 * Creates a new empty BrowserContext. Similar to an incognito profile but you can have more than
  	one.
  		 * @return browserContextId:{#@type#} optional:{#@optional#} The id of the context created.
  		 */	
  		public static function createBrowserContext(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Target.createBrowserContext", paramO);
  		}
  		
  		/**
  		 * getBrowserContexts
  		 * Returns all browser contexts created with `Target.createBrowserContext` method.
  		 * @return browserContextIds:array optional:{#@optional#} An array of browser context ids.
  		 */	
  		public static function getBrowserContexts(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Target.getBrowserContexts", paramO);
  		}
  		
  		/**
  		 * createTarget
  		 * Creates a new page.
  		 * @param url:string optional:{#@optional#} The initial URL the page will be navigated to.
  		 * @param width:integer optional:true Frame width in DIP (headless chrome only).
  		 * @param height:integer optional:true Frame height in DIP (headless chrome only).
  		 * @param browserContextId:{#@type#} optional:true The browser context to create the page in.
  		 * @param enableBeginFrameControl:boolean optional:true Whether BeginFrames for this target will be controlled via DevTools (headless chrome only,
  	not supported on MacOS yet, false by default).
  		 * @return targetId:{#@type#} optional:{#@optional#} The id of the page opened.
  		 */	
  		public static function createTarget(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Target.createTarget", paramO);
  		}
  		
  		/**
  		 * detachFromTarget
  		 * Detaches session with given id.
  		 * @param sessionId:{#@type#} optional:true Session to detach.
  		 * @param targetId:{#@type#} optional:true Deprecated.
  		 * @return 
  		 */	
  		public static function detachFromTarget(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Target.detachFromTarget", paramO);
  		}
  		
  		/**
  		 * disposeBrowserContext
  		 * Deletes a BrowserContext. All the belonging pages will be closed without calling their
  	beforeunload hooks.
  		 * @param browserContextId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function disposeBrowserContext(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Target.disposeBrowserContext", paramO);
  		}
  		
  		/**
  		 * getTargetInfo
  		 * Returns information about a target.
  		 * @param targetId:{#@type#} optional:true {#@description#}
  		 * @return targetInfo:{#@type#} optional:{#@optional#} {#@description#}
  		 */	
  		public static function getTargetInfo(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Target.getTargetInfo", paramO);
  		}
  		
  		/**
  		 * getTargets
  		 * Retrieves a list of available targets.
  		 * @return targetInfos:array optional:{#@optional#} The list of targets.
  		 */	
  		public static function getTargets(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Target.getTargets", paramO);
  		}
  		
  		/**
  		 * sendMessageToTarget
  		 * Sends protocol message over session with given id.
  		 * @param message:string optional:{#@optional#} {#@description#}
  		 * @param sessionId:{#@type#} optional:true Identifier of the session.
  		 * @param targetId:{#@type#} optional:true Deprecated.
  		 * @return 
  		 */	
  		public static function sendMessageToTarget(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Target.sendMessageToTarget", paramO);
  		}
  		
  		/**
  		 * setAutoAttach
  		 * Controls whether to automatically attach to new targets which are considered to be related to
  	this one. When turned on, attaches to all existing related targets as well. When turned off,
  	automatically detaches from all currently attached targets.
  		 * @param autoAttach:boolean optional:{#@optional#} Whether to auto-attach to related targets.
  		 * @param waitForDebuggerOnStart:boolean optional:{#@optional#} Whether to pause new targets when attaching to them. Use `Runtime.runIfWaitingForDebugger`
  	to run paused targets.
  		 * @param flatten:boolean optional:true Enables "flat" access to the session via specifying sessionId attribute in the commands.
  		 * @return 
  		 */	
  		public static function setAutoAttach(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Target.setAutoAttach", paramO);
  		}
  		
  		/**
  		 * setDiscoverTargets
  		 * Controls whether to discover available targets and notify via
  	`targetCreated/targetInfoChanged/targetDestroyed` events.
  		 * @param discover:boolean optional:{#@optional#} Whether to discover available targets.
  		 * @return 
  		 */	
  		public static function setDiscoverTargets(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Target.setDiscoverTargets", paramO);
  		}
  		
  		/**
  		 * setRemoteLocations
  		 * Enables target discovery for the specified locations, when `setDiscoverTargets` was set to
  	`true`.
  		 * @param locations:array optional:{#@optional#} List of remote locations.
  		 * @return 
  		 */	
  		public static function setRemoteLocations(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Target.setRemoteLocations", paramO);
  		}
  		
	}

}