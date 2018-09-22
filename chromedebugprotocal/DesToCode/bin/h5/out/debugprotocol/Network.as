package debugprotocol 
{



	public class Network 
	{
		
		public function Network() 
		{
			
		}
		public static const DependDomains:Array=[Debugger,Runtime,Security];
  	
  		/**
  		 * dataReceived
  		 * Fired when data chunk was received over the network.
  		 * @param requestId:{#@type#} optional:{#@optional#} Request identifier.
  		 * @param timestamp:{#@type#} optional:{#@optional#} Timestamp.
  		 * @param dataLength:integer optional:{#@optional#} Data chunk length.
  		 * @param encodedDataLength:integer optional:{#@optional#} Actual bytes received (might be less than dataLength for compressed encodings).
  		 * @return 
  		 */
  		public static const dataReceived:String = "Network.dataReceived";
  	
  		/**
  		 * eventSourceMessageReceived
  		 * Fired when EventSource message is received.
  		 * @param requestId:{#@type#} optional:{#@optional#} Request identifier.
  		 * @param timestamp:{#@type#} optional:{#@optional#} Timestamp.
  		 * @param eventName:string optional:{#@optional#} Message type.
  		 * @param eventId:string optional:{#@optional#} Message identifier.
  		 * @param data:string optional:{#@optional#} Message content.
  		 * @return 
  		 */
  		public static const eventSourceMessageReceived:String = "Network.eventSourceMessageReceived";
  	
  		/**
  		 * loadingFailed
  		 * Fired when HTTP request has failed to load.
  		 * @param requestId:{#@type#} optional:{#@optional#} Request identifier.
  		 * @param timestamp:{#@type#} optional:{#@optional#} Timestamp.
  		 * @param type:{#@type#} optional:{#@optional#} Resource type.
  		 * @param errorText:string optional:{#@optional#} User friendly error message.
  		 * @param canceled:boolean optional:true True if loading was canceled.
  		 * @param blockedReason:{#@type#} optional:true The reason why loading was blocked, if any.
  		 * @return 
  		 */
  		public static const loadingFailed:String = "Network.loadingFailed";
  	
  		/**
  		 * loadingFinished
  		 * Fired when HTTP request has finished loading.
  		 * @param requestId:{#@type#} optional:{#@optional#} Request identifier.
  		 * @param timestamp:{#@type#} optional:{#@optional#} Timestamp.
  		 * @param encodedDataLength:number optional:{#@optional#} Total number of bytes received for this request.
  		 * @param shouldReportCorbBlocking:boolean optional:true Set when 1) response was blocked by Cross-Origin Read Blocking and also
  	2) this needs to be reported to the DevTools console.
  		 * @return 
  		 */
  		public static const loadingFinished:String = "Network.loadingFinished";
  	
  		/**
  		 * requestIntercepted
  		 * Details of an intercepted HTTP request, which must be either allowed, blocked, modified or
  	mocked.
  		 * @param interceptionId:{#@type#} optional:{#@optional#} Each request the page makes will have a unique id, however if any redirects are encountered
  	while processing that fetch, they will be reported with the same id as the original fetch.
  	Likewise if HTTP authentication is needed then the same fetch id will be used.
  		 * @param request:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param frameId:{#@type#} optional:{#@optional#} The id of the frame that initiated the request.
  		 * @param resourceType:{#@type#} optional:{#@optional#} How the requested resource will be used.
  		 * @param isNavigationRequest:boolean optional:{#@optional#} Whether this is a navigation request, which can abort the navigation completely.
  		 * @param isDownload:boolean optional:true Set if the request is a navigation that will result in a download.
  	Only present after response is received from the server (i.e. HeadersReceived stage).
  		 * @param redirectUrl:string optional:true Redirect location, only sent if a redirect was intercepted.
  		 * @param authChallenge:{#@type#} optional:true Details of the Authorization Challenge encountered. If this is set then
  	continueInterceptedRequest must contain an authChallengeResponse.
  		 * @param responseErrorReason:{#@type#} optional:true Response error if intercepted at response stage or if redirect occurred while intercepting
  	request.
  		 * @param responseStatusCode:integer optional:true Response code if intercepted at response stage or if redirect occurred while intercepting
  	request or auth retry occurred.
  		 * @param responseHeaders:{#@type#} optional:true Response headers if intercepted at the response stage or if redirect occurred while
  	intercepting request or auth retry occurred.
  		 * @return 
  		 */
  		public static const requestIntercepted:String = "Network.requestIntercepted";
  	
  		/**
  		 * requestServedFromCache
  		 * Fired if request ended up loading from cache.
  		 * @param requestId:{#@type#} optional:{#@optional#} Request identifier.
  		 * @return 
  		 */
  		public static const requestServedFromCache:String = "Network.requestServedFromCache";
  	
  		/**
  		 * requestWillBeSent
  		 * Fired when page is about to send HTTP request.
  		 * @param requestId:{#@type#} optional:{#@optional#} Request identifier.
  		 * @param loaderId:{#@type#} optional:{#@optional#} Loader identifier. Empty string if the request is fetched from worker.
  		 * @param documentURL:string optional:{#@optional#} URL of the document this request is loaded for.
  		 * @param request:{#@type#} optional:{#@optional#} Request data.
  		 * @param timestamp:{#@type#} optional:{#@optional#} Timestamp.
  		 * @param wallTime:{#@type#} optional:{#@optional#} Timestamp.
  		 * @param initiator:{#@type#} optional:{#@optional#} Request initiator.
  		 * @param redirectResponse:{#@type#} optional:true Redirect response data.
  		 * @param type:{#@type#} optional:true Type of this resource.
  		 * @param frameId:{#@type#} optional:true Frame identifier.
  		 * @param hasUserGesture:boolean optional:true Whether the request is initiated by a user gesture. Defaults to false.
  		 * @return 
  		 */
  		public static const requestWillBeSent:String = "Network.requestWillBeSent";
  	
  		/**
  		 * resourceChangedPriority
  		 * Fired when resource loading priority is changed
  		 * @param requestId:{#@type#} optional:{#@optional#} Request identifier.
  		 * @param newPriority:{#@type#} optional:{#@optional#} New priority
  		 * @param timestamp:{#@type#} optional:{#@optional#} Timestamp.
  		 * @return 
  		 */
  		public static const resourceChangedPriority:String = "Network.resourceChangedPriority";
  	
  		/**
  		 * signedExchangeReceived
  		 * Fired when a signed exchange was received over the network
  		 * @param requestId:{#@type#} optional:{#@optional#} Request identifier.
  		 * @param info:{#@type#} optional:{#@optional#} Information about the signed exchange response.
  		 * @return 
  		 */
  		public static const signedExchangeReceived:String = "Network.signedExchangeReceived";
  	
  		/**
  		 * responseReceived
  		 * Fired when HTTP response is available.
  		 * @param requestId:{#@type#} optional:{#@optional#} Request identifier.
  		 * @param loaderId:{#@type#} optional:{#@optional#} Loader identifier. Empty string if the request is fetched from worker.
  		 * @param timestamp:{#@type#} optional:{#@optional#} Timestamp.
  		 * @param type:{#@type#} optional:{#@optional#} Resource type.
  		 * @param response:{#@type#} optional:{#@optional#} Response data.
  		 * @param frameId:{#@type#} optional:true Frame identifier.
  		 * @return 
  		 */
  		public static const responseReceived:String = "Network.responseReceived";
  	
  		/**
  		 * webSocketClosed
  		 * Fired when WebSocket is closed.
  		 * @param requestId:{#@type#} optional:{#@optional#} Request identifier.
  		 * @param timestamp:{#@type#} optional:{#@optional#} Timestamp.
  		 * @return 
  		 */
  		public static const webSocketClosed:String = "Network.webSocketClosed";
  	
  		/**
  		 * webSocketCreated
  		 * Fired upon WebSocket creation.
  		 * @param requestId:{#@type#} optional:{#@optional#} Request identifier.
  		 * @param url:string optional:{#@optional#} WebSocket request URL.
  		 * @param initiator:{#@type#} optional:true Request initiator.
  		 * @return 
  		 */
  		public static const webSocketCreated:String = "Network.webSocketCreated";
  	
  		/**
  		 * webSocketFrameError
  		 * Fired when WebSocket frame error occurs.
  		 * @param requestId:{#@type#} optional:{#@optional#} Request identifier.
  		 * @param timestamp:{#@type#} optional:{#@optional#} Timestamp.
  		 * @param errorMessage:string optional:{#@optional#} WebSocket frame error message.
  		 * @return 
  		 */
  		public static const webSocketFrameError:String = "Network.webSocketFrameError";
  	
  		/**
  		 * webSocketFrameReceived
  		 * Fired when WebSocket frame is received.
  		 * @param requestId:{#@type#} optional:{#@optional#} Request identifier.
  		 * @param timestamp:{#@type#} optional:{#@optional#} Timestamp.
  		 * @param response:{#@type#} optional:{#@optional#} WebSocket response data.
  		 * @return 
  		 */
  		public static const webSocketFrameReceived:String = "Network.webSocketFrameReceived";
  	
  		/**
  		 * webSocketFrameSent
  		 * Fired when WebSocket frame is sent.
  		 * @param requestId:{#@type#} optional:{#@optional#} Request identifier.
  		 * @param timestamp:{#@type#} optional:{#@optional#} Timestamp.
  		 * @param response:{#@type#} optional:{#@optional#} WebSocket response data.
  		 * @return 
  		 */
  		public static const webSocketFrameSent:String = "Network.webSocketFrameSent";
  	
  		/**
  		 * webSocketHandshakeResponseReceived
  		 * Fired when WebSocket handshake response becomes available.
  		 * @param requestId:{#@type#} optional:{#@optional#} Request identifier.
  		 * @param timestamp:{#@type#} optional:{#@optional#} Timestamp.
  		 * @param response:{#@type#} optional:{#@optional#} WebSocket response data.
  		 * @return 
  		 */
  		public static const webSocketHandshakeResponseReceived:String = "Network.webSocketHandshakeResponseReceived";
  	
  		/**
  		 * webSocketWillSendHandshakeRequest
  		 * Fired when WebSocket is about to initiate handshake.
  		 * @param requestId:{#@type#} optional:{#@optional#} Request identifier.
  		 * @param timestamp:{#@type#} optional:{#@optional#} Timestamp.
  		 * @param wallTime:{#@type#} optional:{#@optional#} UTC Timestamp.
  		 * @param request:{#@type#} optional:{#@optional#} WebSocket request data.
  		 * @return 
  		 */
  		public static const webSocketWillSendHandshakeRequest:String = "Network.webSocketWillSendHandshakeRequest";
  	
  		/**
  		 * canClearBrowserCache
  		 * Tells whether clearing browser cache is supported.
  		 * @return result:boolean optional:{#@optional#} True if browser cache can be cleared.
  		 */
  		public static const canClearBrowserCache:String = "Network.canClearBrowserCache";
  	
  		/**
  		 * canClearBrowserCookies
  		 * Tells whether clearing browser cookies is supported.
  		 * @return result:boolean optional:{#@optional#} True if browser cookies can be cleared.
  		 */
  		public static const canClearBrowserCookies:String = "Network.canClearBrowserCookies";
  	
  		/**
  		 * canEmulateNetworkConditions
  		 * Tells whether emulation of network conditions is supported.
  		 * @return result:boolean optional:{#@optional#} True if emulation of network conditions is supported.
  		 */
  		public static const canEmulateNetworkConditions:String = "Network.canEmulateNetworkConditions";
  	
  		/**
  		 * clearBrowserCache
  		 * Clears browser cache.
  		 * @return 
  		 */
  		public static const clearBrowserCache:String = "Network.clearBrowserCache";
  	
  		/**
  		 * clearBrowserCookies
  		 * Clears browser cookies.
  		 * @return 
  		 */
  		public static const clearBrowserCookies:String = "Network.clearBrowserCookies";
  	
  		/**
  		 * continueInterceptedRequest
  		 * Response to Network.requestIntercepted which either modifies the request to continue with any
  	modifications, or blocks it, or completes it with the provided response bytes. If a network
  	fetch occurs as a result which encounters a redirect an additional Network.requestIntercepted
  	event will be sent with the same InterceptionId.
  		 * @param interceptionId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param errorReason:{#@type#} optional:true If set this causes the request to fail with the given reason. Passing `Aborted` for requests
  	marked with `isNavigationRequest` also cancels the navigation. Must not be set in response
  	to an authChallenge.
  		 * @param rawResponse:string optional:true If set the requests completes using with the provided base64 encoded raw response, including
  	HTTP status line and headers etc... Must not be set in response to an authChallenge.
  		 * @param url:string optional:true If set the request url will be modified in a way that's not observable by page. Must not be
  	set in response to an authChallenge.
  		 * @param method:string optional:true If set this allows the request method to be overridden. Must not be set in response to an
  	authChallenge.
  		 * @param postData:string optional:true If set this allows postData to be set. Must not be set in response to an authChallenge.
  		 * @param headers:{#@type#} optional:true If set this allows the request headers to be changed. Must not be set in response to an
  	authChallenge.
  		 * @param authChallengeResponse:{#@type#} optional:true Response to a requestIntercepted with an authChallenge. Must not be set otherwise.
  		 * @return 
  		 */
  		public static const continueInterceptedRequest:String = "Network.continueInterceptedRequest";
  	
  		/**
  		 * deleteCookies
  		 * Deletes browser cookies with matching name and url or domain/path pair.
  		 * @param name:string optional:{#@optional#} Name of the cookies to remove.
  		 * @param url:string optional:true If specified, deletes all the cookies with the given name where domain and path match
  	provided URL.
  		 * @param domain:string optional:true If specified, deletes only cookies with the exact domain.
  		 * @param path:string optional:true If specified, deletes only cookies with the exact path.
  		 * @return 
  		 */
  		public static const deleteCookies:String = "Network.deleteCookies";
  	
  		/**
  		 * disable
  		 * Disables network tracking, prevents network events from being sent to the client.
  		 * @return 
  		 */
  		public static const disable:String = "Network.disable";
  	
  		/**
  		 * emulateNetworkConditions
  		 * Activates emulation of network conditions.
  		 * @param offline:boolean optional:{#@optional#} True to emulate internet disconnection.
  		 * @param latency:number optional:{#@optional#} Minimum latency from request sent to response headers received (ms).
  		 * @param downloadThroughput:number optional:{#@optional#} Maximal aggregated download throughput (bytes/sec). -1 disables download throttling.
  		 * @param uploadThroughput:number optional:{#@optional#} Maximal aggregated upload throughput (bytes/sec).  -1 disables upload throttling.
  		 * @param connectionType:{#@type#} optional:true Connection type if known.
  		 * @return 
  		 */
  		public static const emulateNetworkConditions:String = "Network.emulateNetworkConditions";
  	
  		/**
  		 * enable
  		 * Enables network tracking, network events will now be delivered to the client.
  		 * @param maxTotalBufferSize:integer optional:true Buffer size in bytes to use when preserving network payloads (XHRs, etc).
  		 * @param maxResourceBufferSize:integer optional:true Per-resource buffer size in bytes to use when preserving network payloads (XHRs, etc).
  		 * @param maxPostDataSize:integer optional:true Longest post body size (in bytes) that would be included in requestWillBeSent notification
  		 * @return 
  		 */
  		public static const enable:String = "Network.enable";
  	
  		/**
  		 * getAllCookies
  		 * Returns all browser cookies. Depending on the backend support, will return detailed cookie
  	information in the `cookies` field.
  		 * @return cookies:array optional:{#@optional#} Array of cookie objects.
  		 */
  		public static const getAllCookies:String = "Network.getAllCookies";
  	
  		/**
  		 * getCertificate
  		 * Returns the DER-encoded certificate.
  		 * @param origin:string optional:{#@optional#} Origin to get certificate for.
  		 * @return tableNames:array optional:{#@optional#} {#@description#}
  		 */
  		public static const getCertificate:String = "Network.getCertificate";
  	
  		/**
  		 * getCookies
  		 * Returns all browser cookies for the current URL. Depending on the backend support, will return
  	detailed cookie information in the `cookies` field.
  		 * @param urls:array optional:true The list of URLs for which applicable cookies will be fetched
  		 * @return cookies:array optional:{#@optional#} Array of cookie objects.
  		 */
  		public static const getCookies:String = "Network.getCookies";
  	
  		/**
  		 * getResponseBody
  		 * Returns content served for the given request.
  		 * @param requestId:{#@type#} optional:{#@optional#} Identifier of the network request to get content for.
  		 * @return body:string optional:{#@optional#} Response body.
  		 */
  		public static const getResponseBody:String = "Network.getResponseBody";
  	
  		/**
  		 * getRequestPostData
  		 * Returns post data sent with the request. Returns an error when no data was sent with the request.
  		 * @param requestId:{#@type#} optional:{#@optional#} Identifier of the network request to get content for.
  		 * @return postData:string optional:{#@optional#} Base64-encoded request body.
  		 */
  		public static const getRequestPostData:String = "Network.getRequestPostData";
  	
  		/**
  		 * getResponseBodyForInterception
  		 * Returns content served for the given currently intercepted request.
  		 * @param interceptionId:{#@type#} optional:{#@optional#} Identifier for the intercepted request to get body for.
  		 * @return body:string optional:{#@optional#} Response body.
  		 */
  		public static const getResponseBodyForInterception:String = "Network.getResponseBodyForInterception";
  	
  		/**
  		 * takeResponseBodyForInterceptionAsStream
  		 * Returns a handle to the stream representing the response body. Note that after this command,
  	the intercepted request can't be continued as is -- you either need to cancel it or to provide
  	the response body. The stream only supports sequential read, IO.read will fail if the position
  	is specified.
  		 * @param interceptionId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return stream:{#@type#} optional:{#@optional#} {#@description#}
  		 */
  		public static const takeResponseBodyForInterceptionAsStream:String = "Network.takeResponseBodyForInterceptionAsStream";
  	
  		/**
  		 * replayXHR
  		 * This method sends a new XMLHttpRequest which is identical to the original one. The following
  	parameters should be identical: method, url, async, request body, extra headers, withCredentials
  	attribute, user, password.
  		 * @param requestId:{#@type#} optional:{#@optional#} Identifier of XHR to replay.
  		 * @return 
  		 */
  		public static const replayXHR:String = "Network.replayXHR";
  	
  		/**
  		 * searchInResponseBody
  		 * Searches for given string in response content.
  		 * @param requestId:{#@type#} optional:{#@optional#} Identifier of the network response to search.
  		 * @param query:string optional:{#@optional#} String to search for.
  		 * @param caseSensitive:boolean optional:true If true, search is case sensitive.
  		 * @param isRegex:boolean optional:true If true, treats string parameter as regex.
  		 * @return result:array optional:{#@optional#} List of search matches.
  		 */
  		public static const searchInResponseBody:String = "Network.searchInResponseBody";
  	
  		/**
  		 * setBlockedURLs
  		 * Blocks URLs from loading.
  		 * @param urls:array optional:{#@optional#} URL patterns to block. Wildcards ('*') are allowed.
  		 * @return 
  		 */
  		public static const setBlockedURLs:String = "Network.setBlockedURLs";
  	
  		/**
  		 * setBypassServiceWorker
  		 * Toggles ignoring of service worker for each request.
  		 * @param bypass:boolean optional:{#@optional#} Bypass service worker and load from network.
  		 * @return 
  		 */
  		public static const setBypassServiceWorker:String = "Network.setBypassServiceWorker";
  	
  		/**
  		 * setCacheDisabled
  		 * Toggles ignoring cache for each request. If `true`, cache will not be used.
  		 * @param cacheDisabled:boolean optional:{#@optional#} Cache disabled state.
  		 * @return 
  		 */
  		public static const setCacheDisabled:String = "Network.setCacheDisabled";
  	
  		/**
  		 * setCookie
  		 * Sets a cookie with the given cookie data; may overwrite equivalent cookies if they exist.
  		 * @param name:string optional:{#@optional#} Cookie name.
  		 * @param value:string optional:{#@optional#} Cookie value.
  		 * @param url:string optional:true The request-URI to associate with the setting of the cookie. This value can affect the
  	default domain and path values of the created cookie.
  		 * @param domain:string optional:true Cookie domain.
  		 * @param path:string optional:true Cookie path.
  		 * @param secure:boolean optional:true True if cookie is secure.
  		 * @param httpOnly:boolean optional:true True if cookie is http-only.
  		 * @param sameSite:{#@type#} optional:true Cookie SameSite type.
  		 * @param expires:{#@type#} optional:true Cookie expiration date, session cookie if not set
  		 * @return success:boolean optional:{#@optional#} True if successfully set cookie.
  		 */
  		public static const setCookie:String = "Network.setCookie";
  	
  		/**
  		 * setCookies
  		 * Sets given cookies.
  		 * @param cookies:array optional:{#@optional#} Cookies to be set.
  		 * @return 
  		 */
  		public static const setCookies:String = "Network.setCookies";
  	
  		/**
  		 * setDataSizeLimitsForTest
  		 * For testing.
  		 * @param maxTotalSize:integer optional:{#@optional#} Maximum total buffer size.
  		 * @param maxResourceSize:integer optional:{#@optional#} Maximum per-resource size.
  		 * @return 
  		 */
  		public static const setDataSizeLimitsForTest:String = "Network.setDataSizeLimitsForTest";
  	
  		/**
  		 * setExtraHTTPHeaders
  		 * Specifies whether to always send extra HTTP headers with the requests from this page.
  		 * @param headers:{#@type#} optional:{#@optional#} Map with extra HTTP headers.
  		 * @return 
  		 */
  		public static const setExtraHTTPHeaders:String = "Network.setExtraHTTPHeaders";
  	
  		/**
  		 * setRequestInterception
  		 * Sets the requests to intercept that match a the provided patterns and optionally resource types.
  		 * @param patterns:array optional:{#@optional#} Requests matching any of these patterns will be forwarded and wait for the corresponding
  	continueInterceptedRequest call.
  		 * @return 
  		 */
  		public static const setRequestInterception:String = "Network.setRequestInterception";
  	
  		/**
  		 * setUserAgentOverride
  		 * Allows overriding user agent with the given string.
  		 * @param userAgent:string optional:{#@optional#} User agent to use.
  		 * @param acceptLanguage:string optional:true Browser langugage to emulate.
  		 * @param platform:string optional:true The platform navigator.platform should return.
  		 * @return 
  		 */
  		public static const setUserAgentOverride:String = "Network.setUserAgentOverride";
	}

}