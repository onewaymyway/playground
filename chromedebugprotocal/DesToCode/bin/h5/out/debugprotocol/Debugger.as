package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Debugger 
	{
		
		public function Debugger() 
		{
			
		}
		public static const DependDomains:Array=[Runtime];
  	
  		/**
  		 * breakpointResolved
  		 * Fired when breakpoint is resolved to an actual script and location.
  		 * @param breakpointId:{#@type#} optional:{#@optional#} Breakpoint unique identifier.
  		 * @param location:{#@type#} optional:{#@optional#} Actual breakpoint location.
  		 * @return 
  		 */
  		public static const breakpointResolved:String = "Debugger.breakpointResolved";
  	
  		/**
  		 * paused
  		 * Fired when the virtual machine stopped on breakpoint or exception or any other stop criteria.
  		 * @param callFrames:array optional:{#@optional#} Call stack the virtual machine stopped on.
  		 * @param reason:string optional:{#@optional#} Pause reason.
  		 * @param data:object optional:true Object containing break-specific auxiliary properties.
  		 * @param hitBreakpoints:array optional:true Hit breakpoints IDs
  		 * @param asyncStackTrace:{#@type#} optional:true Async stack trace, if any.
  		 * @param asyncStackTraceId:{#@type#} optional:true Async stack trace, if any.
  		 * @param asyncCallStackTraceId:{#@type#} optional:true Just scheduled async call will have this stack trace as parent stack during async execution.
  	This field is available only after `Debugger.stepInto` call with `breakOnAsynCall` flag.
  		 * @return 
  		 */
  		public static const paused:String = "Debugger.paused";
  	
  		/**
  		 * resumed
  		 * Fired when the virtual machine resumed execution.
  		 * @return 
  		 */
  		public static const resumed:String = "Debugger.resumed";
  	
  		/**
  		 * scriptFailedToParse
  		 * Fired when virtual machine fails to parse the script.
  		 * @param scriptId:{#@type#} optional:{#@optional#} Identifier of the script parsed.
  		 * @param url:string optional:{#@optional#} URL or name of the script parsed (if any).
  		 * @param startLine:integer optional:{#@optional#} Line offset of the script within the resource with given URL (for script tags).
  		 * @param startColumn:integer optional:{#@optional#} Column offset of the script within the resource with given URL.
  		 * @param endLine:integer optional:{#@optional#} Last line of the script.
  		 * @param endColumn:integer optional:{#@optional#} Length of the last line of the script.
  		 * @param executionContextId:{#@type#} optional:{#@optional#} Specifies script creation context.
  		 * @param hash:string optional:{#@optional#} Content hash of the script.
  		 * @param executionContextAuxData:object optional:true Embedder-specific auxiliary data.
  		 * @param sourceMapURL:string optional:true URL of source map associated with script (if any).
  		 * @param hasSourceURL:boolean optional:true True, if this script has sourceURL.
  		 * @param isModule:boolean optional:true True, if this script is ES6 module.
  		 * @param length:integer optional:true This script length.
  		 * @param stackTrace:{#@type#} optional:true JavaScript top stack frame of where the script parsed event was triggered if available.
  		 * @return 
  		 */
  		public static const scriptFailedToParse:String = "Debugger.scriptFailedToParse";
  	
  		/**
  		 * scriptParsed
  		 * Fired when virtual machine parses script. This event is also fired for all known and uncollected
  	scripts upon enabling debugger.
  		 * @param scriptId:{#@type#} optional:{#@optional#} Identifier of the script parsed.
  		 * @param url:string optional:{#@optional#} URL or name of the script parsed (if any).
  		 * @param startLine:integer optional:{#@optional#} Line offset of the script within the resource with given URL (for script tags).
  		 * @param startColumn:integer optional:{#@optional#} Column offset of the script within the resource with given URL.
  		 * @param endLine:integer optional:{#@optional#} Last line of the script.
  		 * @param endColumn:integer optional:{#@optional#} Length of the last line of the script.
  		 * @param executionContextId:{#@type#} optional:{#@optional#} Specifies script creation context.
  		 * @param hash:string optional:{#@optional#} Content hash of the script.
  		 * @param executionContextAuxData:object optional:true Embedder-specific auxiliary data.
  		 * @param isLiveEdit:boolean optional:true True, if this script is generated as a result of the live edit operation.
  		 * @param sourceMapURL:string optional:true URL of source map associated with script (if any).
  		 * @param hasSourceURL:boolean optional:true True, if this script has sourceURL.
  		 * @param isModule:boolean optional:true True, if this script is ES6 module.
  		 * @param length:integer optional:true This script length.
  		 * @param stackTrace:{#@type#} optional:true JavaScript top stack frame of where the script parsed event was triggered if available.
  		 * @return 
  		 */
  		public static const scriptParsed:String = "Debugger.scriptParsed";
  		/**
  		 * continueToLocation
  		 * Continues execution until specific location is reached.
  		 * @param location:{#@type#} optional:{#@optional#} Location to continue to.
  		 * @param targetCallFrames:string optional:true {#@description#}
  		 * @return 
  		 */	
  		public static function continueToLocation(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.continueToLocation", paramO);
  		}
  		
  		/**
  		 * disable
  		 * Disables debugger for given page.
  		 * @return 
  		 */	
  		public static function disable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.disable", paramO);
  		}
  		
  		/**
  		 * enable
  		 * Enables debugger for the given page. Clients should not assume that the debugging has been
  	enabled until the result for this command is received.
  		 * @return debuggerId:{#@type#} optional:{#@optional#} Unique identifier of the debugger.
  		 */	
  		public static function enable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.enable", paramO);
  		}
  		
  		/**
  		 * evaluateOnCallFrame
  		 * Evaluates expression on a given call frame.
  		 * @param callFrameId:{#@type#} optional:{#@optional#} Call frame identifier to evaluate on.
  		 * @param expression:string optional:{#@optional#} Expression to evaluate.
  		 * @param objectGroup:string optional:true String object group name to put result into (allows rapid releasing resulting object handles
  	using `releaseObjectGroup`).
  		 * @param includeCommandLineAPI:boolean optional:true Specifies whether command line API should be available to the evaluated expression, defaults
  	to false.
  		 * @param silent:boolean optional:true In silent mode exceptions thrown during evaluation are not reported and do not pause
  	execution. Overrides `setPauseOnException` state.
  		 * @param returnByValue:boolean optional:true Whether the result is expected to be a JSON object that should be sent by value.
  		 * @param generatePreview:boolean optional:true Whether preview should be generated for the result.
  		 * @param throwOnSideEffect:boolean optional:true Whether to throw an exception if side effect cannot be ruled out during evaluation.
  		 * @param timeout:{#@type#} optional:true Terminate execution after timing out (number of milliseconds).
  		 * @return result:{#@type#} optional:{#@optional#} Object wrapper for the evaluation result.
  		 */	
  		public static function evaluateOnCallFrame(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.evaluateOnCallFrame", paramO);
  		}
  		
  		/**
  		 * getPossibleBreakpoints
  		 * Returns possible locations for breakpoint. scriptId in start and end range locations should be
  	the same.
  		 * @param start:{#@type#} optional:{#@optional#} Start of range to search possible breakpoint locations in.
  		 * @param end:{#@type#} optional:true End of range to search possible breakpoint locations in (excluding). When not specified, end
  	of scripts is used as end of range.
  		 * @param restrictToFunction:boolean optional:true Only consider locations which are in the same (non-nested) function as start.
  		 * @return locations:array optional:{#@optional#} List of the possible breakpoint locations.
  		 */	
  		public static function getPossibleBreakpoints(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.getPossibleBreakpoints", paramO);
  		}
  		
  		/**
  		 * getScriptSource
  		 * Returns source for the script with given id.
  		 * @param scriptId:{#@type#} optional:{#@optional#} Id of the script to get source for.
  		 * @return scriptSource:string optional:{#@optional#} Script source.
  		 */	
  		public static function getScriptSource(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.getScriptSource", paramO);
  		}
  		
  		/**
  		 * getStackTrace
  		 * Returns stack trace with given `stackTraceId`.
  		 * @param stackTraceId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return stackTrace:{#@type#} optional:{#@optional#} {#@description#}
  		 */	
  		public static function getStackTrace(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.getStackTrace", paramO);
  		}
  		
  		/**
  		 * pause
  		 * Stops on the next JavaScript statement.
  		 * @return 
  		 */	
  		public static function pause(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.pause", paramO);
  		}
  		
  		/**
  		 * pauseOnAsyncCall
  		 * @param parentStackTraceId:{#@type#} optional:{#@optional#} Debugger will pause when async call with given stack trace is started.
  		 * @return 
  		 */	
  		public static function pauseOnAsyncCall(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.pauseOnAsyncCall", paramO);
  		}
  		
  		/**
  		 * removeBreakpoint
  		 * Removes JavaScript breakpoint.
  		 * @param breakpointId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function removeBreakpoint(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.removeBreakpoint", paramO);
  		}
  		
  		/**
  		 * restartFrame
  		 * Restarts particular call frame from the beginning.
  		 * @param callFrameId:{#@type#} optional:{#@optional#} Call frame identifier to evaluate on.
  		 * @return callFrames:array optional:{#@optional#} New stack trace.
  		 */	
  		public static function restartFrame(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.restartFrame", paramO);
  		}
  		
  		/**
  		 * resume
  		 * Resumes JavaScript execution.
  		 * @return 
  		 */	
  		public static function resume(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.resume", paramO);
  		}
  		
  		/**
  		 * scheduleStepIntoAsync
  		 * This method is deprecated - use Debugger.stepInto with breakOnAsyncCall and
  	Debugger.pauseOnAsyncTask instead. Steps into next scheduled async task if any is scheduled
  	before next pause. Returns success when async task is actually scheduled, returns error if no
  	task were scheduled or another scheduleStepIntoAsync was called.
  		 * @return 
  		 */	
  		public static function scheduleStepIntoAsync(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.scheduleStepIntoAsync", paramO);
  		}
  		
  		/**
  		 * searchInContent
  		 * Searches for given string in script content.
  		 * @param scriptId:{#@type#} optional:{#@optional#} Id of the script to search in.
  		 * @param query:string optional:{#@optional#} String to search for.
  		 * @param caseSensitive:boolean optional:true If true, search is case sensitive.
  		 * @param isRegex:boolean optional:true If true, treats string parameter as regex.
  		 * @return result:array optional:{#@optional#} List of search matches.
  		 */	
  		public static function searchInContent(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.searchInContent", paramO);
  		}
  		
  		/**
  		 * setAsyncCallStackDepth
  		 * Enables or disables async call stacks tracking.
  		 * @param maxDepth:integer optional:{#@optional#} Maximum depth of async call stacks. Setting to `0` will effectively disable collecting async
  	call stacks (default).
  		 * @return 
  		 */	
  		public static function setAsyncCallStackDepth(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.setAsyncCallStackDepth", paramO);
  		}
  		
  		/**
  		 * setBlackboxPatterns
  		 * Replace previous blackbox patterns with passed ones. Forces backend to skip stepping/pausing in
  	scripts with url matching one of the patterns. VM will try to leave blackboxed script by
  	performing 'step in' several times, finally resorting to 'step out' if unsuccessful.
  		 * @param patterns:array optional:{#@optional#} Array of regexps that will be used to check script url for blackbox state.
  		 * @return 
  		 */	
  		public static function setBlackboxPatterns(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.setBlackboxPatterns", paramO);
  		}
  		
  		/**
  		 * setBlackboxedRanges
  		 * Makes backend skip steps in the script in blackboxed ranges. VM will try leave blacklisted
  	scripts by performing 'step in' several times, finally resorting to 'step out' if unsuccessful.
  	Positions array contains positions where blackbox state is changed. First interval isn't
  	blackboxed. Array should be sorted.
  		 * @param scriptId:{#@type#} optional:{#@optional#} Id of the script.
  		 * @param positions:array optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function setBlackboxedRanges(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.setBlackboxedRanges", paramO);
  		}
  		
  		/**
  		 * setBreakpoint
  		 * Sets JavaScript breakpoint at a given location.
  		 * @param location:{#@type#} optional:{#@optional#} Location to set breakpoint in.
  		 * @param condition:string optional:true Expression to use as a breakpoint condition. When specified, debugger will only stop on the
  	breakpoint if this expression evaluates to true.
  		 * @return breakpointId:{#@type#} optional:{#@optional#} Id of the created breakpoint for further reference.
  		 */	
  		public static function setBreakpoint(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.setBreakpoint", paramO);
  		}
  		
  		/**
  		 * setBreakpointByUrl
  		 * Sets JavaScript breakpoint at given location specified either by URL or URL regex. Once this
  	command is issued, all existing parsed scripts will have breakpoints resolved and returned in
  	`locations` property. Further matching script parsing will result in subsequent
  	`breakpointResolved` events issued. This logical breakpoint will survive page reloads.
  		 * @param lineNumber:integer optional:{#@optional#} Line number to set breakpoint at.
  		 * @param url:string optional:true URL of the resources to set breakpoint on.
  		 * @param urlRegex:string optional:true Regex pattern for the URLs of the resources to set breakpoints on. Either `url` or
  	`urlRegex` must be specified.
  		 * @param scriptHash:string optional:true Script hash of the resources to set breakpoint on.
  		 * @param columnNumber:integer optional:true Offset in the line to set breakpoint at.
  		 * @param condition:string optional:true Expression to use as a breakpoint condition. When specified, debugger will only stop on the
  	breakpoint if this expression evaluates to true.
  		 * @return breakpointId:{#@type#} optional:{#@optional#} Id of the created breakpoint for further reference.
  		 */	
  		public static function setBreakpointByUrl(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.setBreakpointByUrl", paramO);
  		}
  		
  		/**
  		 * setBreakpointOnFunctionCall
  		 * Sets JavaScript breakpoint before each call to the given function.
  	If another function was created from the same source as a given one,
  	calling it will also trigger the breakpoint.
  		 * @param objectId:{#@type#} optional:{#@optional#} Function object id.
  		 * @param condition:string optional:true Expression to use as a breakpoint condition. When specified, debugger will
  	stop on the breakpoint if this expression evaluates to true.
  		 * @return breakpointId:{#@type#} optional:{#@optional#} Id of the created breakpoint for further reference.
  		 */	
  		public static function setBreakpointOnFunctionCall(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.setBreakpointOnFunctionCall", paramO);
  		}
  		
  		/**
  		 * setBreakpointsActive
  		 * Activates / deactivates all breakpoints on the page.
  		 * @param active:boolean optional:{#@optional#} New value for breakpoints active state.
  		 * @return 
  		 */	
  		public static function setBreakpointsActive(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.setBreakpointsActive", paramO);
  		}
  		
  		/**
  		 * setPauseOnExceptions
  		 * Defines pause on exceptions state. Can be set to stop on all exceptions, uncaught exceptions or
  	no exceptions. Initial pause on exceptions state is `none`.
  		 * @param state:string optional:{#@optional#} Pause on exceptions mode.
  		 * @return 
  		 */	
  		public static function setPauseOnExceptions(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.setPauseOnExceptions", paramO);
  		}
  		
  		/**
  		 * setReturnValue
  		 * Changes return value in top frame. Available only at return break position.
  		 * @param newValue:{#@type#} optional:{#@optional#} New return value.
  		 * @return 
  		 */	
  		public static function setReturnValue(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.setReturnValue", paramO);
  		}
  		
  		/**
  		 * setScriptSource
  		 * Edits JavaScript source live.
  		 * @param scriptId:{#@type#} optional:{#@optional#} Id of the script to edit.
  		 * @param scriptSource:string optional:{#@optional#} New content of the script.
  		 * @param dryRun:boolean optional:true If true the change will not actually be applied. Dry run may be used to get result
  	description without actually modifying the code.
  		 * @return callFrames:array optional:true New stack trace in case editing has happened while VM was stopped.
  		 */	
  		public static function setScriptSource(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.setScriptSource", paramO);
  		}
  		
  		/**
  		 * setSkipAllPauses
  		 * Makes page not interrupt on any pauses (breakpoint, exception, dom exception etc).
  		 * @param skip:boolean optional:{#@optional#} New value for skip pauses state.
  		 * @return 
  		 */	
  		public static function setSkipAllPauses(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.setSkipAllPauses", paramO);
  		}
  		
  		/**
  		 * setVariableValue
  		 * Changes value of variable in a callframe. Object-based scopes are not supported and must be
  	mutated manually.
  		 * @param scopeNumber:integer optional:{#@optional#} 0-based number of scope as was listed in scope chain. Only 'local', 'closure' and 'catch'
  	scope types are allowed. Other scopes could be manipulated manually.
  		 * @param variableName:string optional:{#@optional#} Variable name.
  		 * @param newValue:{#@type#} optional:{#@optional#} New variable value.
  		 * @param callFrameId:{#@type#} optional:{#@optional#} Id of callframe that holds variable.
  		 * @return 
  		 */	
  		public static function setVariableValue(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.setVariableValue", paramO);
  		}
  		
  		/**
  		 * stepInto
  		 * Steps into the function call.
  		 * @param breakOnAsyncCall:boolean optional:true Debugger will issue additional Debugger.paused notification if any async task is scheduled
  	before next pause.
  		 * @return 
  		 */	
  		public static function stepInto(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.stepInto", paramO);
  		}
  		
  		/**
  		 * stepOut
  		 * Steps out of the function call.
  		 * @return 
  		 */	
  		public static function stepOut(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.stepOut", paramO);
  		}
  		
  		/**
  		 * stepOver
  		 * Steps over the statement.
  		 * @return 
  		 */	
  		public static function stepOver(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Debugger.stepOver", paramO);
  		}
  		
	}

}