package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Accessibility 
	{
		
		public function Accessibility() 
		{
			
		}
		public static const DependDomains:Array=[DOM];
  	
  		/**
  		 * getPartialAXTree
  		 * Fetches the accessibility node and partial accessibility tree for this DOM node, if it exists.
  		 * @param nodeId:{#@type#} optional:true Identifier of the node to get the partial accessibility tree for.
  		 * @param backendNodeId:{#@type#} optional:true Identifier of the backend node to get the partial accessibility tree for.
  		 * @param objectId:{#@type#} optional:true JavaScript object id of the node wrapper to get the partial accessibility tree for.
  		 * @param fetchRelatives:boolean optional:true Whether to fetch this nodes ancestors, siblings and children. Defaults to true.
  		 * @return nodes:array optional:{#@optional#} The `Accessibility.AXNode` for this DOM node, if it exists, plus its ancestors, siblings and
  	children, if requested.
  		 */	
  		public static function getPartialAXTree(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Accessibility.getPartialAXTree", paramO);
  		}
  		
  		/**
  		 * getFullAXTree
  		 * Fetches the entire accessibility tree
  		 * @return nodes:array optional:{#@optional#} {#@description#}
  		 */	
  		public static function getFullAXTree(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Accessibility.getFullAXTree", paramO);
  		}
  		
	}

}