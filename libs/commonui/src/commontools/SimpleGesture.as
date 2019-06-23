package commontools 
{

	import laya.display.Sprite;
	import laya.events.Event;
	import laya.events.EventDispatcher;
	import laya.maths.MathUtil;
	import laya.maths.Point;
	/**
	 * ...
	 * @author ww
	 */
	public class SimpleGesture extends EventDispatcher
	{
		public static const UP:String = "UP";
		public static const DOWN:String = "DOWN";
		public static const LEFT:String = "LEFT";
		public static const RIGHT:String = "RIGHT";
		public function SimpleGesture() 
		{
			
		}
		
		
		public var enable:Boolean = true;
		private var target:Sprite;
		public var lenLimit:Number = 100;
		public var canTragger:Boolean = false;
		public var sendChildFirst:Boolean = false;
		
		public function setTarget(target:Sprite):void
		{
			if (this.target)
			{
				removeEvents();
			}
			this.target = target;
			addEvents();
		}
		
		public function removeEvents():void
		{
			if(target)
			{
                target.off(Event.MOUSE_DOWN, this, onMouseDown);
                target.off(Event.MOUSE_UP, this, onMouseUp);
                target.off(Event.MOUSE_MOVE, this, onMouseMove);
			}

		}
		
		public function addEvents():void
		{
            if(target) {
                target.on(Event.MOUSE_DOWN, this, onMouseDown);
                target.on(Event.MOUSE_UP, this, onMouseUp);
                target.on(Event.MOUSE_MOVE, this, onMouseMove);
            }
		}
		
		private var prePoint:Point = new Point();
		
		private function onMouseDown():void
		{
			if (!enable) return;
			canTragger = true;
			prePoint.copy(target.getMousePoint());
			//trace("pos:",prePoint.x,prePoint.y);
		}
		
		private function onMouseMove(e:Event):void
		{
			if (!enable) return;
			checkEvents(e.target);
		}
		
		
		private static var _event:Event;
		public static function _initEvent(target, type:String):void
		{
			if (!_event)
			{
				_event = new Event();
			}
			_event.setTo(type, target, target);
			
		}
		
		private function emitEvent(type:String,target:*=null):void
		{
			//trace(type);
			if (sendChildFirst && target)
			{
				if (this.target && this.target.contains(target))
				{
					_initEvent(target, type);
					EventTools.sendStopAbleEventOnTree(type, _event, target, this.target);
					return;
				}
			}
			event(type);
		}
		
		private function checkEvents(target:*=null):void
		{
			if (!canTragger) return;
			var tPos:Point;
			tPos = this.target.getMousePoint();
			var tLen:Number;
			tLen = tPos.distance(prePoint.x, prePoint.y);
			if (tLen < lenLimit) return;
			
			var angle:Number;
			angle = MathUtil.getRotation(prePoint.x, prePoint.y, tPos.x, tPos.y);
			//trace("tpos:",tPos.x,tPos.y);
			//trace("angle:", angle);
			var dx:Number;
			var dy:Number;
			dx = tPos.x - prePoint.x;
			dy = tPos.y - prePoint.y;
			//trace("dx dy:",dx,dy);
			if (Math.abs(dx) > Math.abs(dy))
			{
				if (dx > 0)
				{
					
					emitEvent(RIGHT,target);
				}else
				{
					
					emitEvent(LEFT,target);
				}
			}else
			{
				if (dy < 0)
				{
					
					emitEvent(UP,target);
				}else
				{
					
					emitEvent(DOWN,target);
				}
			}
			canTragger = false;
		}
		private function onMouseUp():void
		{
			if (!enable) return;
			
			canTragger = false;
		}
		
	}

}