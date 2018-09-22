package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Animation 
	{
		
		public function Animation() 
		{
			
		}
		public static const DependDomains:Array=[Runtime,DOM];
  	
  		/**
  		 * animationCanceled
  		 * Event for when an animation has been cancelled.
  		 * @param id:string optional:{#@optional#} Id of the animation that was cancelled.
  		 * @return 
  		 */
  		public static const animationCanceled:String = "Animation.animationCanceled";
  	
  		/**
  		 * animationCreated
  		 * Event for each animation that has been created.
  		 * @param id:string optional:{#@optional#} Id of the animation that was created.
  		 * @return 
  		 */
  		public static const animationCreated:String = "Animation.animationCreated";
  	
  		/**
  		 * animationStarted
  		 * Event for animation that has been started.
  		 * @param animation:{#@type#} optional:{#@optional#} Animation that was started.
  		 * @return 
  		 */
  		public static const animationStarted:String = "Animation.animationStarted";
  		/**
  		 * disable
  		 * Disables animation domain notifications.
  		 * @return 
  		 */	
  		public static function disable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Animation.disable", paramO);
  		}
  		
  		/**
  		 * enable
  		 * Enables animation domain notifications.
  		 * @return 
  		 */	
  		public static function enable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Animation.enable", paramO);
  		}
  		
  		/**
  		 * getCurrentTime
  		 * Returns the current time of the an animation.
  		 * @param id:string optional:{#@optional#} Id of animation.
  		 * @return currentTime:number optional:{#@optional#} Current time of the page.
  		 */	
  		public static function getCurrentTime(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Animation.getCurrentTime", paramO);
  		}
  		
  		/**
  		 * getPlaybackRate
  		 * Gets the playback rate of the document timeline.
  		 * @return playbackRate:number optional:{#@optional#} Playback rate for animations on page.
  		 */	
  		public static function getPlaybackRate(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Animation.getPlaybackRate", paramO);
  		}
  		
  		/**
  		 * releaseAnimations
  		 * Releases a set of animations to no longer be manipulated.
  		 * @param animations:array optional:{#@optional#} List of animation ids to seek.
  		 * @return 
  		 */	
  		public static function releaseAnimations(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Animation.releaseAnimations", paramO);
  		}
  		
  		/**
  		 * resolveAnimation
  		 * Gets the remote object of the Animation.
  		 * @param animationId:string optional:{#@optional#} Animation id.
  		 * @return remoteObject:{#@type#} optional:{#@optional#} Corresponding remote object.
  		 */	
  		public static function resolveAnimation(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Animation.resolveAnimation", paramO);
  		}
  		
  		/**
  		 * seekAnimations
  		 * Seek a set of animations to a particular time within each animation.
  		 * @param animations:array optional:{#@optional#} List of animation ids to seek.
  		 * @param currentTime:number optional:{#@optional#} Set the current time of each animation.
  		 * @return 
  		 */	
  		public static function seekAnimations(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Animation.seekAnimations", paramO);
  		}
  		
  		/**
  		 * setPaused
  		 * Sets the paused state of a set of animations.
  		 * @param animations:array optional:{#@optional#} Animations to set the pause state of.
  		 * @param paused:boolean optional:{#@optional#} Paused state to set to.
  		 * @return 
  		 */	
  		public static function setPaused(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Animation.setPaused", paramO);
  		}
  		
  		/**
  		 * setPlaybackRate
  		 * Sets the playback rate of the document timeline.
  		 * @param playbackRate:number optional:{#@optional#} Playback rate for animations on page
  		 * @return 
  		 */	
  		public static function setPlaybackRate(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Animation.setPlaybackRate", paramO);
  		}
  		
  		/**
  		 * setTiming
  		 * Sets the timing of an animation node.
  		 * @param animationId:string optional:{#@optional#} Animation id.
  		 * @param duration:number optional:{#@optional#} Duration of the animation.
  		 * @param delay:number optional:{#@optional#} Delay of the animation.
  		 * @return 
  		 */	
  		public static function setTiming(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Animation.setTiming", paramO);
  		}
  		
	}

}