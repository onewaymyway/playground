package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class DOMSnapshot 
	{
		
		public function DOMSnapshot() 
		{
			
		}
		public static const DependDomains:Array=[CSS,DOM,DOMDebugger,Page];
  	
  		/**
  		 * disable
  		 * Disables DOM snapshot agent for the given page.
  		 * @return 
  		 */	
  		public static function disable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMSnapshot.disable", paramO);
  		}
  		
  		/**
  		 * enable
  		 * Enables DOM snapshot agent for the given page.
  		 * @return 
  		 */	
  		public static function enable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMSnapshot.enable", paramO);
  		}
  		
  		/**
  		 * getSnapshot
  		 * Returns a document snapshot, including the full DOM tree of the root node (including iframes,
  	template contents, and imported documents) in a flattened array, as well as layout and
  	white-listed computed style information for the nodes. Shadow DOM in the returned DOM tree is
  	flattened.
  		 * @param computedStyleWhitelist:array optional:{#@optional#} Whitelist of computed styles to return.
  		 * @param includeEventListeners:boolean optional:true Whether or not to retrieve details of DOM listeners (default false).
  		 * @param includePaintOrder:boolean optional:true Whether to determine and include the paint order index of LayoutTreeNodes (default false).
  		 * @param includeUserAgentShadowTree:boolean optional:true Whether to include UA shadow tree in the snapshot (default false).
  		 * @return domNodes:array optional:{#@optional#} The nodes in the DOM tree. The DOMNode at index 0 corresponds to the root document.
  		 */	
  		public static function getSnapshot(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMSnapshot.getSnapshot", paramO);
  		}
  		
  		/**
  		 * captureSnapshot
  		 * Returns a document snapshot, including the full DOM tree of the root node (including iframes,
  	template contents, and imported documents) in a flattened array, as well as layout and
  	white-listed computed style information for the nodes. Shadow DOM in the returned DOM tree is
  	flattened.
  		 * @param computedStyles:array optional:{#@optional#} Whitelist of computed styles to return.
  		 * @return documents:array optional:{#@optional#} The nodes in the DOM tree. The DOMNode at index 0 corresponds to the root document.
  		 */	
  		public static function captureSnapshot(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOMSnapshot.captureSnapshot", paramO);
  		}
  		
	}

}