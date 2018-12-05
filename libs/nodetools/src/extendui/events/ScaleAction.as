package extendui.events 
{
	import electrontools.MessageManager;
	import laya.display.Sprite;
	import laya.events.Event;
	/**
	 * ...
	 * @author ww
	 */
	public class ScaleAction 
	{
		public static const ScaleActionEvent:String = "ScaleActionEvent";
		public function ScaleAction() 
		{
			
		}
		private var _target:Sprite;
		private var _isDown:Boolean = false;
		//上次记录的两个触模点之间距离
		private var lastDistance:Number = 0;
		public function set target(value:Sprite):void
		{
			_target = value;
			_target.on(Event.MOUSE_DOWN, this, onMouseDown);
		}
		
		private function onMouseDown(e:Event):void
		{
			//MessageManager.I.show("onMouseDown");
			var touches:Array = e.touches;
			MessageManager.I.show("onTouch"+touches);

			if(touches && touches.length == 2)
			{

				lastDistance = getDistance(touches);

				addMouseEvents();
			}
			
		}
		
		private function removeMouseEvents():void
		{
			Laya.stage.off(Event.MOUSE_MOVE, this, onMouseMove);
			Laya.stage.off(Event.MOUSE_UP, this, onMouseUp);
			Laya.stage.off(Event.MOUSE_OUT, this, onMouseUp);
		}
		
		private function addMouseEvents():void
		{
			removeMouseEvents();
			Laya.stage.on(Event.MOUSE_MOVE, this, onMouseMove);
			Laya.stage.on(Event.MOUSE_UP, this, onMouseUp);
			Laya.stage.on(Event.MOUSE_OUT, this, onMouseUp);
		}
		
		private function onMouseMove(e:Event=null):void
		{
			var distance:Number = getDistance(e.touches);

			//判断当前距离与上次距离变化，确定是放大还是缩小
			var factor:Number = 0.01;
			var dScale:Number;
			dScale= (distance - lastDistance) * factor;
			_target.event(ScaleActionEvent, dScale);
			MessageManager.I.show("Event:"+dScale);

			lastDistance = distance;
		}

		private function onMouseUp(e:Event=null):void
		{
			removeMouseEvents();
		}
		
		/**计算两个触摸点之间的距离*/
		private function getDistance(points:Array):Number
		{
			var distance:Number = 0;
            if (points && points.length == 2)
			{
				var dx:Number = points[0].stageX - points[1].stageX;
				var dy:Number = points[0].stageY - points[1].stageY;

				distance = Math.sqrt(dx * dx + dy * dy);
			}
			return distance;
		}
		
		public static const ScaleActionSign:String = "__ScaleAction";
		public static function setTargetScaleActionEnabled(target:Sprite):void
		{
			if (target[ScaleActionSign]) return;
			var lp:ScaleAction;
			lp = new ScaleAction();
			lp.target = target;
			target[ScaleActionSign] = lp;
		}
	}

}