package debugprotocol 
{



	public class Browser 
	{
		
		public function Browser() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  	
  		/**
  		 * grantPermissions
  		 * Grant specific permissions to the given origin and reject all others.
  		 * @param origin:string optional:{#@optional#} {#@description#}
  		 * @param permissions:array optional:{#@optional#} {#@description#}
  		 * @param browserContextId:{#@type#} optional:true BrowserContext to override permissions. When omitted, default browser context is used.
  		 * @return 
  		 */
  		public static const grantPermissions:String = "Browser.grantPermissions";
  	
  		/**
  		 * resetPermissions
  		 * Reset all permission management for all origins.
  		 * @param browserContextId:{#@type#} optional:true BrowserContext to reset permissions. When omitted, default browser context is used.
  		 * @return 
  		 */
  		public static const resetPermissions:String = "Browser.resetPermissions";
  	
  		/**
  		 * close
  		 * Close browser gracefully.
  		 * @return 
  		 */
  		public static const close:String = "Browser.close";
  	
  		/**
  		 * crash
  		 * Crashes browser on the main thread.
  		 * @return 
  		 */
  		public static const crash:String = "Browser.crash";
  	
  		/**
  		 * getVersion
  		 * Returns version information.
  		 * @return protocolVersion:string optional:{#@optional#} Protocol version.
  		 */
  		public static const getVersion:String = "Browser.getVersion";
  	
  		/**
  		 * getBrowserCommandLine
  		 * Returns the command line switches for the browser process if, and only if
  	--enable-automation is on the commandline.
  		 * @return arguments:array optional:{#@optional#} Commandline parameters
  		 */
  		public static const getBrowserCommandLine:String = "Browser.getBrowserCommandLine";
  	
  		/**
  		 * getHistograms
  		 * Get Chrome histograms.
  		 * @param query:string optional:true Requested substring in name. Only histograms which have query as a
  	substring in their name are extracted. An empty or absent query returns
  	all histograms.
  		 * @param delta:boolean optional:true If true, retrieve delta since last call.
  		 * @return histograms:array optional:{#@optional#} Histograms.
  		 */
  		public static const getHistograms:String = "Browser.getHistograms";
  	
  		/**
  		 * getHistogram
  		 * Get a Chrome histogram by name.
  		 * @param name:string optional:{#@optional#} Requested histogram name.
  		 * @param delta:boolean optional:true If true, retrieve delta since last call.
  		 * @return histogram:{#@type#} optional:{#@optional#} Histogram.
  		 */
  		public static const getHistogram:String = "Browser.getHistogram";
  	
  		/**
  		 * getWindowBounds
  		 * Get position and size of the browser window.
  		 * @param windowId:{#@type#} optional:{#@optional#} Browser window id.
  		 * @return bounds:{#@type#} optional:{#@optional#} Bounds information of the window. When window state is 'minimized', the restored window
  	position and size are returned.
  		 */
  		public static const getWindowBounds:String = "Browser.getWindowBounds";
  	
  		/**
  		 * getWindowForTarget
  		 * Get the browser window that contains the devtools target.
  		 * @param targetId:{#@type#} optional:{#@optional#} Devtools agent host id.
  		 * @return windowId:{#@type#} optional:{#@optional#} Browser window id.
  		 */
  		public static const getWindowForTarget:String = "Browser.getWindowForTarget";
  	
  		/**
  		 * setWindowBounds
  		 * Set position and/or size of the browser window.
  		 * @param windowId:{#@type#} optional:{#@optional#} Browser window id.
  		 * @param bounds:{#@type#} optional:{#@optional#} New window bounds. The 'minimized', 'maximized' and 'fullscreen' states cannot be combined
  	with 'left', 'top', 'width' or 'height'. Leaves unspecified fields unchanged.
  		 * @return 
  		 */
  		public static const setWindowBounds:String = "Browser.setWindowBounds";
	}

}