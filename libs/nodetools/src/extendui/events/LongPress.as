package extendui.events 
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.utils.Browser;
	/**
	 * ...
	 * @author ww
	 */
	public class LongPress 
	{
		public static const LongPressEvent:String = "LongPressEvent";
		public function LongPress() 
		{
			
		}
		private var _preTime:Number;
		public var timeLimit:Number = 600;
		private var _target:Sprite;
		private var _isDown:Boolean = false;
		public function set target(value:Sprite):void
		{
			_target = value;
			_target.on(Event.MOUSE_DOWN, this, onMouseDown);
			_target.on(Event.MOUSE_UP, this, onMouseUp);
			_target.on(Event.MOUSE_OUT, this, onMouseOut);
		}
		
		private function onMouseDown():void
		{
			_preTime = Browser.now();
			_isDown = true;
		}
		
		private function onMouseOut():void
		{
			_isDown = false;
		}
		
		private function onMouseUp():void
		{
			if (!_isDown) return;
			if (Browser.now() - _preTime>timeLimit)
			{
				_target.event(LongPressEvent);
			}
			_isDown = false;
		}
		
		public static const LongPressSign:String = "__longPress";
		public static function setTargetLongPressEnabled(target:Sprite):void
		{
			if (target[LongPressSign]) return;
			var lp:LongPress;
			lp = new LongPress();
			lp.target = target;
			target[LongPressSign] = lp;
		}
	}

}