package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Emulation 
	{
		
		public function Emulation() 
		{
			
		}
		public static const DependDomains:Array=[DOM,Page,Runtime];
  	
  		/**
  		 * virtualTimeAdvanced
  		 * Notification sent after the virtual time has advanced.
  		 * @param virtualTimeElapsed:number optional:{#@optional#} The amount of virtual time that has elapsed in milliseconds since virtual time was first
  	enabled.
  		 * @return 
  		 */
  		public static const virtualTimeAdvanced:String = "Emulation.virtualTimeAdvanced";
  	
  		/**
  		 * virtualTimeBudgetExpired
  		 * Notification sent after the virtual time budget for the current VirtualTimePolicy has run out.
  		 * @return 
  		 */
  		public static const virtualTimeBudgetExpired:String = "Emulation.virtualTimeBudgetExpired";
  	
  		/**
  		 * virtualTimePaused
  		 * Notification sent after the virtual time has paused.
  		 * @param virtualTimeElapsed:number optional:{#@optional#} The amount of virtual time that has elapsed in milliseconds since virtual time was first
  	enabled.
  		 * @return 
  		 */
  		public static const virtualTimePaused:String = "Emulation.virtualTimePaused";
  		/**
  		 * canEmulate
  		 * Tells whether emulation is supported.
  		 * @return result:boolean optional:{#@optional#} True if emulation is supported.
  		 */	
  		public static function canEmulate(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.canEmulate", paramO);
  		}
  		
  		/**
  		 * clearDeviceMetricsOverride
  		 * Clears the overriden device metrics.
  		 * @return 
  		 */	
  		public static function clearDeviceMetricsOverride(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.clearDeviceMetricsOverride", paramO);
  		}
  		
  		/**
  		 * clearGeolocationOverride
  		 * Clears the overriden Geolocation Position and Error.
  		 * @return 
  		 */	
  		public static function clearGeolocationOverride(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.clearGeolocationOverride", paramO);
  		}
  		
  		/**
  		 * resetPageScaleFactor
  		 * Requests that page scale factor is reset to initial values.
  		 * @return 
  		 */	
  		public static function resetPageScaleFactor(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.resetPageScaleFactor", paramO);
  		}
  		
  		/**
  		 * setFocusEmulationEnabled
  		 * Enables or disables simulating a focused and active page.
  		 * @param enabled:boolean optional:{#@optional#} Whether to enable to disable focus emulation.
  		 * @return 
  		 */	
  		public static function setFocusEmulationEnabled(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.setFocusEmulationEnabled", paramO);
  		}
  		
  		/**
  		 * setCPUThrottlingRate
  		 * Enables CPU throttling to emulate slow CPUs.
  		 * @param rate:number optional:{#@optional#} Throttling rate as a slowdown factor (1 is no throttle, 2 is 2x slowdown, etc).
  		 * @return 
  		 */	
  		public static function setCPUThrottlingRate(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.setCPUThrottlingRate", paramO);
  		}
  		
  		/**
  		 * setDefaultBackgroundColorOverride
  		 * Sets or clears an override of the default background color of the frame. This override is used
  	if the content does not specify one.
  		 * @param color:{#@type#} optional:true RGBA of the default background color. If not specified, any existing override will be
  	cleared.
  		 * @return 
  		 */	
  		public static function setDefaultBackgroundColorOverride(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.setDefaultBackgroundColorOverride", paramO);
  		}
  		
  		/**
  		 * setDeviceMetricsOverride
  		 * Overrides the values of device screen dimensions (window.screen.width, window.screen.height,
  	window.innerWidth, window.innerHeight, and "device-width"/"device-height"-related CSS media
  	query results).
  		 * @param width:integer optional:{#@optional#} Overriding width value in pixels (minimum 0, maximum 10000000). 0 disables the override.
  		 * @param height:integer optional:{#@optional#} Overriding height value in pixels (minimum 0, maximum 10000000). 0 disables the override.
  		 * @param deviceScaleFactor:number optional:{#@optional#} Overriding device scale factor value. 0 disables the override.
  		 * @param mobile:boolean optional:{#@optional#} Whether to emulate mobile device. This includes viewport meta tag, overlay scrollbars, text
  	autosizing and more.
  		 * @param scale:number optional:true Scale to apply to resulting view image.
  		 * @param screenWidth:integer optional:true Overriding screen width value in pixels (minimum 0, maximum 10000000).
  		 * @param screenHeight:integer optional:true Overriding screen height value in pixels (minimum 0, maximum 10000000).
  		 * @param positionX:integer optional:true Overriding view X position on screen in pixels (minimum 0, maximum 10000000).
  		 * @param positionY:integer optional:true Overriding view Y position on screen in pixels (minimum 0, maximum 10000000).
  		 * @param dontSetVisibleSize:boolean optional:true Do not set visible view size, rely upon explicit setVisibleSize call.
  		 * @param screenOrientation:{#@type#} optional:true Screen orientation override.
  		 * @param viewport:{#@type#} optional:true If set, the visible area of the page will be overridden to this viewport. This viewport
  	change is not observed by the page, e.g. viewport-relative elements do not change positions.
  		 * @return 
  		 */	
  		public static function setDeviceMetricsOverride(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.setDeviceMetricsOverride", paramO);
  		}
  		
  		/**
  		 * setScrollbarsHidden
  		 * @param hidden:boolean optional:{#@optional#} Whether scrollbars should be always hidden.
  		 * @return 
  		 */	
  		public static function setScrollbarsHidden(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.setScrollbarsHidden", paramO);
  		}
  		
  		/**
  		 * setDocumentCookieDisabled
  		 * @param disabled:boolean optional:{#@optional#} Whether document.coookie API should be disabled.
  		 * @return 
  		 */	
  		public static function setDocumentCookieDisabled(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.setDocumentCookieDisabled", paramO);
  		}
  		
  		/**
  		 * setEmitTouchEventsForMouse
  		 * @param enabled:boolean optional:{#@optional#} Whether touch emulation based on mouse input should be enabled.
  		 * @param configuration:string optional:true Touch/gesture events configuration. Default: current platform.
  		 * @return 
  		 */	
  		public static function setEmitTouchEventsForMouse(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.setEmitTouchEventsForMouse", paramO);
  		}
  		
  		/**
  		 * setEmulatedMedia
  		 * Emulates the given media for CSS media queries.
  		 * @param media:string optional:{#@optional#} Media type to emulate. Empty string disables the override.
  		 * @return 
  		 */	
  		public static function setEmulatedMedia(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.setEmulatedMedia", paramO);
  		}
  		
  		/**
  		 * setGeolocationOverride
  		 * Overrides the Geolocation Position or Error. Omitting any of the parameters emulates position
  	unavailable.
  		 * @param latitude:number optional:true Mock latitude
  		 * @param longitude:number optional:true Mock longitude
  		 * @param accuracy:number optional:true Mock accuracy
  		 * @return 
  		 */	
  		public static function setGeolocationOverride(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.setGeolocationOverride", paramO);
  		}
  		
  		/**
  		 * setNavigatorOverrides
  		 * Overrides value returned by the javascript navigator object.
  		 * @param platform:string optional:{#@optional#} The platform navigator.platform should return.
  		 * @return 
  		 */	
  		public static function setNavigatorOverrides(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.setNavigatorOverrides", paramO);
  		}
  		
  		/**
  		 * setPageScaleFactor
  		 * Sets a specified page scale factor.
  		 * @param pageScaleFactor:number optional:{#@optional#} Page scale factor.
  		 * @return 
  		 */	
  		public static function setPageScaleFactor(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.setPageScaleFactor", paramO);
  		}
  		
  		/**
  		 * setScriptExecutionDisabled
  		 * Switches script execution in the page.
  		 * @param value:boolean optional:{#@optional#} Whether script execution should be disabled in the page.
  		 * @return 
  		 */	
  		public static function setScriptExecutionDisabled(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.setScriptExecutionDisabled", paramO);
  		}
  		
  		/**
  		 * setTouchEmulationEnabled
  		 * Enables touch on platforms which do not support them.
  		 * @param enabled:boolean optional:{#@optional#} Whether the touch event emulation should be enabled.
  		 * @param maxTouchPoints:integer optional:true Maximum touch points supported. Defaults to one.
  		 * @return 
  		 */	
  		public static function setTouchEmulationEnabled(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.setTouchEmulationEnabled", paramO);
  		}
  		
  		/**
  		 * setVirtualTimePolicy
  		 * Turns on virtual time for all frames (replacing real-time with a synthetic time source) and sets
  	the current virtual time policy.  Note this supersedes any previous time budget.
  		 * @param policy:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param budget:number optional:true If set, after this many virtual milliseconds have elapsed virtual time will be paused and a
  	virtualTimeBudgetExpired event is sent.
  		 * @param maxVirtualTimeTaskStarvationCount:integer optional:true If set this specifies the maximum number of tasks that can be run before virtual is forced
  	forwards to prevent deadlock.
  		 * @param waitForNavigation:boolean optional:true If set the virtual time policy change should be deferred until any frame starts navigating.
  	Note any previous deferred policy change is superseded.
  		 * @param initialVirtualTime:{#@type#} optional:true If set, base::Time::Now will be overriden to initially return this value.
  		 * @return virtualTimeTicksBase:number optional:{#@optional#} Absolute timestamp at which virtual time was first enabled (up time in milliseconds).
  		 */	
  		public static function setVirtualTimePolicy(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.setVirtualTimePolicy", paramO);
  		}
  		
  		/**
  		 * setVisibleSize
  		 * Resizes the frame/viewport of the page. Note that this does not affect the frame's container
  	(e.g. browser window). Can be used to produce screenshots of the specified size. Not supported
  	on Android.
  		 * @param width:integer optional:{#@optional#} Frame width (DIP).
  		 * @param height:integer optional:{#@optional#} Frame height (DIP).
  		 * @return 
  		 */	
  		public static function setVisibleSize(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.setVisibleSize", paramO);
  		}
  		
  		/**
  		 * setUserAgentOverride
  		 * Allows overriding user agent with the given string.
  		 * @param userAgent:string optional:{#@optional#} User agent to use.
  		 * @param acceptLanguage:string optional:true Browser langugage to emulate.
  		 * @param platform:string optional:true The platform navigator.platform should return.
  		 * @return 
  		 */	
  		public static function setUserAgentOverride(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Emulation.setUserAgentOverride", paramO);
  		}
  		
	}

}