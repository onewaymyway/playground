package laya.effect {
	import laya.display.Node;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.utils.Handler;
	import laya.utils.TimeLine;
	import laya.utils.Tween;
	/**
	 *时间线管理类
	 */
	public class EffectUtils {
		
		/**是否在运动**/
		private static var _isMove:Boolean = false;
		/**时间线动画类**/
		private static var _timeLine:TimeLine = new TimeLine();
		
		/**
		 * 缩放效果
		 * @param target
		 */
		public static function scaleEffect(target:Sprite, complete:Handler = null, time:Number = 150):void {
			if (_isMove)
				return;
			_isMove = true;
			_timeLine.addLabel("first0.9", 0).to(target, {scaleX: 1.1, scaleY: 1.1}, time, null, 0).addLabel("three0.9", 0).to(target, {scaleX: 0.9, scaleY: 0.9}, time, null, 0).addLabel("four1", 0).to(target, {scaleX: 1, scaleY: 1}, time, null, 0);
			_timeLine.play(0, false);
			_timeLine.on(Event.COMPLETE, EffectUtils, onTimeLineComplete, [complete]);
		}
		
		/**缓动结束**/
		private static function onTimeLineComplete(complete:Handler = null, evt:Event = null):void {
			_isMove = false;
			_timeLine.reset();
			complete != null && complete.run();
		}
		
		/**
		 * 按钮运动效果
		 * @param target 作用对象
		 * @param targetObj 作用数据
		 * @param ease 缓动类型，默认为匀速运动
		 * @param time 缓动时间 默认300毫秒
		 * @param direction 缓动方向，默认为横向(x)运动
		 */
		public static function shrinkEffect(target:Node, targetObj:Object = null, time:Number = 300, ease:Function = null, direction:Boolean = true):void {
			var targetX:Number, targetY:Number;
			if (targetObj.hasOwnProperty("x"))
				targetX = targetObj.x;
			if (targetObj.hasOwnProperty("y"))
				targetY = targetObj.y;
			if (direction)
				Tween.to(target, {x: targetX}, time, ease);
			else
				Tween.to(target, {y: targetY}, time, ease);
		}
	}
}