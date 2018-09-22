package debugprotocol 
{



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
  		public static const disable:String = "Animation.disable";
  	
  		/**
  		 * enable
  		 * Enables animation domain notifications.
  		 * @return 
  		 */
  		public static const enable:String = "Animation.enable";
  	
  		/**
  		 * getCurrentTime
  		 * Returns the current time of the an animation.
  		 * @param id:string optional:{#@optional#} Id of animation.
  		 * @return currentTime:number optional:{#@optional#} Current time of the page.
  		 */
  		public static const getCurrentTime:String = "Animation.getCurrentTime";
  	
  		/**
  		 * getPlaybackRate
  		 * Gets the playback rate of the document timeline.
  		 * @return playbackRate:number optional:{#@optional#} Playback rate for animations on page.
  		 */
  		public static const getPlaybackRate:String = "Animation.getPlaybackRate";
  	
  		/**
  		 * releaseAnimations
  		 * Releases a set of animations to no longer be manipulated.
  		 * @param animations:array optional:{#@optional#} List of animation ids to seek.
  		 * @return 
  		 */
  		public static const releaseAnimations:String = "Animation.releaseAnimations";
  	
  		/**
  		 * resolveAnimation
  		 * Gets the remote object of the Animation.
  		 * @param animationId:string optional:{#@optional#} Animation id.
  		 * @return remoteObject:{#@type#} optional:{#@optional#} Corresponding remote object.
  		 */
  		public static const resolveAnimation:String = "Animation.resolveAnimation";
  	
  		/**
  		 * seekAnimations
  		 * Seek a set of animations to a particular time within each animation.
  		 * @param animations:array optional:{#@optional#} List of animation ids to seek.
  		 * @param currentTime:number optional:{#@optional#} Set the current time of each animation.
  		 * @return 
  		 */
  		public static const seekAnimations:String = "Animation.seekAnimations";
  	
  		/**
  		 * setPaused
  		 * Sets the paused state of a set of animations.
  		 * @param animations:array optional:{#@optional#} Animations to set the pause state of.
  		 * @param paused:boolean optional:{#@optional#} Paused state to set to.
  		 * @return 
  		 */
  		public static const setPaused:String = "Animation.setPaused";
  	
  		/**
  		 * setPlaybackRate
  		 * Sets the playback rate of the document timeline.
  		 * @param playbackRate:number optional:{#@optional#} Playback rate for animations on page
  		 * @return 
  		 */
  		public static const setPlaybackRate:String = "Animation.setPlaybackRate";
  	
  		/**
  		 * setTiming
  		 * Sets the timing of an animation node.
  		 * @param animationId:string optional:{#@optional#} Animation id.
  		 * @param duration:number optional:{#@optional#} Duration of the animation.
  		 * @param delay:number optional:{#@optional#} Delay of the animation.
  		 * @return 
  		 */
  		public static const setTiming:String = "Animation.setTiming";
	}

}