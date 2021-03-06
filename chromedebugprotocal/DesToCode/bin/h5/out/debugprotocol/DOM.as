package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class DOM 
	{
		
		public function DOM() 
		{
			
		}
		public static const DependDomains:Array=[Runtime];
  	
  		/**
  		 * attributeModified
  		 * Fired when `Element`'s attribute is modified.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node that has changed.
  		 * @param name:string optional:{#@optional#} Attribute name.
  		 * @param value:string optional:{#@optional#} Attribute value.
  		 * @return 
  		 */
  		public static const attributeModified:String = "DOM.attributeModified";
  	
  		/**
  		 * attributeRemoved
  		 * Fired when `Element`'s attribute is removed.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node that has changed.
  		 * @param name:string optional:{#@optional#} A ttribute name.
  		 * @return 
  		 */
  		public static const attributeRemoved:String = "DOM.attributeRemoved";
  	
  		/**
  		 * characterDataModified
  		 * Mirrors `DOMCharacterDataModified` event.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node that has changed.
  		 * @param characterData:string optional:{#@optional#} New text value.
  		 * @return 
  		 */
  		public static const characterDataModified:String = "DOM.characterDataModified";
  	
  		/**
  		 * childNodeCountUpdated
  		 * Fired when `Container`'s child node count has changed.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node that has changed.
  		 * @param childNodeCount:integer optional:{#@optional#} New node count.
  		 * @return 
  		 */
  		public static const childNodeCountUpdated:String = "DOM.childNodeCountUpdated";
  	
  		/**
  		 * childNodeInserted
  		 * Mirrors `DOMNodeInserted` event.
  		 * @param parentNodeId:{#@type#} optional:{#@optional#} Id of the node that has changed.
  		 * @param previousNodeId:{#@type#} optional:{#@optional#} If of the previous siblint.
  		 * @param node:{#@type#} optional:{#@optional#} Inserted node data.
  		 * @return 
  		 */
  		public static const childNodeInserted:String = "DOM.childNodeInserted";
  	
  		/**
  		 * childNodeRemoved
  		 * Mirrors `DOMNodeRemoved` event.
  		 * @param parentNodeId:{#@type#} optional:{#@optional#} Parent id.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node that has been removed.
  		 * @return 
  		 */
  		public static const childNodeRemoved:String = "DOM.childNodeRemoved";
  	
  		/**
  		 * distributedNodesUpdated
  		 * Called when distrubution is changed.
  		 * @param insertionPointId:{#@type#} optional:{#@optional#} Insertion point where distrubuted nodes were updated.
  		 * @param distributedNodes:array optional:{#@optional#} Distributed nodes for given insertion point.
  		 * @return 
  		 */
  		public static const distributedNodesUpdated:String = "DOM.distributedNodesUpdated";
  	
  		/**
  		 * documentUpdated
  		 * Fired when `Document` has been totally updated. Node ids are no longer valid.
  		 * @return 
  		 */
  		public static const documentUpdated:String = "DOM.documentUpdated";
  	
  		/**
  		 * inlineStyleInvalidated
  		 * Fired when `Element`'s inline style is modified via a CSS property modification.
  		 * @param nodeIds:array optional:{#@optional#} Ids of the nodes for which the inline styles have been invalidated.
  		 * @return 
  		 */
  		public static const inlineStyleInvalidated:String = "DOM.inlineStyleInvalidated";
  	
  		/**
  		 * pseudoElementAdded
  		 * Called when a pseudo element is added to an element.
  		 * @param parentId:{#@type#} optional:{#@optional#} Pseudo element's parent element id.
  		 * @param pseudoElement:{#@type#} optional:{#@optional#} The added pseudo element.
  		 * @return 
  		 */
  		public static const pseudoElementAdded:String = "DOM.pseudoElementAdded";
  	
  		/**
  		 * pseudoElementRemoved
  		 * Called when a pseudo element is removed from an element.
  		 * @param parentId:{#@type#} optional:{#@optional#} Pseudo element's parent element id.
  		 * @param pseudoElementId:{#@type#} optional:{#@optional#} The removed pseudo element id.
  		 * @return 
  		 */
  		public static const pseudoElementRemoved:String = "DOM.pseudoElementRemoved";
  	
  		/**
  		 * setChildNodes
  		 * Fired when backend wants to provide client with the missing DOM structure. This happens upon
  	most of the calls requesting node ids.
  		 * @param parentId:{#@type#} optional:{#@optional#} Parent node id to populate with children.
  		 * @param nodes:array optional:{#@optional#} Child nodes array.
  		 * @return 
  		 */
  		public static const setChildNodes:String = "DOM.setChildNodes";
  	
  		/**
  		 * shadowRootPopped
  		 * Called when shadow root is popped from the element.
  		 * @param hostId:{#@type#} optional:{#@optional#} Host element id.
  		 * @param rootId:{#@type#} optional:{#@optional#} Shadow root id.
  		 * @return 
  		 */
  		public static const shadowRootPopped:String = "DOM.shadowRootPopped";
  	
  		/**
  		 * shadowRootPushed
  		 * Called when shadow root is pushed into the element.
  		 * @param hostId:{#@type#} optional:{#@optional#} Host element id.
  		 * @param root:{#@type#} optional:{#@optional#} Shadow root.
  		 * @return 
  		 */
  		public static const shadowRootPushed:String = "DOM.shadowRootPushed";
  		/**
  		 * collectClassNamesFromSubtree
  		 * Collects class names for the node with given id and all of it's child nodes.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node to collect class names.
  		 * @return classNames:array optional:{#@optional#} Class name list.
  		 */	
  		public static function collectClassNamesFromSubtree(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.collectClassNamesFromSubtree", paramO);
  		}
  		
  		/**
  		 * copyTo
  		 * Creates a deep copy of the specified node and places it into the target container before the
  	given anchor.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node to copy.
  		 * @param targetNodeId:{#@type#} optional:{#@optional#} Id of the element to drop the copy into.
  		 * @param insertBeforeNodeId:{#@type#} optional:true Drop the copy before this node (if absent, the copy becomes the last child of
  	`targetNodeId`).
  		 * @return nodeId:{#@type#} optional:{#@optional#} Id of the node clone.
  		 */	
  		public static function copyTo(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.copyTo", paramO);
  		}
  		
  		/**
  		 * describeNode
  		 * Describes node given its id, does not require domain to be enabled. Does not start tracking any
  	objects, can be used for automation.
  		 * @param nodeId:{#@type#} optional:true Identifier of the node.
  		 * @param backendNodeId:{#@type#} optional:true Identifier of the backend node.
  		 * @param objectId:{#@type#} optional:true JavaScript object id of the node wrapper.
  		 * @param depth:integer optional:true The maximum depth at which children should be retrieved, defaults to 1. Use -1 for the
  	entire subtree or provide an integer larger than 0.
  		 * @param pierce:boolean optional:true Whether or not iframes and shadow roots should be traversed when returning the subtree
  	(default is false).
  		 * @return node:{#@type#} optional:{#@optional#} Node description.
  		 */	
  		public static function describeNode(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.describeNode", paramO);
  		}
  		
  		/**
  		 * disable
  		 * Disables DOM agent for the given page.
  		 * @return 
  		 */	
  		public static function disable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.disable", paramO);
  		}
  		
  		/**
  		 * discardSearchResults
  		 * Discards search results from the session with the given id. `getSearchResults` should no longer
  	be called for that search.
  		 * @param searchId:string optional:{#@optional#} Unique search session identifier.
  		 * @return 
  		 */	
  		public static function discardSearchResults(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.discardSearchResults", paramO);
  		}
  		
  		/**
  		 * enable
  		 * Enables DOM agent for the given page.
  		 * @return 
  		 */	
  		public static function enable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.enable", paramO);
  		}
  		
  		/**
  		 * focus
  		 * Focuses the given element.
  		 * @param nodeId:{#@type#} optional:true Identifier of the node.
  		 * @param backendNodeId:{#@type#} optional:true Identifier of the backend node.
  		 * @param objectId:{#@type#} optional:true JavaScript object id of the node wrapper.
  		 * @return 
  		 */	
  		public static function focus(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.focus", paramO);
  		}
  		
  		/**
  		 * getAttributes
  		 * Returns attributes for the specified node.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node to retrieve attibutes for.
  		 * @return attributes:array optional:{#@optional#} An interleaved array of node attribute names and values.
  		 */	
  		public static function getAttributes(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.getAttributes", paramO);
  		}
  		
  		/**
  		 * getBoxModel
  		 * Returns boxes for the given node.
  		 * @param nodeId:{#@type#} optional:true Identifier of the node.
  		 * @param backendNodeId:{#@type#} optional:true Identifier of the backend node.
  		 * @param objectId:{#@type#} optional:true JavaScript object id of the node wrapper.
  		 * @return model:{#@type#} optional:{#@optional#} Box model for the node.
  		 */	
  		public static function getBoxModel(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.getBoxModel", paramO);
  		}
  		
  		/**
  		 * getContentQuads
  		 * Returns quads that describe node position on the page. This method
  	might return multiple quads for inline nodes.
  		 * @param nodeId:{#@type#} optional:true Identifier of the node.
  		 * @param backendNodeId:{#@type#} optional:true Identifier of the backend node.
  		 * @param objectId:{#@type#} optional:true JavaScript object id of the node wrapper.
  		 * @return quads:array optional:{#@optional#} Quads that describe node layout relative to viewport.
  		 */	
  		public static function getContentQuads(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.getContentQuads", paramO);
  		}
  		
  		/**
  		 * getDocument
  		 * Returns the root DOM node (and optionally the subtree) to the caller.
  		 * @param depth:integer optional:true The maximum depth at which children should be retrieved, defaults to 1. Use -1 for the
  	entire subtree or provide an integer larger than 0.
  		 * @param pierce:boolean optional:true Whether or not iframes and shadow roots should be traversed when returning the subtree
  	(default is false).
  		 * @return root:{#@type#} optional:{#@optional#} Resulting node.
  		 */	
  		public static function getDocument(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.getDocument", paramO);
  		}
  		
  		/**
  		 * getFlattenedDocument
  		 * Returns the root DOM node (and optionally the subtree) to the caller.
  		 * @param depth:integer optional:true The maximum depth at which children should be retrieved, defaults to 1. Use -1 for the
  	entire subtree or provide an integer larger than 0.
  		 * @param pierce:boolean optional:true Whether or not iframes and shadow roots should be traversed when returning the subtree
  	(default is false).
  		 * @return nodes:array optional:{#@optional#} Resulting node.
  		 */	
  		public static function getFlattenedDocument(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.getFlattenedDocument", paramO);
  		}
  		
  		/**
  		 * getNodeForLocation
  		 * Returns node id at given location.
  		 * @param x:integer optional:{#@optional#} X coordinate.
  		 * @param y:integer optional:{#@optional#} Y coordinate.
  		 * @param includeUserAgentShadowDOM:boolean optional:true False to skip to the nearest non-UA shadow root ancestor (default: false).
  		 * @return nodeId:{#@type#} optional:{#@optional#} Id of the node at given coordinates.
  		 */	
  		public static function getNodeForLocation(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.getNodeForLocation", paramO);
  		}
  		
  		/**
  		 * getOuterHTML
  		 * Returns node's HTML markup.
  		 * @param nodeId:{#@type#} optional:true Identifier of the node.
  		 * @param backendNodeId:{#@type#} optional:true Identifier of the backend node.
  		 * @param objectId:{#@type#} optional:true JavaScript object id of the node wrapper.
  		 * @return outerHTML:string optional:{#@optional#} Outer HTML markup.
  		 */	
  		public static function getOuterHTML(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.getOuterHTML", paramO);
  		}
  		
  		/**
  		 * getRelayoutBoundary
  		 * Returns the id of the nearest ancestor that is a relayout boundary.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node.
  		 * @return nodeId:{#@type#} optional:{#@optional#} Relayout boundary node id for the given node.
  		 */	
  		public static function getRelayoutBoundary(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.getRelayoutBoundary", paramO);
  		}
  		
  		/**
  		 * getSearchResults
  		 * Returns search results from given `fromIndex` to given `toIndex` from the search with the given
  	identifier.
  		 * @param searchId:string optional:{#@optional#} Unique search session identifier.
  		 * @param fromIndex:integer optional:{#@optional#} Start index of the search result to be returned.
  		 * @param toIndex:integer optional:{#@optional#} End index of the search result to be returned.
  		 * @return nodeIds:array optional:{#@optional#} Ids of the search result nodes.
  		 */	
  		public static function getSearchResults(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.getSearchResults", paramO);
  		}
  		
  		/**
  		 * hideHighlight
  		 * Hides any highlight.
  		 * @return 
  		 */	
  		public static function hideHighlight(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.hideHighlight", paramO);
  		}
  		
  		/**
  		 * highlightNode
  		 * Highlights DOM node.
  		 * @return 
  		 */	
  		public static function highlightNode(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.highlightNode", paramO);
  		}
  		
  		/**
  		 * highlightRect
  		 * Highlights given rectangle.
  		 * @return 
  		 */	
  		public static function highlightRect(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.highlightRect", paramO);
  		}
  		
  		/**
  		 * markUndoableState
  		 * Marks last undoable state.
  		 * @return 
  		 */	
  		public static function markUndoableState(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.markUndoableState", paramO);
  		}
  		
  		/**
  		 * moveTo
  		 * Moves node into the new container, places it before the given anchor.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node to move.
  		 * @param targetNodeId:{#@type#} optional:{#@optional#} Id of the element to drop the moved node into.
  		 * @param insertBeforeNodeId:{#@type#} optional:true Drop node before this one (if absent, the moved node becomes the last child of
  	`targetNodeId`).
  		 * @return nodeId:{#@type#} optional:{#@optional#} New id of the moved node.
  		 */	
  		public static function moveTo(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.moveTo", paramO);
  		}
  		
  		/**
  		 * performSearch
  		 * Searches for a given string in the DOM tree. Use `getSearchResults` to access search results or
  	`cancelSearch` to end this search session.
  		 * @param query:string optional:{#@optional#} Plain text or query selector or XPath search query.
  		 * @param includeUserAgentShadowDOM:boolean optional:true True to search in user agent shadow DOM.
  		 * @return searchId:string optional:{#@optional#} Unique search session identifier.
  		 */	
  		public static function performSearch(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.performSearch", paramO);
  		}
  		
  		/**
  		 * pushNodeByPathToFrontend
  		 * Requests that the node is sent to the caller given its path. // FIXME, use XPath
  		 * @param path:string optional:{#@optional#} Path to node in the proprietary format.
  		 * @return nodeId:{#@type#} optional:{#@optional#} Id of the node for given path.
  		 */	
  		public static function pushNodeByPathToFrontend(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.pushNodeByPathToFrontend", paramO);
  		}
  		
  		/**
  		 * pushNodesByBackendIdsToFrontend
  		 * Requests that a batch of nodes is sent to the caller given their backend node ids.
  		 * @param backendNodeIds:array optional:{#@optional#} The array of backend node ids.
  		 * @return nodeIds:array optional:{#@optional#} The array of ids of pushed nodes that correspond to the backend ids specified in
  	backendNodeIds.
  		 */	
  		public static function pushNodesByBackendIdsToFrontend(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.pushNodesByBackendIdsToFrontend", paramO);
  		}
  		
  		/**
  		 * querySelector
  		 * Executes `querySelector` on a given node.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node to query upon.
  		 * @param selector:string optional:{#@optional#} Selector string.
  		 * @return nodeId:{#@type#} optional:{#@optional#} Query selector result.
  		 */	
  		public static function querySelector(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.querySelector", paramO);
  		}
  		
  		/**
  		 * querySelectorAll
  		 * Executes `querySelectorAll` on a given node.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node to query upon.
  		 * @param selector:string optional:{#@optional#} Selector string.
  		 * @return nodeIds:array optional:{#@optional#} Query selector result.
  		 */	
  		public static function querySelectorAll(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.querySelectorAll", paramO);
  		}
  		
  		/**
  		 * redo
  		 * Re-does the last undone action.
  		 * @return 
  		 */	
  		public static function redo(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.redo", paramO);
  		}
  		
  		/**
  		 * removeAttribute
  		 * Removes attribute with given name from an element with given id.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the element to remove attribute from.
  		 * @param name:string optional:{#@optional#} Name of the attribute to remove.
  		 * @return 
  		 */	
  		public static function removeAttribute(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.removeAttribute", paramO);
  		}
  		
  		/**
  		 * removeNode
  		 * Removes node with given id.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node to remove.
  		 * @return 
  		 */	
  		public static function removeNode(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.removeNode", paramO);
  		}
  		
  		/**
  		 * requestChildNodes
  		 * Requests that children of the node with given id are returned to the caller in form of
  	`setChildNodes` events where not only immediate children are retrieved, but all children down to
  	the specified depth.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node to get children for.
  		 * @param depth:integer optional:true The maximum depth at which children should be retrieved, defaults to 1. Use -1 for the
  	entire subtree or provide an integer larger than 0.
  		 * @param pierce:boolean optional:true Whether or not iframes and shadow roots should be traversed when returning the sub-tree
  	(default is false).
  		 * @return 
  		 */	
  		public static function requestChildNodes(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.requestChildNodes", paramO);
  		}
  		
  		/**
  		 * requestNode
  		 * Requests that the node is sent to the caller given the JavaScript node object reference. All
  	nodes that form the path from the node to the root are also sent to the client as a series of
  	`setChildNodes` notifications.
  		 * @param objectId:{#@type#} optional:{#@optional#} JavaScript object id to convert into node.
  		 * @return nodeId:{#@type#} optional:{#@optional#} Node id for given object.
  		 */	
  		public static function requestNode(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.requestNode", paramO);
  		}
  		
  		/**
  		 * resolveNode
  		 * Resolves the JavaScript node object for a given NodeId or BackendNodeId.
  		 * @param nodeId:{#@type#} optional:true Id of the node to resolve.
  		 * @param backendNodeId:{#@type#} optional:true Backend identifier of the node to resolve.
  		 * @param objectGroup:string optional:true Symbolic group name that can be used to release multiple objects.
  		 * @return object:{#@type#} optional:{#@optional#} JavaScript object wrapper for given node.
  		 */	
  		public static function resolveNode(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.resolveNode", paramO);
  		}
  		
  		/**
  		 * setAttributeValue
  		 * Sets attribute for an element with given id.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the element to set attribute for.
  		 * @param name:string optional:{#@optional#} Attribute name.
  		 * @param value:string optional:{#@optional#} Attribute value.
  		 * @return 
  		 */	
  		public static function setAttributeValue(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.setAttributeValue", paramO);
  		}
  		
  		/**
  		 * setAttributesAsText
  		 * Sets attributes on element with given id. This method is useful when user edits some existing
  	attribute value and types in several attribute name/value pairs.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the element to set attributes for.
  		 * @param text:string optional:{#@optional#} Text with a number of attributes. Will parse this text using HTML parser.
  		 * @param name:string optional:true Attribute name to replace with new attributes derived from text in case text parsed
  	successfully.
  		 * @return 
  		 */	
  		public static function setAttributesAsText(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.setAttributesAsText", paramO);
  		}
  		
  		/**
  		 * setFileInputFiles
  		 * Sets files for the given file input element.
  		 * @param files:array optional:{#@optional#} Array of file paths to set.
  		 * @param nodeId:{#@type#} optional:true Identifier of the node.
  		 * @param backendNodeId:{#@type#} optional:true Identifier of the backend node.
  		 * @param objectId:{#@type#} optional:true JavaScript object id of the node wrapper.
  		 * @return 
  		 */	
  		public static function setFileInputFiles(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.setFileInputFiles", paramO);
  		}
  		
  		/**
  		 * setInspectedNode
  		 * Enables console to refer to the node with given id via $x (see Command Line API for more details
  	$x functions).
  		 * @param nodeId:{#@type#} optional:{#@optional#} DOM node id to be accessible by means of $x command line API.
  		 * @return 
  		 */	
  		public static function setInspectedNode(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.setInspectedNode", paramO);
  		}
  		
  		/**
  		 * setNodeName
  		 * Sets node name for a node with given id.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node to set name for.
  		 * @param name:string optional:{#@optional#} New node's name.
  		 * @return nodeId:{#@type#} optional:{#@optional#} New node's id.
  		 */	
  		public static function setNodeName(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.setNodeName", paramO);
  		}
  		
  		/**
  		 * setNodeValue
  		 * Sets node value for a node with given id.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node to set value for.
  		 * @param value:string optional:{#@optional#} New node's value.
  		 * @return 
  		 */	
  		public static function setNodeValue(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.setNodeValue", paramO);
  		}
  		
  		/**
  		 * setOuterHTML
  		 * Sets node HTML markup, returns new node id.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node to set markup for.
  		 * @param outerHTML:string optional:{#@optional#} Outer HTML markup to set.
  		 * @return 
  		 */	
  		public static function setOuterHTML(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.setOuterHTML", paramO);
  		}
  		
  		/**
  		 * undo
  		 * Undoes the last performed action.
  		 * @return 
  		 */	
  		public static function undo(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.undo", paramO);
  		}
  		
  		/**
  		 * getFrameOwner
  		 * Returns iframe node that owns iframe with the given domain.
  		 * @param frameId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return nodeId:{#@type#} optional:{#@optional#} {#@description#}
  		 */	
  		public static function getFrameOwner(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DOM.getFrameOwner", paramO);
  		}
  		
	}

}