package debugprotocol 
{



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
  		public static const canEmulate:String = "Emulation.canEmulate";
  	
  		/**
  		 * clearDeviceMetricsOverride
  		 * Clears the overriden device metrics.
  		 * @return 
  		 */
  		public static const clearDeviceMetricsOverride:String = "Emulation.clearDeviceMetricsOverride";
  	
  		/**
  		 * clearGeolocationOverride
  		 * Clears the overriden Geolocation Position and Error.
  		 * @return 
  		 */
  		public static const clearGeolocationOverride:String = "Emulation.clearGeolocationOverride";
  	
  		/**
  		 * resetPageScaleFactor
  		 * Requests that page scale factor is reset to initial values.
  		 * @return 
  		 */
  		public static const resetPageScaleFactor:String = "Emulation.resetPageScaleFactor";
  	
  		/**
  		 * setFocusEmulationEnabled
  		 * Enables or disables simulating a focused and active page.
  		 * @param enabled:boolean optional:{#@optional#} Whether to enable to disable focus emulation.
  		 * @return 
  		 */
  		public static const setFocusEmulationEnabled:String = "Emulation.setFocusEmulationEnabled";
  	
  		/**
  		 * setCPUThrottlingRate
  		 * Enables CPU throttling to emulate slow CPUs.
  		 * @param rate:number optional:{#@optional#} Throttling rate as a slowdown factor (1 is no throttle, 2 is 2x slowdown, etc).
  		 * @return 
  		 */
  		public static const setCPUThrottlingRate:String = "Emulation.setCPUThrottlingRate";
  	
  		/**
  		 * setDefaultBackgroundColorOverride
  		 * Sets or clears an override of the default background color of the frame. This override is used
  	if the content does not specify one.
  		 * @param color:{#@type#} optional:true RGBA of the default background color. If not specified, any existing override will be
  	cleared.
  		 * @return 
  		 */
  		public static const setDefaultBackgroundColorOverride:String = "Emulation.setDefaultBackgroundColorOverride";
  	
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
  		public static const setDeviceMetricsOverride:String = "Emulation.setDeviceMetricsOverride";
  	
  		/**
  		 * setScrollbarsHidden
  		 * @param hidden:boolean optional:{#@optional#} Whether scrollbars should be always hidden.
  		 * @return 
  		 */
  		public static const setScrollbarsHidden:String = "Emulation.setScrollbarsHidden";
  	
  		/**
  		 * setDocumentCookieDisabled
  		 * @param disabled:boolean optional:{#@optional#} Whether document.coookie API should be disabled.
  		 * @return 
  		 */
  		public static const setDocumentCookieDisabled:String = "Emulation.setDocumentCookieDisabled";
  	
  		/**
  		 * setEmitTouchEventsForMouse
  		 * @param enabled:boolean optional:{#@optional#} Whether touch emulation based on mouse input should be enabled.
  		 * @param configuration:string optional:true Touch/gesture events configuration. Default: current platform.
  		 * @return 
  		 */
  		public static const setEmitTouchEventsForMouse:String = "Emulation.setEmitTouchEventsForMouse";
  	
  		/**
  		 * setEmulatedMedia
  		 * Emulates the given media for CSS media queries.
  		 * @param media:string optional:{#@optional#} Media type to emulate. Empty string disables the override.
  		 * @return 
  		 */
  		public static const setEmulatedMedia:String = "Emulation.setEmulatedMedia";
  	
  		/**
  		 * setGeolocationOverride
  		 * Overrides the Geolocation Position or Error. Omitting any of the parameters emulates position
  	unavailable.
  		 * @param latitude:number optional:true Mock latitude
  		 * @param longitude:number optional:true Mock longitude
  		 * @param accuracy:number optional:true Mock accuracy
  		 * @return 
  		 */
  		public static const setGeolocationOverride:String = "Emulation.setGeolocationOverride";
  	
  		/**
  		 * setNavigatorOverrides
  		 * Overrides value returned by the javascript navigator object.
  		 * @param platform:string optional:{#@optional#} The platform navigator.platform should return.
  		 * @return 
  		 */
  		public static const setNavigatorOverrides:String = "Emulation.setNavigatorOverrides";
  	
  		/**
  		 * setPageScaleFactor
  		 * Sets a specified page scale factor.
  		 * @param pageScaleFactor:number optional:{#@optional#} Page scale factor.
  		 * @return 
  		 */
  		public static const setPageScaleFactor:String = "Emulation.setPageScaleFactor";
  	
  		/**
  		 * setScriptExecutionDisabled
  		 * Switches script execution in the page.
  		 * @param value:boolean optional:{#@optional#} Whether script execution should be disabled in the page.
  		 * @return 
  		 */
  		public static const setScriptExecutionDisabled:String = "Emulation.setScriptExecutionDisabled";
  	
  		/**
  		 * setTouchEmulationEnabled
  		 * Enables touch on platforms which do not support them.
  		 * @param enabled:boolean optional:{#@optional#} Whether the touch event emulation should be enabled.
  		 * @param maxTouchPoints:integer optional:true Maximum touch points supported. Defaults to one.
  		 * @return 
  		 */
  		public static const setTouchEmulationEnabled:String = "Emulation.setTouchEmulationEnabled";
  	
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
  		public static const setVirtualTimePolicy:String = "Emulation.setVirtualTimePolicy";
  	
  		/**
  		 * setVisibleSize
  		 * Resizes the frame/viewport of the page. Note that this does not affect the frame's container
  	(e.g. browser window). Can be used to produce screenshots of the specified size. Not supported
  	on Android.
  		 * @param width:integer optional:{#@optional#} Frame width (DIP).
  		 * @param height:integer optional:{#@optional#} Frame height (DIP).
  		 * @return 
  		 */
  		public static const setVisibleSize:String = "Emulation.setVisibleSize";
  	
  		/**
  		 * setUserAgentOverride
  		 * Allows overriding user agent with the given string.
  		 * @param userAgent:string optional:{#@optional#} User agent to use.
  		 * @param acceptLanguage:string optional:true Browser langugage to emulate.
  		 * @param platform:string optional:true The platform navigator.platform should return.
  		 * @return 
  		 */
  		public static const setUserAgentOverride:String = "Emulation.setUserAgentOverride";
	}

}