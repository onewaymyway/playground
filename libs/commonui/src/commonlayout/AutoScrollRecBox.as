package commonlayout 
{
	import laya.events.Event;
	import laya.maths.Rectangle;
	import laya.ui.Box;
	
	/**
	 * ...
	 * @author ww
	 */
	public class AutoScrollRecBox extends Box 
	{
		
		public function AutoScrollRecBox() 
		{
			this.on(Event.RESIZE, this, onMySizeChanged);
		}
		
		private function onMySizeChanged():void
		{
			this.scrollRect = new Rectangle(0, 0, this.width, this.height);
		}
	}

}