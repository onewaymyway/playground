package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Page 
	{
		
		public function Page() 
		{
			
		}
		public static const DependDomains:Array=[Debugger,DOM,Network,Runtime];
  	
  		/**
  		 * domContentEventFired
  		 * @param timestamp:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const domContentEventFired:String = "Page.domContentEventFired";
  	
  		/**
  		 * frameAttached
  		 * Fired when frame has been attached to its parent.
  		 * @param frameId:{#@type#} optional:{#@optional#} Id of the frame that has been attached.
  		 * @param parentFrameId:{#@type#} optional:{#@optional#} Parent frame identifier.
  		 * @param stack:{#@type#} optional:true JavaScript stack trace of when frame was attached, only set if frame initiated from script.
  		 * @return 
  		 */
  		public static const frameAttached:String = "Page.frameAttached";
  	
  		/**
  		 * frameClearedScheduledNavigation
  		 * Fired when frame no longer has a scheduled navigation.
  		 * @param frameId:{#@type#} optional:{#@optional#} Id of the frame that has cleared its scheduled navigation.
  		 * @return 
  		 */
  		public static const frameClearedScheduledNavigation:String = "Page.frameClearedScheduledNavigation";
  	
  		/**
  		 * frameDetached
  		 * Fired when frame has been detached from its parent.
  		 * @param frameId:{#@type#} optional:{#@optional#} Id of the frame that has been detached.
  		 * @return 
  		 */
  		public static const frameDetached:String = "Page.frameDetached";
  	
  		/**
  		 * frameNavigated
  		 * Fired once navigation of the frame has completed. Frame is now associated with the new loader.
  		 * @param frame:{#@type#} optional:{#@optional#} Frame object.
  		 * @return 
  		 */
  		public static const frameNavigated:String = "Page.frameNavigated";
  	
  		/**
  		 * frameResized
  		 * @return 
  		 */
  		public static const frameResized:String = "Page.frameResized";
  	
  		/**
  		 * frameScheduledNavigation
  		 * Fired when frame schedules a potential navigation.
  		 * @param frameId:{#@type#} optional:{#@optional#} Id of the frame that has scheduled a navigation.
  		 * @param delay:number optional:{#@optional#} Delay (in seconds) until the navigation is scheduled to begin. The navigation is not
  	guaranteed to start.
  		 * @param reason:string optional:{#@optional#} The reason for the navigation.
  		 * @param url:string optional:{#@optional#} The destination URL for the scheduled navigation.
  		 * @return 
  		 */
  		public static const frameScheduledNavigation:String = "Page.frameScheduledNavigation";
  	
  		/**
  		 * frameStartedLoading
  		 * Fired when frame has started loading.
  		 * @param frameId:{#@type#} optional:{#@optional#} Id of the frame that has started loading.
  		 * @return 
  		 */
  		public static const frameStartedLoading:String = "Page.frameStartedLoading";
  	
  		/**
  		 * frameStoppedLoading
  		 * Fired when frame has stopped loading.
  		 * @param frameId:{#@type#} optional:{#@optional#} Id of the frame that has stopped loading.
  		 * @return 
  		 */
  		public static const frameStoppedLoading:String = "Page.frameStoppedLoading";
  	
  		/**
  		 * interstitialHidden
  		 * Fired when interstitial page was hidden
  		 * @return 
  		 */
  		public static const interstitialHidden:String = "Page.interstitialHidden";
  	
  		/**
  		 * interstitialShown
  		 * Fired when interstitial page was shown
  		 * @return 
  		 */
  		public static const interstitialShown:String = "Page.interstitialShown";
  	
  		/**
  		 * javascriptDialogClosed
  		 * Fired when a JavaScript initiated dialog (alert, confirm, prompt, or onbeforeunload) has been
  	closed.
  		 * @param result:boolean optional:{#@optional#} Whether dialog was confirmed.
  		 * @param userInput:string optional:{#@optional#} User input in case of prompt.
  		 * @return 
  		 */
  		public static const javascriptDialogClosed:String = "Page.javascriptDialogClosed";
  	
  		/**
  		 * javascriptDialogOpening
  		 * Fired when a JavaScript initiated dialog (alert, confirm, prompt, or onbeforeunload) is about to
  	open.
  		 * @param url:string optional:{#@optional#} Frame url.
  		 * @param message:string optional:{#@optional#} Message that will be displayed by the dialog.
  		 * @param type:{#@type#} optional:{#@optional#} Dialog type.
  		 * @param hasBrowserHandler:boolean optional:{#@optional#} True iff browser is capable showing or acting on the given dialog. When browser has no
  	dialog handler for given target, calling alert while Page domain is engaged will stall
  	the page execution. Execution can be resumed via calling Page.handleJavaScriptDialog.
  		 * @param defaultPrompt:string optional:true Default dialog prompt.
  		 * @return 
  		 */
  		public static const javascriptDialogOpening:String = "Page.javascriptDialogOpening";
  	
  		/**
  		 * lifecycleEvent
  		 * Fired for top level page lifecycle events such as navigation, load, paint, etc.
  		 * @param frameId:{#@type#} optional:{#@optional#} Id of the frame.
  		 * @param loaderId:{#@type#} optional:{#@optional#} Loader identifier. Empty string if the request is fetched from worker.
  		 * @param name:string optional:{#@optional#} {#@description#}
  		 * @param timestamp:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const lifecycleEvent:String = "Page.lifecycleEvent";
  	
  		/**
  		 * loadEventFired
  		 * @param timestamp:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const loadEventFired:String = "Page.loadEventFired";
  	
  		/**
  		 * navigatedWithinDocument
  		 * Fired when same-document navigation happens, e.g. due to history API usage or anchor navigation.
  		 * @param frameId:{#@type#} optional:{#@optional#} Id of the frame.
  		 * @param url:string optional:{#@optional#} Frame's new url.
  		 * @return 
  		 */
  		public static const navigatedWithinDocument:String = "Page.navigatedWithinDocument";
  	
  		/**
  		 * screencastFrame
  		 * Compressed image data requested by the `startScreencast`.
  		 * @param data:string optional:{#@optional#} Base64-encoded compressed image.
  		 * @param metadata:{#@type#} optional:{#@optional#} Screencast frame metadata.
  		 * @param sessionId:integer optional:{#@optional#} Frame number.
  		 * @return 
  		 */
  		public static const screencastFrame:String = "Page.screencastFrame";
  	
  		/**
  		 * screencastVisibilityChanged
  		 * Fired when the page with currently enabled screencast was shown or hidden `.
  		 * @param visible:boolean optional:{#@optional#} True if the page is visible.
  		 * @return 
  		 */
  		public static const screencastVisibilityChanged:String = "Page.screencastVisibilityChanged";
  	
  		/**
  		 * windowOpen
  		 * Fired when a new window is going to be opened, via window.open(), link click, form submission,
  	etc.
  		 * @param url:string optional:{#@optional#} The URL for the new window.
  		 * @param windowName:string optional:{#@optional#} Window name.
  		 * @param windowFeatures:array optional:{#@optional#} An array of enabled window features.
  		 * @param userGesture:boolean optional:{#@optional#} Whether or not it was triggered by user gesture.
  		 * @return 
  		 */
  		public static const windowOpen:String = "Page.windowOpen";
  	
  		/**
  		 * compilationCacheProduced
  		 * Issued for every compilation cache generated. Is only available
  	if Page.setGenerateCompilationCache is enabled.
  		 * @param url:string optional:{#@optional#} {#@description#}
  		 * @param data:string optional:{#@optional#} Base64-encoded data
  		 * @return 
  		 */
  		public static const compilationCacheProduced:String = "Page.compilationCacheProduced";
  		/**
  		 * addScriptToEvaluateOnLoad
  		 * Deprecated, please use addScriptToEvaluateOnNewDocument instead.
  		 * @param scriptSource:string optional:{#@optional#} {#@description#}
  		 * @return identifier:{#@type#} optional:{#@optional#} Identifier of the added script.
  		 */	
  		public static function addScriptToEvaluateOnLoad(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.addScriptToEvaluateOnLoad", paramO);
  		}
  		
  		/**
  		 * addScriptToEvaluateOnNewDocument
  		 * Evaluates given script in every frame upon creation (before loading frame's scripts).
  		 * @param source:string optional:{#@optional#} {#@description#}
  		 * @return identifier:{#@type#} optional:{#@optional#} Identifier of the added script.
  		 */	
  		public static function addScriptToEvaluateOnNewDocument(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.addScriptToEvaluateOnNewDocument", paramO);
  		}
  		
  		/**
  		 * bringToFront
  		 * Brings page to front (activates tab).
  		 * @return 
  		 */	
  		public static function bringToFront(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.bringToFront", paramO);
  		}
  		
  		/**
  		 * captureScreenshot
  		 * Capture page screenshot.
  		 * @param format:string optional:true Image compression format (defaults to png).
  		 * @param quality:integer optional:true Compression quality from range [0..100] (jpeg only).
  		 * @param clip:{#@type#} optional:true Capture the screenshot of a given region only.
  		 * @param fromSurface:boolean optional:true Capture the screenshot from the surface, rather than the view. Defaults to true.
  		 * @return data:string optional:{#@optional#} Base64-encoded image data.
  		 */	
  		public static function captureScreenshot(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.captureScreenshot", paramO);
  		}
  		
  		/**
  		 * clearDeviceMetricsOverride
  		 * Clears the overriden device metrics.
  		 * @return 
  		 */	
  		public static function clearDeviceMetricsOverride(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.clearDeviceMetricsOverride", paramO);
  		}
  		
  		/**
  		 * clearDeviceOrientationOverride
  		 * Clears the overridden Device Orientation.
  		 * @return 
  		 */	
  		public static function clearDeviceOrientationOverride(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.clearDeviceOrientationOverride", paramO);
  		}
  		
  		/**
  		 * clearGeolocationOverride
  		 * Clears the overriden Geolocation Position and Error.
  		 * @return 
  		 */	
  		public static function clearGeolocationOverride(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.clearGeolocationOverride", paramO);
  		}
  		
  		/**
  		 * createIsolatedWorld
  		 * Creates an isolated world for the given frame.
  		 * @param frameId:{#@type#} optional:{#@optional#} Id of the frame in which the isolated world should be created.
  		 * @param worldName:string optional:true An optional name which is reported in the Execution Context.
  		 * @param grantUniveralAccess:boolean optional:true Whether or not universal access should be granted to the isolated world. This is a powerful
  	option, use with caution.
  		 * @return executionContextId:{#@type#} optional:{#@optional#} Execution context of the isolated world.
  		 */	
  		public static function createIsolatedWorld(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.createIsolatedWorld", paramO);
  		}
  		
  		/**
  		 * deleteCookie
  		 * Deletes browser cookie with given name, domain and path.
  		 * @param cookieName:string optional:{#@optional#} Name of the cookie to remove.
  		 * @param url:string optional:{#@optional#} URL to match cooke domain and path.
  		 * @return 
  		 */	
  		public static function deleteCookie(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.deleteCookie", paramO);
  		}
  		
  		/**
  		 * disable
  		 * Disables page domain notifications.
  		 * @return 
  		 */	
  		public static function disable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.disable", paramO);
  		}
  		
  		/**
  		 * enable
  		 * Enables page domain notifications.
  		 * @return 
  		 */	
  		public static function enable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.enable", paramO);
  		}
  		
  		/**
  		 * getAppManifest
  		 * @return url:string optional:{#@optional#} Manifest location.
  		 */	
  		public static function getAppManifest(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.getAppManifest", paramO);
  		}
  		
  		/**
  		 * getCookies
  		 * Returns all browser cookies. Depending on the backend support, will return detailed cookie
  	information in the `cookies` field.
  		 * @return cookies:array optional:{#@optional#} Array of cookie objects.
  		 */	
  		public static function getCookies(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.getCookies", paramO);
  		}
  		
  		/**
  		 * getFrameTree
  		 * Returns present frame tree structure.
  		 * @return frameTree:{#@type#} optional:{#@optional#} Present frame tree structure.
  		 */	
  		public static function getFrameTree(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.getFrameTree", paramO);
  		}
  		
  		/**
  		 * getLayoutMetrics
  		 * Returns metrics relating to the layouting of the page, such as viewport bounds/scale.
  		 * @return layoutViewport:{#@type#} optional:{#@optional#} Metrics relating to the layout viewport.
  		 */	
  		public static function getLayoutMetrics(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.getLayoutMetrics", paramO);
  		}
  		
  		/**
  		 * getNavigationHistory
  		 * Returns navigation history for the current page.
  		 * @return currentIndex:integer optional:{#@optional#} Index of the current navigation history entry.
  		 */	
  		public static function getNavigationHistory(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.getNavigationHistory", paramO);
  		}
  		
  		/**
  		 * getResourceContent
  		 * Returns content of the given resource.
  		 * @param frameId:{#@type#} optional:{#@optional#} Frame id to get resource for.
  		 * @param url:string optional:{#@optional#} URL of the resource to get content for.
  		 * @return content:string optional:{#@optional#} Resource content.
  		 */	
  		public static function getResourceContent(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.getResourceContent", paramO);
  		}
  		
  		/**
  		 * getResourceTree
  		 * Returns present frame / resource tree structure.
  		 * @return frameTree:{#@type#} optional:{#@optional#} Present frame / resource tree structure.
  		 */	
  		public static function getResourceTree(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.getResourceTree", paramO);
  		}
  		
  		/**
  		 * handleJavaScriptDialog
  		 * Accepts or dismisses a JavaScript initiated dialog (alert, confirm, prompt, or onbeforeunload).
  		 * @param accept:boolean optional:{#@optional#} Whether to accept or dismiss the dialog.
  		 * @param promptText:string optional:true The text to enter into the dialog prompt before accepting. Used only if this is a prompt
  	dialog.
  		 * @return 
  		 */	
  		public static function handleJavaScriptDialog(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.handleJavaScriptDialog", paramO);
  		}
  		
  		/**
  		 * navigate
  		 * Navigates current page to the given URL.
  		 * @param url:string optional:{#@optional#} URL to navigate the page to.
  		 * @param referrer:string optional:true Referrer URL.
  		 * @param transitionType:{#@type#} optional:true Intended transition type.
  		 * @param frameId:{#@type#} optional:true Frame id to navigate, if not specified navigates the top frame.
  		 * @return frameId:{#@type#} optional:{#@optional#} Frame id that has navigated (or failed to navigate)
  		 */	
  		public static function navigate(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.navigate", paramO);
  		}
  		
  		/**
  		 * navigateToHistoryEntry
  		 * Navigates current page to the given history entry.
  		 * @param entryId:integer optional:{#@optional#} Unique id of the entry to navigate to.
  		 * @return 
  		 */	
  		public static function navigateToHistoryEntry(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.navigateToHistoryEntry", paramO);
  		}
  		
  		/**
  		 * printToPDF
  		 * Print page as PDF.
  		 * @param landscape:boolean optional:true Paper orientation. Defaults to false.
  		 * @param displayHeaderFooter:boolean optional:true Display header and footer. Defaults to false.
  		 * @param printBackground:boolean optional:true Print background graphics. Defaults to false.
  		 * @param scale:number optional:true Scale of the webpage rendering. Defaults to 1.
  		 * @param paperWidth:number optional:true Paper width in inches. Defaults to 8.5 inches.
  		 * @param paperHeight:number optional:true Paper height in inches. Defaults to 11 inches.
  		 * @param marginTop:number optional:true Top margin in inches. Defaults to 1cm (~0.4 inches).
  		 * @param marginBottom:number optional:true Bottom margin in inches. Defaults to 1cm (~0.4 inches).
  		 * @param marginLeft:number optional:true Left margin in inches. Defaults to 1cm (~0.4 inches).
  		 * @param marginRight:number optional:true Right margin in inches. Defaults to 1cm (~0.4 inches).
  		 * @param pageRanges:string optional:true Paper ranges to print, e.g., '1-5, 8, 11-13'. Defaults to the empty string, which means
  	print all pages.
  		 * @param ignoreInvalidPageRanges:boolean optional:true Whether to silently ignore invalid but successfully parsed page ranges, such as '3-2'.
  	Defaults to false.
  		 * @param headerTemplate:string optional:true HTML template for the print header. Should be valid HTML markup with following
  	classes used to inject printing values into them:
  	- `date`: formatted print date
  	- `title`: document title
  	- `url`: document location
  	- `pageNumber`: current page number
  	- `totalPages`: total pages in the document
  	
  	For example, `<span class=title></span>` would generate span containing the title.
  		 * @param footerTemplate:string optional:true HTML template for the print footer. Should use the same format as the `headerTemplate`.
  		 * @param preferCSSPageSize:boolean optional:true Whether or not to prefer page size as defined by css. Defaults to false,
  	in which case the content will be scaled to fit the paper size.
  		 * @return data:string optional:{#@optional#} Base64-encoded pdf data.
  		 */	
  		public static function printToPDF(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.printToPDF", paramO);
  		}
  		
  		/**
  		 * reload
  		 * Reloads given page optionally ignoring the cache.
  		 * @param ignoreCache:boolean optional:true If true, browser cache is ignored (as if the user pressed Shift+refresh).
  		 * @param scriptToEvaluateOnLoad:string optional:true If set, the script will be injected into all frames of the inspected page after reload.
  	Argument will be ignored if reloading dataURL origin.
  		 * @return 
  		 */	
  		public static function reload(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.reload", paramO);
  		}
  		
  		/**
  		 * removeScriptToEvaluateOnLoad
  		 * Deprecated, please use removeScriptToEvaluateOnNewDocument instead.
  		 * @param identifier:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function removeScriptToEvaluateOnLoad(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.removeScriptToEvaluateOnLoad", paramO);
  		}
  		
  		/**
  		 * removeScriptToEvaluateOnNewDocument
  		 * Removes given script from the list.
  		 * @param identifier:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function removeScriptToEvaluateOnNewDocument(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.removeScriptToEvaluateOnNewDocument", paramO);
  		}
  		
  		/**
  		 * requestAppBanner
  		 * @return 
  		 */	
  		public static function requestAppBanner(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.requestAppBanner", paramO);
  		}
  		
  		/**
  		 * screencastFrameAck
  		 * Acknowledges that a screencast frame has been received by the frontend.
  		 * @param sessionId:integer optional:{#@optional#} Frame number.
  		 * @return 
  		 */	
  		public static function screencastFrameAck(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.screencastFrameAck", paramO);
  		}
  		
  		/**
  		 * searchInResource
  		 * Searches for given string in resource content.
  		 * @param frameId:{#@type#} optional:{#@optional#} Frame id for resource to search in.
  		 * @param url:string optional:{#@optional#} URL of the resource to search in.
  		 * @param query:string optional:{#@optional#} String to search for.
  		 * @param caseSensitive:boolean optional:true If true, search is case sensitive.
  		 * @param isRegex:boolean optional:true If true, treats string parameter as regex.
  		 * @return result:array optional:{#@optional#} List of search matches.
  		 */	
  		public static function searchInResource(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.searchInResource", paramO);
  		}
  		
  		/**
  		 * setAdBlockingEnabled
  		 * Enable Chrome's experimental ad filter on all sites.
  		 * @param enabled:boolean optional:{#@optional#} Whether to block ads.
  		 * @return 
  		 */	
  		public static function setAdBlockingEnabled(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.setAdBlockingEnabled", paramO);
  		}
  		
  		/**
  		 * setBypassCSP
  		 * Enable page Content Security Policy by-passing.
  		 * @param enabled:boolean optional:{#@optional#} Whether to bypass page CSP.
  		 * @return 
  		 */	
  		public static function setBypassCSP(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.setBypassCSP", paramO);
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
  		 * @param viewport:{#@type#} optional:true The viewport dimensions and scale. If not set, the override is cleared.
  		 * @return 
  		 */	
  		public static function setDeviceMetricsOverride(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.setDeviceMetricsOverride", paramO);
  		}
  		
  		/**
  		 * setDeviceOrientationOverride
  		 * Overrides the Device Orientation.
  		 * @param alpha:number optional:{#@optional#} Mock alpha
  		 * @param beta:number optional:{#@optional#} Mock beta
  		 * @param gamma:number optional:{#@optional#} Mock gamma
  		 * @return 
  		 */	
  		public static function setDeviceOrientationOverride(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.setDeviceOrientationOverride", paramO);
  		}
  		
  		/**
  		 * setFontFamilies
  		 * Set generic font families.
  		 * @param fontFamilies:{#@type#} optional:{#@optional#} Specifies font families to set. If a font family is not specified, it won't be changed.
  		 * @return 
  		 */	
  		public static function setFontFamilies(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.setFontFamilies", paramO);
  		}
  		
  		/**
  		 * setFontSizes
  		 * Set default font sizes.
  		 * @param fontSizes:{#@type#} optional:{#@optional#} Specifies font sizes to set. If a font size is not specified, it won't be changed.
  		 * @return 
  		 */	
  		public static function setFontSizes(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.setFontSizes", paramO);
  		}
  		
  		/**
  		 * setDocumentContent
  		 * Sets given markup as the document's HTML.
  		 * @param frameId:{#@type#} optional:{#@optional#} Frame id to set HTML for.
  		 * @param html:string optional:{#@optional#} HTML content to set.
  		 * @return 
  		 */	
  		public static function setDocumentContent(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.setDocumentContent", paramO);
  		}
  		
  		/**
  		 * setDownloadBehavior
  		 * Set the behavior when downloading a file.
  		 * @param behavior:string optional:{#@optional#} Whether to allow all or deny all download requests, or use default Chrome behavior if
  	available (otherwise deny).
  		 * @param downloadPath:string optional:true The default path to save downloaded files to. This is requred if behavior is set to 'allow'
  		 * @return 
  		 */	
  		public static function setDownloadBehavior(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.setDownloadBehavior", paramO);
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
  			return ChromeMsg.callCmd("Page.setGeolocationOverride", paramO);
  		}
  		
  		/**
  		 * setLifecycleEventsEnabled
  		 * Controls whether page will emit lifecycle events.
  		 * @param enabled:boolean optional:{#@optional#} If true, starts emitting lifecycle events.
  		 * @return 
  		 */	
  		public static function setLifecycleEventsEnabled(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.setLifecycleEventsEnabled", paramO);
  		}
  		
  		/**
  		 * setTouchEmulationEnabled
  		 * Toggles mouse event-based touch event emulation.
  		 * @param enabled:boolean optional:{#@optional#} Whether the touch event emulation should be enabled.
  		 * @param configuration:string optional:true Touch/gesture events configuration. Default: current platform.
  		 * @return 
  		 */	
  		public static function setTouchEmulationEnabled(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.setTouchEmulationEnabled", paramO);
  		}
  		
  		/**
  		 * startScreencast
  		 * Starts sending each frame using the `screencastFrame` event.
  		 * @param format:string optional:true Image compression format.
  		 * @param quality:integer optional:true Compression quality from range [0..100].
  		 * @param maxWidth:integer optional:true Maximum screenshot width.
  		 * @param maxHeight:integer optional:true Maximum screenshot height.
  		 * @param everyNthFrame:integer optional:true Send every n-th frame.
  		 * @return 
  		 */	
  		public static function startScreencast(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.startScreencast", paramO);
  		}
  		
  		/**
  		 * stopLoading
  		 * Force the page stop all navigations and pending resource fetches.
  		 * @return 
  		 */	
  		public static function stopLoading(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.stopLoading", paramO);
  		}
  		
  		/**
  		 * crash
  		 * Crashes renderer on the IO thread, generates minidumps.
  		 * @return 
  		 */	
  		public static function crash(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.crash", paramO);
  		}
  		
  		/**
  		 * close
  		 * Tries to close page, running its beforeunload hooks, if any.
  		 * @return 
  		 */	
  		public static function close(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.close", paramO);
  		}
  		
  		/**
  		 * setWebLifecycleState
  		 * Tries to update the web lifecycle state of the page.
  	It will transition the page to the given state according to:
  	https://github.com/WICG/web-lifecycle/
  		 * @param state:string optional:{#@optional#} Target lifecycle state
  		 * @return 
  		 */	
  		public static function setWebLifecycleState(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.setWebLifecycleState", paramO);
  		}
  		
  		/**
  		 * stopScreencast
  		 * Stops sending each frame in the `screencastFrame`.
  		 * @return 
  		 */	
  		public static function stopScreencast(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.stopScreencast", paramO);
  		}
  		
  		/**
  		 * setProduceCompilationCache
  		 * Forces compilation cache to be generated for every subresource script.
  		 * @param enabled:boolean optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function setProduceCompilationCache(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.setProduceCompilationCache", paramO);
  		}
  		
  		/**
  		 * addCompilationCache
  		 * Seeds compilation cache for given url. Compilation cache does not survive
  	cross-process navigation.
  		 * @param url:string optional:{#@optional#} {#@description#}
  		 * @param data:string optional:{#@optional#} Base64-encoded data
  		 * @return 
  		 */	
  		public static function addCompilationCache(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.addCompilationCache", paramO);
  		}
  		
  		/**
  		 * clearCompilationCache
  		 * Clears seeded compilation cache.
  		 * @return 
  		 */	
  		public static function clearCompilationCache(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.clearCompilationCache", paramO);
  		}
  		
  		/**
  		 * generateTestReport
  		 * Generates a report for testing.
  		 * @param message:string optional:{#@optional#} Message to be displayed in the report.
  		 * @param group:string optional:true Specifies the endpoint group to deliver the report to.
  		 * @return 
  		 */	
  		public static function generateTestReport(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Page.generateTestReport", paramO);
  		}
  		
	}

}