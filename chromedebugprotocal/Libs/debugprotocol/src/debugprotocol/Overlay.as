package debugprotocol.Overlay 
{



	public class Overlay 
	{
		
		public function Overlay() 
		{
			
		}
		public static const DependDomains:Array=[DOM,Page,Runtime];
  	
  		/**
  		 * inspectNodeRequested
  		 * Fired when the node should be inspected. This happens after call to `setInspectMode` or when
  	user manually inspects an element.
  		 * @param backendNodeId:{#@type#} optional:{#@optional#} Id of the node to inspect.
  		 * @return 
  		 */
  		public static const inspectNodeRequested:String = "Overlay.inspectNodeRequested";
  	
  		/**
  		 * nodeHighlightRequested
  		 * Fired when the node should be highlighted. This happens after call to `setInspectMode`.
  		 * @param nodeId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const nodeHighlightRequested:String = "Overlay.nodeHighlightRequested";
  	
  		/**
  		 * screenshotRequested
  		 * Fired when user asks to capture screenshot of some area on the page.
  		 * @param viewport:{#@type#} optional:{#@optional#} Viewport to capture, in CSS.
  		 * @return 
  		 */
  		public static const screenshotRequested:String = "Overlay.screenshotRequested";
  	
  		/**
  		 * disable
  		 * Disables domain notifications.
  		 * @return 
  		 */
  		public static const disable:String = "Overlay.disable";
  	
  		/**
  		 * enable
  		 * Enables domain notifications.
  		 * @return 
  		 */
  		public static const enable:String = "Overlay.enable";
  	
  		/**
  		 * getHighlightObjectForTest
  		 * For testing.
  		 * @param nodeId:{#@type#} optional:{#@optional#} Id of the node to get highlight object for.
  		 * @return highlight:object optional:{#@optional#} Highlight data for the node.
  		 */
  		public static const getHighlightObjectForTest:String = "Overlay.getHighlightObjectForTest";
  	
  		/**
  		 * hideHighlight
  		 * Hides any highlight.
  		 * @return 
  		 */
  		public static const hideHighlight:String = "Overlay.hideHighlight";
  	
  		/**
  		 * highlightFrame
  		 * Highlights owner element of the frame with given id.
  		 * @param frameId:{#@type#} optional:{#@optional#} Identifier of the frame to highlight.
  		 * @param contentColor:{#@type#} optional:true The content box highlight fill color (default: transparent).
  		 * @param contentOutlineColor:{#@type#} optional:true The content box highlight outline color (default: transparent).
  		 * @return 
  		 */
  		public static const highlightFrame:String = "Overlay.highlightFrame";
  	
  		/**
  		 * highlightNode
  		 * Highlights DOM node with given id or with the given JavaScript object wrapper. Either nodeId or
  	objectId must be specified.
  		 * @param highlightConfig:{#@type#} optional:{#@optional#} A descriptor for the highlight appearance.
  		 * @param nodeId:{#@type#} optional:true Identifier of the node to highlight.
  		 * @param backendNodeId:{#@type#} optional:true Identifier of the backend node to highlight.
  		 * @param objectId:{#@type#} optional:true JavaScript object id of the node to be highlighted.
  		 * @return 
  		 */
  		public static const highlightNode:String = "Overlay.highlightNode";
  	
  		/**
  		 * highlightQuad
  		 * Highlights given quad. Coordinates are absolute with respect to the main frame viewport.
  		 * @param quad:{#@type#} optional:{#@optional#} Quad to highlight
  		 * @param color:{#@type#} optional:true The highlight fill color (default: transparent).
  		 * @param outlineColor:{#@type#} optional:true The highlight outline color (default: transparent).
  		 * @return 
  		 */
  		public static const highlightQuad:String = "Overlay.highlightQuad";
  	
  		/**
  		 * highlightRect
  		 * Highlights given rectangle. Coordinates are absolute with respect to the main frame viewport.
  		 * @param x:integer optional:{#@optional#} X coordinate
  		 * @param y:integer optional:{#@optional#} Y coordinate
  		 * @param width:integer optional:{#@optional#} Rectangle width
  		 * @param height:integer optional:{#@optional#} Rectangle height
  		 * @param color:{#@type#} optional:true The highlight fill color (default: transparent).
  		 * @param outlineColor:{#@type#} optional:true The highlight outline color (default: transparent).
  		 * @return 
  		 */
  		public static const highlightRect:String = "Overlay.highlightRect";
  	
  		/**
  		 * setInspectMode
  		 * Enters the 'inspect' mode. In this mode, elements that user is hovering over are highlighted.
  	Backend then generates 'inspectNodeRequested' event upon element selection.
  		 * @param mode:{#@type#} optional:{#@optional#} Set an inspection mode.
  		 * @param highlightConfig:{#@type#} optional:true A descriptor for the highlight appearance of hovered-over nodes. May be omitted if `enabled
  	== false`.
  		 * @return 
  		 */
  		public static const setInspectMode:String = "Overlay.setInspectMode";
  	
  		/**
  		 * setPausedInDebuggerMessage
  		 * @param message:string optional:true The message to display, also triggers resume and step over controls.
  		 * @return 
  		 */
  		public static const setPausedInDebuggerMessage:String = "Overlay.setPausedInDebuggerMessage";
  	
  		/**
  		 * setShowDebugBorders
  		 * Requests that backend shows debug borders on layers
  		 * @param show:boolean optional:{#@optional#} True for showing debug borders
  		 * @return 
  		 */
  		public static const setShowDebugBorders:String = "Overlay.setShowDebugBorders";
  	
  		/**
  		 * setShowFPSCounter
  		 * Requests that backend shows the FPS counter
  		 * @param show:boolean optional:{#@optional#} True for showing the FPS counter
  		 * @return 
  		 */
  		public static const setShowFPSCounter:String = "Overlay.setShowFPSCounter";
  	
  		/**
  		 * setShowPaintRects
  		 * Requests that backend shows paint rectangles
  		 * @param result:boolean optional:{#@optional#} True for showing paint rectangles
  		 * @return 
  		 */
  		public static const setShowPaintRects:String = "Overlay.setShowPaintRects";
  	
  		/**
  		 * setShowScrollBottleneckRects
  		 * Requests that backend shows scroll bottleneck rects
  		 * @param show:boolean optional:{#@optional#} True for showing scroll bottleneck rects
  		 * @return 
  		 */
  		public static const setShowScrollBottleneckRects:String = "Overlay.setShowScrollBottleneckRects";
  	
  		/**
  		 * setShowViewportSizeOnResize
  		 * Paints viewport size upon main frame resize.
  		 * @param show:boolean optional:{#@optional#} Whether to paint size or not.
  		 * @return 
  		 */
  		public static const setShowViewportSizeOnResize:String = "Overlay.setShowViewportSizeOnResize";
  	
  		/**
  		 * setSuspended
  		 * @param suspended:boolean optional:{#@optional#} Whether overlay should be suspended and not consume any resources until resumed.
  		 * @return 
  		 */
  		public static const setSuspended:String = "Overlay.setSuspended";
	}

}