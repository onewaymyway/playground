package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Input 
	{
		
		public function Input() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  		/**
  		 * dispatchKeyEvent
  		 * Dispatches a key event to the page.
  		 * @param type:string optional:{#@optional#} Type of the key event.
  		 * @param modifiers:integer optional:true Bit field representing pressed modifier keys. Alt=1, Ctrl=2, Meta/Command=4, Shift=8
  	(default: 0).
  		 * @param timestamp:{#@type#} optional:true Time at which the event occurred.
  		 * @param text:string optional:true Text as generated by processing a virtual key code with a keyboard layout. Not needed for
  	for `keyUp` and `rawKeyDown` events (default: "")
  		 * @param unmodifiedText:string optional:true Text that would have been generated by the keyboard if no modifiers were pressed (except for
  	shift). Useful for shortcut (accelerator) key handling (default: "").
  		 * @param keyIdentifier:string optional:true Unique key identifier (e.g., 'U+0041') (default: "").
  		 * @param code:string optional:true Unique DOM defined string value for each physical key (e.g., 'KeyA') (default: "").
  		 * @param key:string optional:true Unique DOM defined string value describing the meaning of the key in the context of active
  	modifiers, keyboard layout, etc (e.g., 'AltGr') (default: "").
  		 * @param windowsVirtualKeyCode:integer optional:true Windows virtual key code (default: 0).
  		 * @param nativeVirtualKeyCode:integer optional:true Native virtual key code (default: 0).
  		 * @param autoRepeat:boolean optional:true Whether the event was generated from auto repeat (default: false).
  		 * @param isKeypad:boolean optional:true Whether the event was generated from the keypad (default: false).
  		 * @param isSystemKey:boolean optional:true Whether the event was a system key event (default: false).
  		 * @param location:integer optional:true Whether the event was from the left or right side of the keyboard. 1=Left, 2=Right (default:
  	0).
  		 * @return 
  		 */	
  		public static function dispatchKeyEvent(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Input.dispatchKeyEvent", paramO);
  		}
  		
  		/**
  		 * insertText
  		 * This method emulates inserting text that doesn't come from a key press,
  	for example an emoji keyboard or an IME.
  		 * @param text:string optional:{#@optional#} The text to insert.
  		 * @return 
  		 */	
  		public static function insertText(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Input.insertText", paramO);
  		}
  		
  		/**
  		 * dispatchMouseEvent
  		 * Dispatches a mouse event to the page.
  		 * @param type:string optional:{#@optional#} Type of the mouse event.
  		 * @param x:number optional:{#@optional#} X coordinate of the event relative to the main frame's viewport in CSS pixels.
  		 * @param y:number optional:{#@optional#} Y coordinate of the event relative to the main frame's viewport in CSS pixels. 0 refers to
  	the top of the viewport and Y increases as it proceeds towards the bottom of the viewport.
  		 * @param modifiers:integer optional:true Bit field representing pressed modifier keys. Alt=1, Ctrl=2, Meta/Command=4, Shift=8
  	(default: 0).
  		 * @param timestamp:{#@type#} optional:true Time at which the event occurred.
  		 * @param button:string optional:true Mouse button (default: "none").
  		 * @param clickCount:integer optional:true Number of times the mouse button was clicked (default: 0).
  		 * @param deltaX:number optional:true X delta in CSS pixels for mouse wheel event (default: 0).
  		 * @param deltaY:number optional:true Y delta in CSS pixels for mouse wheel event (default: 0).
  		 * @return 
  		 */	
  		public static function dispatchMouseEvent(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Input.dispatchMouseEvent", paramO);
  		}
  		
  		/**
  		 * dispatchTouchEvent
  		 * Dispatches a touch event to the page.
  		 * @param type:string optional:{#@optional#} Type of the touch event. TouchEnd and TouchCancel must not contain any touch points, while
  	TouchStart and TouchMove must contains at least one.
  		 * @param touchPoints:array optional:{#@optional#} Active touch points on the touch device. One event per any changed point (compared to
  	previous touch event in a sequence) is generated, emulating pressing/moving/releasing points
  	one by one.
  		 * @param modifiers:integer optional:true Bit field representing pressed modifier keys. Alt=1, Ctrl=2, Meta/Command=4, Shift=8
  	(default: 0).
  		 * @param timestamp:{#@type#} optional:true Time at which the event occurred.
  		 * @return 
  		 */	
  		public static function dispatchTouchEvent(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Input.dispatchTouchEvent", paramO);
  		}
  		
  		/**
  		 * emulateTouchFromMouseEvent
  		 * Emulates touch event from the mouse event parameters.
  		 * @param type:string optional:{#@optional#} Type of the mouse event.
  		 * @param x:integer optional:{#@optional#} X coordinate of the mouse pointer in DIP.
  		 * @param y:integer optional:{#@optional#} Y coordinate of the mouse pointer in DIP.
  		 * @param button:string optional:{#@optional#} Mouse button.
  		 * @param timestamp:{#@type#} optional:true Time at which the event occurred (default: current time).
  		 * @param deltaX:number optional:true X delta in DIP for mouse wheel event (default: 0).
  		 * @param deltaY:number optional:true Y delta in DIP for mouse wheel event (default: 0).
  		 * @param modifiers:integer optional:true Bit field representing pressed modifier keys. Alt=1, Ctrl=2, Meta/Command=4, Shift=8
  	(default: 0).
  		 * @param clickCount:integer optional:true Number of times the mouse button was clicked (default: 0).
  		 * @return 
  		 */	
  		public static function emulateTouchFromMouseEvent(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Input.emulateTouchFromMouseEvent", paramO);
  		}
  		
  		/**
  		 * setIgnoreInputEvents
  		 * Ignores input events (useful while auditing page).
  		 * @param ignore:boolean optional:{#@optional#} Ignores input events processing when set to true.
  		 * @return 
  		 */	
  		public static function setIgnoreInputEvents(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Input.setIgnoreInputEvents", paramO);
  		}
  		
  		/**
  		 * synthesizePinchGesture
  		 * Synthesizes a pinch gesture over a time period by issuing appropriate touch events.
  		 * @param x:number optional:{#@optional#} X coordinate of the start of the gesture in CSS pixels.
  		 * @param y:number optional:{#@optional#} Y coordinate of the start of the gesture in CSS pixels.
  		 * @param scaleFactor:number optional:{#@optional#} Relative scale factor after zooming (>1.0 zooms in, <1.0 zooms out).
  		 * @param relativeSpeed:integer optional:true Relative pointer speed in pixels per second (default: 800).
  		 * @param gestureSourceType:{#@type#} optional:true Which type of input events to be generated (default: 'default', which queries the platform
  	for the preferred input type).
  		 * @return 
  		 */	
  		public static function synthesizePinchGesture(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Input.synthesizePinchGesture", paramO);
  		}
  		
  		/**
  		 * synthesizeScrollGesture
  		 * Synthesizes a scroll gesture over a time period by issuing appropriate touch events.
  		 * @param x:number optional:{#@optional#} X coordinate of the start of the gesture in CSS pixels.
  		 * @param y:number optional:{#@optional#} Y coordinate of the start of the gesture in CSS pixels.
  		 * @param xDistance:number optional:true The distance to scroll along the X axis (positive to scroll left).
  		 * @param yDistance:number optional:true The distance to scroll along the Y axis (positive to scroll up).
  		 * @param xOverscroll:number optional:true The number of additional pixels to scroll back along the X axis, in addition to the given
  	distance.
  		 * @param yOverscroll:number optional:true The number of additional pixels to scroll back along the Y axis, in addition to the given
  	distance.
  		 * @param preventFling:boolean optional:true Prevent fling (default: true).
  		 * @param speed:integer optional:true Swipe speed in pixels per second (default: 800).
  		 * @param gestureSourceType:{#@type#} optional:true Which type of input events to be generated (default: 'default', which queries the platform
  	for the preferred input type).
  		 * @param repeatCount:integer optional:true The number of times to repeat the gesture (default: 0).
  		 * @param repeatDelayMs:integer optional:true The number of milliseconds delay between each repeat. (default: 250).
  		 * @param interactionMarkerName:string optional:true The name of the interaction markers to generate, if not empty (default: "").
  		 * @return 
  		 */	
  		public static function synthesizeScrollGesture(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Input.synthesizeScrollGesture", paramO);
  		}
  		
  		/**
  		 * synthesizeTapGesture
  		 * Synthesizes a tap gesture over a time period by issuing appropriate touch events.
  		 * @param x:number optional:{#@optional#} X coordinate of the start of the gesture in CSS pixels.
  		 * @param y:number optional:{#@optional#} Y coordinate of the start of the gesture in CSS pixels.
  		 * @param duration:integer optional:true Duration between touchdown and touchup events in ms (default: 50).
  		 * @param tapCount:integer optional:true Number of times to perform the tap (e.g. 2 for double tap, default: 1).
  		 * @param gestureSourceType:{#@type#} optional:true Which type of input events to be generated (default: 'default', which queries the platform
  	for the preferred input type).
  		 * @return 
  		 */	
  		public static function synthesizeTapGesture(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Input.synthesizeTapGesture", paramO);
  		}
  		
	}

}