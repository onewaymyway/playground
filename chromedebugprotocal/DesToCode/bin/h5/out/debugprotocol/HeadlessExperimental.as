package debugprotocol.HeadlessExperimental 
{



	public class HeadlessExperimental 
	{
		
		public function HeadlessExperimental() 
		{
			
		}
		public static const DependDomains:Array=[Page,Runtime];
  	
  		/**
  		 * needsBeginFramesChanged
  		 * Issued when the target starts or stops needing BeginFrames.
  		 * @param needsBeginFrames:boolean optional:{#@optional#} True if BeginFrames are needed, false otherwise.
  		 * @return 
  		 */
  		public static const needsBeginFramesChanged:String = "HeadlessExperimental.needsBeginFramesChanged";
  	
  		/**
  		 * beginFrame
  		 * Sends a BeginFrame to the target and returns when the frame was completed. Optionally captures a
  	screenshot from the resulting frame. Requires that the target was created with enabled
  	BeginFrameControl. Designed for use with --run-all-compositor-stages-before-draw, see also
  	https://goo.gl/3zHXhB for more background.
  		 * @param frameTimeTicks:number optional:true Timestamp of this BeginFrame in Renderer TimeTicks (milliseconds of uptime). If not set,
  	the current time will be used.
  		 * @param interval:number optional:true The interval between BeginFrames that is reported to the compositor, in milliseconds.
  	Defaults to a 60 frames/second interval, i.e. about 16.666 milliseconds.
  		 * @param noDisplayUpdates:boolean optional:true Whether updates should not be committed and drawn onto the display. False by default. If
  	true, only side effects of the BeginFrame will be run, such as layout and animations, but
  	any visual updates may not be visible on the display or in screenshots.
  		 * @param screenshot:{#@type#} optional:true If set, a screenshot of the frame will be captured and returned in the response. Otherwise,
  	no screenshot will be captured. Note that capturing a screenshot can fail, for example,
  	during renderer initialization. In such a case, no screenshot data will be returned.
  		 * @return hasDamage:boolean optional:{#@optional#} Whether the BeginFrame resulted in damage and, thus, a new frame was committed to the
  	display. Reported for diagnostic uses, may be removed in the future.
  		 */
  		public static const beginFrame:String = "HeadlessExperimental.beginFrame";
  	
  		/**
  		 * disable
  		 * Disables headless events for the target.
  		 * @return 
  		 */
  		public static const disable:String = "HeadlessExperimental.disable";
  	
  		/**
  		 * enable
  		 * Enables headless events for the target.
  		 * @return 
  		 */
  		public static const enable:String = "HeadlessExperimental.enable";
	}

}