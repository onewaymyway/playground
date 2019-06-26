package commontools 
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ui.Box;
	import laya.utils.Browser;
	/**
	 * ...
	 * @author ww
	 */
	public class AdptRoot 
	{
		private static var _I:AdptRoot;
		public static function get I():AdptRoot
		{
			if (!_I) _I = new AdptRoot();
			return _I;
		}
		public var container:Sprite;
		public function AdptRoot() 
		{
			
			if (Browser.pixelRatio > 1)
			{
				var box:Box;
				box = new Box();
				container = box;
				box.scale(scaleRate, scaleRate);
				Laya.stage.addChild(box);
				Laya.stage.on(Event.RESIZE, this, onStageResize, [box]);
				onStageResize(box);
			}else
			{
				container = Laya.stage;
			}
		}
		
		private function onStageResize(box:Box):void
		{
			box.width = Laya.stage.width /scaleRate;
			box.height = Laya.stage.height/scaleRate;
		}
		public static var scaleRate:Number = 2;
		
	}

}