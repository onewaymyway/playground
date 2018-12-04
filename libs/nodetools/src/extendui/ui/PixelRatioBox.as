package extendui.ui 
{
	import laya.events.Event;
	import laya.ui.Box;
	import laya.utils.Browser;
	
	/**
	 * ww
	 * @author ...
	 */
	public class PixelRatioBox extends Box 
	{
		public var scaleRate:Number = 2;
		public function PixelRatioBox() 
		{
			if (Browser.pixelRatio > 1)
			{
				this.scale(scaleRate, scaleRate);
				Laya.stage.on(Event.RESIZE, this, onStageResize);
				onStageResize();

			}
			
		}
		private function onStageResize():void
		{
			this.width = Laya.stage.width /scaleRate;
			this.height = Laya.stage.height/scaleRate;
		}
	}

}