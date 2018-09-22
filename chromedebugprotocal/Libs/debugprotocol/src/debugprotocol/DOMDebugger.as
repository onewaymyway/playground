package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class DOMDebugger 
	{
		
		public function DOMDebugger() 
		{
			
		}
		public static const DependDomains:Array=[DOM,Debugger,Runtime];
  	
  		/**
  		 * getEventListeners
  		 * Returns event listeners of the given object.
  		 * @param objectId:{#@type#} optional:{#@optional#} Identifier of the object to return listeners for.
  		 * @param depth:integer optional:true The maximum depth at which Node children should be retrieved, defaults to 1. Use -1 for the
  	entire subtree or provide an integer larger than 0.
  		 * @param pierce:boolean optional:true Whether or not iframes and shadow roots should be traversed when returning the subtree
  	(default is false). Reports listeners for all contexts if pierce is enabled.
  		 * @return listeners:array optional:{#@optional#} Array of relevant listeners.
  		 */	
  		public static function getEventListeners(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMDebugger.getEventListeners", paramO);
  		}
  		
  		/**
  		 * removeDOMBreakpoint
  		 * Removes DOM breakpoint that was set using `setDOMBreakpoint`.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Identifier of the node to remove breakpoint from.
  		 * @param type:{#@type#} optional:{#@optional#} Type of the breakpoint to remove.
  		 * @return 
  		 */	
  		public static function removeDOMBreakpoint(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMDebugger.removeDOMBreakpoint", paramO);
  		}
  		
  		/**
  		 * removeEventListenerBreakpoint
  		 * Removes breakpoint on particular DOM event.
  		 * @param eventName:string optional:{#@optional#} Event name.
  		 * @param targetName:string optional:true EventTarget interface name.
  		 * @return 
  		 */	
  		public static function removeEventListenerBreakpoint(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMDebugger.removeEventListenerBreakpoint", paramO);
  		}
  		
  		/**
  		 * removeInstrumentationBreakpoint
  		 * Removes breakpoint on particular native event.
  		 * @param eventName:string optional:{#@optional#} Instrumentation name to stop on.
  		 * @return 
  		 */	
  		public static function removeInstrumentationBreakpoint(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMDebugger.removeInstrumentationBreakpoint", paramO);
  		}
  		
  		/**
  		 * removeXHRBreakpoint
  		 * Removes breakpoint from XMLHttpRequest.
  		 * @param url:string optional:{#@optional#} Resource URL substring.
  		 * @return 
  		 */	
  		public static function removeXHRBreakpoint(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMDebugger.removeXHRBreakpoint", paramO);
  		}
  		
  		/**
  		 * setDOMBreakpoint
  		 * Sets breakpoint on particular operation with DOM.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Identifier of the node to set breakpoint on.
  		 * @param type:{#@type#} optional:{#@optional#} Type of the operation to stop upon.
  		 * @return 
  		 */	
  		public static function setDOMBreakpoint(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMDebugger.setDOMBreakpoint", paramO);
  		}
  		
  		/**
  		 * setEventListenerBreakpoint
  		 * Sets breakpoint on particular DOM event.
  		 * @param eventName:string optional:{#@optional#} DOM Event name to stop on (any DOM event will do).
  		 * @param targetName:string optional:true EventTarget interface name to stop on. If equal to `"*"` or not provided, will stop on any
  	EventTarget.
  		 * @return 
  		 */	
  		public static function setEventListenerBreakpoint(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMDebugger.setEventListenerBreakpoint", paramO);
  		}
  		
  		/**
  		 * setInstrumentationBreakpoint
  		 * Sets breakpoint on particular native event.
  		 * @param eventName:string optional:{#@optional#} Instrumentation name to stop on.
  		 * @return 
  		 */	
  		public static function setInstrumentationBreakpoint(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMDebugger.setInstrumentationBreakpoint", paramO);
  		}
  		
  		/**
  		 * setXHRBreakpoint
  		 * Sets breakpoint on XMLHttpRequest.
  		 * @param url:string optional:{#@optional#} Resource URL substring. All XHRs having this substring in the URL will get stopped upon.
  		 * @return 
  		 */	
  		public static function setXHRBreakpoint(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMDebugger.setXHRBreakpoint", paramO);
  		}
  		
	}

}