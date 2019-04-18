package laya.effect
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.utils.Ease;
	import laya.utils.Tween;
	/**
	 * ...
	 * @author ww
	 */
	public class DragEffect 
	{
		private var _target:Sprite;
		public function DragEffect() 
		{
			
		}
		private var _pos:Point = new Point();
		public function recordPos():void
		{
			_pos.setTo(_target.x, _target.y);
		}
		public var scaleBig:Number = 1.5;
		public function set target(v:Sprite):void
		{
			_target = v;
			_target.on(Event.MOUSE_DOWN, this, onMouseDown);
			_target.on(Event.DRAG_END, this, onDragEnd);
			recordPos();
		}
		private function onMouseDown():void
		{
			if (!_target) return;
			Tween.clearAll(_target);
			Tween.to(_target, { scaleX:scaleBig, scaleY:scaleBig }, 100);
			_target.startDrag(null,false,50,500);
		}
		private function onDragEnd():void
		{
			Tween.clearAll(_target);
			Tween.to(_target, { scaleX:1, scaleY:1,x:_pos.x,y:_pos.y }, 1000,Ease.bounceOut);
		}
	}

}