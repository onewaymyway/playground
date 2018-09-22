package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Runtime 
	{
		
		public function Runtime() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  		/**
  		 * bindingCalled
  		 * Notification is issued every time when binding is called.
  		 * @param name:string optional:{#@optional#} {#@description#}
  		 * @param payload:string optional:{#@optional#} {#@description#}
  		 * @param executionContextId:{#@type#} optional:{#@optional#} Identifier of the context where the call was made.
  		 * @return 
  		 */
  		public static const bindingCalled:String = "Runtime.bindingCalled";
  	
  		/**
  		 * consoleAPICalled
  		 * Issued when console API was called.
  		 * @param type:string optional:{#@optional#} Type of the call.
  		 * @param args:array optional:{#@optional#} Call arguments.
  		 * @param executionContextId:{#@type#} optional:{#@optional#} Identifier of the context where the call was made.
  		 * @param timestamp:{#@type#} optional:{#@optional#} Call timestamp.
  		 * @param stackTrace:{#@type#} optional:true Stack trace captured when the call was made.
  		 * @param context:string optional:true Console context descriptor for calls on non-default console context (not console.*):
  	'anonymous#unique-logger-id' for call on unnamed context, 'name#unique-logger-id' for call
  	on named context.
  		 * @return 
  		 */
  		public static const consoleAPICalled:String = "Runtime.consoleAPICalled";
  	
  		/**
  		 * exceptionRevoked
  		 * Issued when unhandled exception was revoked.
  		 * @param reason:string optional:{#@optional#} Reason describing why exception was revoked.
  		 * @param exceptionId:integer optional:{#@optional#} The id of revoked exception, as reported in `exceptionThrown`.
  		 * @return 
  		 */
  		public static const exceptionRevoked:String = "Runtime.exceptionRevoked";
  	
  		/**
  		 * exceptionThrown
  		 * Issued when exception was thrown and unhandled.
  		 * @param timestamp:{#@type#} optional:{#@optional#} Timestamp of the exception.
  		 * @param exceptionDetails:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const exceptionThrown:String = "Runtime.exceptionThrown";
  	
  		/**
  		 * executionContextCreated
  		 * Issued when new execution context is created.
  		 * @param context:{#@type#} optional:{#@optional#} A newly created execution context.
  		 * @return 
  		 */
  		public static const executionContextCreated:String = "Runtime.executionContextCreated";
  	
  		/**
  		 * executionContextDestroyed
  		 * Issued when execution context is destroyed.
  		 * @param executionContextId:{#@type#} optional:{#@optional#} Id of the destroyed context
  		 * @return 
  		 */
  		public static const executionContextDestroyed:String = "Runtime.executionContextDestroyed";
  	
  		/**
  		 * executionContextsCleared
  		 * Issued when all executionContexts were cleared in browser
  		 * @return 
  		 */
  		public static const executionContextsCleared:String = "Runtime.executionContextsCleared";
  	
  		/**
  		 * inspectRequested
  		 * Issued when object should be inspected (for example, as a result of inspect() command line API
  	call).
  		 * @param object:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param hints:object optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const inspectRequested:String = "Runtime.inspectRequested";
  		/**
  		 * awaitPromise
  		 * Add handler to promise with given promise object id.
  		 * @param promiseObjectId:{#@type#} optional:{#@optional#} Identifier of the promise.
  		 * @param returnByValue:boolean optional:true Whether the result is expected to be a JSON object that should be sent by value.
  		 * @param generatePreview:boolean optional:true Whether preview should be generated for the result.
  		 * @return result:{#@type#} optional:{#@optional#} Promise result. Will contain rejected value if promise was rejected.
  		 */	
  		public static function awaitPromise(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.awaitPromise", paramO);
  		}
  		
  		/**
  		 * callFunctionOn
  		 * Calls function with given declaration on the given object. Object group of the result is
  	inherited from the target object.
  		 * @param functionDeclaration:string optional:{#@optional#} Declaration of the function to call.
  		 * @param objectId:{#@type#} optional:true Identifier of the object to call function on. Either objectId or executionContextId should
  	be specified.
  		 * @param arguments:array optional:true Call arguments. All call arguments must belong to the same JavaScript world as the target
  	object.
  		 * @param silent:boolean optional:true In silent mode exceptions thrown during evaluation are not reported and do not pause
  	execution. Overrides `setPauseOnException` state.
  		 * @param returnByValue:boolean optional:true Whether the result is expected to be a JSON object which should be sent by value.
  		 * @param generatePreview:boolean optional:true Whether preview should be generated for the result.
  		 * @param userGesture:boolean optional:true Whether execution should be treated as initiated by user in the UI.
  		 * @param awaitPromise:boolean optional:true Whether execution should `await` for resulting value and return once awaited promise is
  	resolved.
  		 * @param executionContextId:{#@type#} optional:true Specifies execution context which global object will be used to call function on. Either
  	executionContextId or objectId should be specified.
  		 * @param objectGroup:string optional:true Symbolic group name that can be used to release multiple objects. If objectGroup is not
  	specified and objectId is, objectGroup will be inherited from object.
  		 * @return result:{#@type#} optional:{#@optional#} Call result.
  		 */	
  		public static function callFunctionOn(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.callFunctionOn", paramO);
  		}
  		
  		/**
  		 * compileScript
  		 * Compiles expression.
  		 * @param expression:string optional:{#@optional#} Expression to compile.
  		 * @param sourceURL:string optional:{#@optional#} Source url to be set for the script.
  		 * @param persistScript:boolean optional:{#@optional#} Specifies whether the compiled script should be persisted.
  		 * @param executionContextId:{#@type#} optional:true Specifies in which execution context to perform script run. If the parameter is omitted the
  	evaluation will be performed in the context of the inspected page.
  		 * @return scriptId:{#@type#} optional:true Id of the script.
  		 */	
  		public static function compileScript(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.compileScript", paramO);
  		}
  		
  		/**
  		 * disable
  		 * Disables reporting of execution contexts creation.
  		 * @return 
  		 */	
  		public static function disable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.disable", paramO);
  		}
  		
  		/**
  		 * discardConsoleEntries
  		 * Discards collected exceptions and console API calls.
  		 * @return 
  		 */	
  		public static function discardConsoleEntries(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.discardConsoleEntries", paramO);
  		}
  		
  		/**
  		 * enable
  		 * Enables reporting of execution contexts creation by means of `executionContextCreated` event.
  	When the reporting gets enabled the event will be sent immediately for each existing execution
  	context.
  		 * @return 
  		 */	
  		public static function enable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.enable", paramO);
  		}
  		
  		/**
  		 * evaluate
  		 * Evaluates expression on global object.
  		 * @param expression:string optional:{#@optional#} Expression to evaluate.
  		 * @param objectGroup:string optional:true Symbolic group name that can be used to release multiple objects.
  		 * @param includeCommandLineAPI:boolean optional:true Determines whether Command Line API should be available during the evaluation.
  		 * @param silent:boolean optional:true In silent mode exceptions thrown during evaluation are not reported and do not pause
  	execution. Overrides `setPauseOnException` state.
  		 * @param contextId:{#@type#} optional:true Specifies in which execution context to perform evaluation. If the parameter is omitted the
  	evaluation will be performed in the context of the inspected page.
  		 * @param returnByValue:boolean optional:true Whether the result is expected to be a JSON object that should be sent by value.
  		 * @param generatePreview:boolean optional:true Whether preview should be generated for the result.
  		 * @param userGesture:boolean optional:true Whether execution should be treated as initiated by user in the UI.
  		 * @param awaitPromise:boolean optional:true Whether execution should `await` for resulting value and return once awaited promise is
  	resolved.
  		 * @param throwOnSideEffect:boolean optional:true Whether to throw an exception if side effect cannot be ruled out during evaluation.
  		 * @param timeout:{#@type#} optional:true Terminate execution after timing out (number of milliseconds).
  		 * @return result:{#@type#} optional:{#@optional#} Evaluation result.
  		 */	
  		public static function evaluate(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.evaluate", paramO);
  		}
  		
  		/**
  		 * getIsolateId
  		 * Returns the isolate id.
  		 * @return id:string optional:{#@optional#} The isolate id.
  		 */	
  		public static function getIsolateId(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.getIsolateId", paramO);
  		}
  		
  		/**
  		 * getHeapUsage
  		 * Returns the JavaScript heap usage.
  	It is the total usage of the corresponding isolate not scoped to a particular Runtime.
  		 * @return usedSize:number optional:{#@optional#} Used heap size in bytes.
  		 */	
  		public static function getHeapUsage(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.getHeapUsage", paramO);
  		}
  		
  		/**
  		 * getProperties
  		 * Returns properties of a given object. Object group of the result is inherited from the target
  	object.
  		 * @param objectId:{#@type#} optional:{#@optional#} Identifier of the object to return properties for.
  		 * @param ownProperties:boolean optional:true If true, returns properties belonging only to the element itself, not to its prototype
  	chain.
  		 * @param accessorPropertiesOnly:boolean optional:true If true, returns accessor properties (with getter/setter) only; internal properties are not
  	returned either.
  		 * @param generatePreview:boolean optional:true Whether preview should be generated for the results.
  		 * @return result:array optional:{#@optional#} Object properties.
  		 */	
  		public static function getProperties(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.getProperties", paramO);
  		}
  		
  		/**
  		 * globalLexicalScopeNames
  		 * Returns all let, const and class variables from global scope.
  		 * @param executionContextId:{#@type#} optional:true Specifies in which execution context to lookup global scope variables.
  		 * @return names:array optional:{#@optional#} {#@description#}
  		 */	
  		public static function globalLexicalScopeNames(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.globalLexicalScopeNames", paramO);
  		}
  		
  		/**
  		 * queryObjects
  		 * @param prototypeObjectId:{#@type#} optional:{#@optional#} Identifier of the prototype to return objects for.
  		 * @param objectGroup:string optional:true Symbolic group name that can be used to release the results.
  		 * @return objects:{#@type#} optional:{#@optional#} Array with objects.
  		 */	
  		public static function queryObjects(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.queryObjects", paramO);
  		}
  		
  		/**
  		 * releaseObject
  		 * Releases remote object with given id.
  		 * @param objectId:{#@type#} optional:{#@optional#} Identifier of the object to release.
  		 * @return 
  		 */	
  		public static function releaseObject(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.releaseObject", paramO);
  		}
  		
  		/**
  		 * releaseObjectGroup
  		 * Releases all remote objects that belong to a given group.
  		 * @param objectGroup:string optional:{#@optional#} Symbolic object group name.
  		 * @return 
  		 */	
  		public static function releaseObjectGroup(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.releaseObjectGroup", paramO);
  		}
  		
  		/**
  		 * runIfWaitingForDebugger
  		 * Tells inspected instance to run if it was waiting for debugger to attach.
  		 * @return 
  		 */	
  		public static function runIfWaitingForDebugger(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.runIfWaitingForDebugger", paramO);
  		}
  		
  		/**
  		 * runScript
  		 * Runs script with given id in a given context.
  		 * @param scriptId:{#@type#} optional:{#@optional#} Id of the script to run.
  		 * @param executionContextId:{#@type#} optional:true Specifies in which execution context to perform script run. If the parameter is omitted the
  	evaluation will be performed in the context of the inspected page.
  		 * @param objectGroup:string optional:true Symbolic group name that can be used to release multiple objects.
  		 * @param silent:boolean optional:true In silent mode exceptions thrown during evaluation are not reported and do not pause
  	execution. Overrides `setPauseOnException` state.
  		 * @param includeCommandLineAPI:boolean optional:true Determines whether Command Line API should be available during the evaluation.
  		 * @param returnByValue:boolean optional:true Whether the result is expected to be a JSON object which should be sent by value.
  		 * @param generatePreview:boolean optional:true Whether preview should be generated for the result.
  		 * @param awaitPromise:boolean optional:true Whether execution should `await` for resulting value and return once awaited promise is
  	resolved.
  		 * @return result:{#@type#} optional:{#@optional#} Run result.
  		 */	
  		public static function runScript(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.runScript", paramO);
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
  			return ChromeMsg.callCmd("Runtime.setAsyncCallStackDepth", paramO);
  		}
  		
  		/**
  		 * setCustomObjectFormatterEnabled
  		 * @param enabled:boolean optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function setCustomObjectFormatterEnabled(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.setCustomObjectFormatterEnabled", paramO);
  		}
  		
  		/**
  		 * setMaxCallStackSizeToCapture
  		 * @param size:integer optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function setMaxCallStackSizeToCapture(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.setMaxCallStackSizeToCapture", paramO);
  		}
  		
  		/**
  		 * terminateExecution
  		 * Terminate current or next JavaScript execution.
  	Will cancel the termination when the outer-most script execution ends.
  		 * @return 
  		 */	
  		public static function terminateExecution(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.terminateExecution", paramO);
  		}
  		
  		/**
  		 * addBinding
  		 * If executionContextId is empty, adds binding with the given name on the
  	global objects of all inspected contexts, including those created later,
  	bindings survive reloads.
  	If executionContextId is specified, adds binding only on global object of
  	given execution context.
  	Binding function takes exactly one argument, this argument should be string,
  	in case of any other input, function throws an exception.
  	Each binding function call produces Runtime.bindingCalled notification.
  		 * @param name:string optional:{#@optional#} {#@description#}
  		 * @param executionContextId:{#@type#} optional:true {#@description#}
  		 * @return 
  		 */	
  		public static function addBinding(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.addBinding", paramO);
  		}
  		
  		/**
  		 * removeBinding
  		 * This method does not remove binding function from global object but
  	unsubscribes current runtime agent from Runtime.bindingCalled notifications.
  		 * @param name:string optional:{#@optional#} {#@description#}
  		 * @return 
  		 */	
  		public static function removeBinding(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Runtime.removeBinding", paramO);
  		}
  		
	}

}