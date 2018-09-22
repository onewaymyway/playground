package debugprotocol 
{
	import chromedebug.ChromeMsg;



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
  		public static function grantPermissions(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Browser.grantPermissions", paramO);
  		}
  		
  		/**
  		 * resetPermissions
  		 * Reset all permission management for all origins.
  		 * @param browserContextId:{#@type#} optional:true BrowserContext to reset permissions. When omitted, default browser context is used.
  		 * @return 
  		 */	
  		public static function resetPermissions(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Browser.resetPermissions", paramO);
  		}
  		
  		/**
  		 * close
  		 * Close browser gracefully.
  		 * @return 
  		 */	
  		public static function close(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Browser.close", paramO);
  		}
  		
  		/**
  		 * crash
  		 * Crashes browser on the main thread.
  		 * @return 
  		 */	
  		public static function crash(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Browser.crash", paramO);
  		}
  		
  		/**
  		 * getVersion
  		 * Returns version information.
  		 * @return protocolVersion:string optional:{#@optional#} Protocol version.
  		 */	
  		public static function getVersion(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Browser.getVersion", paramO);
  		}
  		
  		/**
  		 * getBrowserCommandLine
  		 * Returns the command line switches for the browser process if, and only if
  	--enable-automation is on the commandline.
  		 * @return arguments:array optional:{#@optional#} Commandline parameters
  		 */	
  		public static function getBrowserCommandLine(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Browser.getBrowserCommandLine", paramO);
  		}
  		
  		/**
  		 * getHistograms
  		 * Get Chrome histograms.
  		 * @param query:string optional:true Requested substring in name. Only histograms which have query as a
  	substring in their name are extracted. An empty or absent query returns
  	all histograms.
  		 * @param delta:boolean optional:true If true, retrieve delta since last call.
  		 * @return histograms:array optional:{#@optional#} Histograms.
  		 */	
  		public static function getHistograms(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Browser.getHistograms", paramO);
  		}
  		
  		/**
  		 * getHistogram
  		 * Get a Chrome histogram by name.
  		 * @param name:string optional:{#@optional#} Requested histogram name.
  		 * @param delta:boolean optional:true If true, retrieve delta since last call.
  		 * @return histogram:{#@type#} optional:{#@optional#} Histogram.
  		 */	
  		public static function getHistogram(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Browser.getHistogram", paramO);
  		}
  		
  		/**
  		 * getWindowBounds
  		 * Get position and size of the browser window.
  		 * @param windowId:{#@type#} optional:{#@optional#} Browser window id.
  		 * @return bounds:{#@type#} optional:{#@optional#} Bounds information of the window. When window state is 'minimized', the restored window
  	position and size are returned.
  		 */	
  		public static function getWindowBounds(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Browser.getWindowBounds", paramO);
  		}
  		
  		/**
  		 * getWindowForTarget
  		 * Get the browser window that contains the devtools target.
  		 * @param targetId:{#@type#} optional:{#@optional#} Devtools agent host id.
  		 * @return windowId:{#@type#} optional:{#@optional#} Browser window id.
  		 */	
  		public static function getWindowForTarget(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Browser.getWindowForTarget", paramO);
  		}
  		
  		/**
  		 * setWindowBounds
  		 * Set position and/or size of the browser window.
  		 * @param windowId:{#@type#} optional:{#@optional#} Browser window id.
  		 * @param bounds:{#@type#} optional:{#@optional#} New window bounds. The 'minimized', 'maximized' and 'fullscreen' states cannot be combined
  	with 'left', 'top', 'width' or 'height'. Leaves unspecified fields unchanged.
  		 * @return 
  		 */	
  		public static function setWindowBounds(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Browser.setWindowBounds", paramO);
  		}
  		
	}

}