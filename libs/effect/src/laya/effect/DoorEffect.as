package laya.effect {
	import laya.display.Sprite;
	import laya.maths.Point;
	import laya.ui.Component;
	import laya.ui.Dialog;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	/**
	 * 面板开合特效
	 */
	public class DoorEffect{
		
		/**
		 * 控制的对象
		 */
		private var _target:Sprite;
		/**
		 * 记录的原left面板坐标
		 */
		private var leftPoint:Point = new Point();
		/**
		 * 记录的原top面板坐标
		 */
		private var topPoint:Point = new Point();
		/**
		 * 记录的原bottom面板坐标
		 */
		private var bottomPoint:Point = new Point();
		/**
		 * left面板
		 */
		private var left:Component;
		/**
		 * top面板
		 */
		private var top:Component;
		/**
		 * bottom面板
		 */
		private var bottom:Component;
		/**
		 * 完成回调
		 */
		private var complete:Handler;
		/**
		 * 是否cache
		 */
		private var caches:Array = [false, false, false];
		/**
		 * 打开开始延迟
		 */
		public var delay:Number = 0;
		
		/**
		 * 设置控制对象
		 * @param tar
		 */
		public function set target(tar:Sprite):void {
			if (!this._target) {
				this._target = tar;
				left = _target.getChildByName("leftPanel") as Component;
				top = _target.getChildByName("topPanel") as Component;
				bottom = _target.getChildByName("bottomPanel") as Component;
				if (left)
					leftPoint.setTo(left.x, left.y);
				if (top)
					topPoint.setTo(top.x, top.y);
				if (bottom)
					bottomPoint.setTo(bottom.x, bottom.y);
				var dlg:Dialog = tar as Dialog;
				dlg.popupEffect = new Handler(this, popupEffect);
				dlg.closeEffect = new Handler(this, closeEffect);
			}
		}
		
		/**
		 * 实现DialogManager.popupEffect
		 */
		public function popupEffect():void
		{
			open(Handler.create(Dialog.manager, Dialog.manager.doOpen, [_target]));
		}
		
		/**
		 * 实现DialogManager.closeEffect
		 */
		public function closeEffect(dialog:Sprite, type:String):void
		{
			close(Handler.create(Dialog.manager, Dialog.manager.doClose, [_target, type]));
		}
		
		/**
		 * 打开
		 * @param complete
		 */
		public function open(complete:Handler = null):void {
			this.complete = complete;
			if (left) {
				left.x = -300;
				caches[0] = left.cacheAs;
				left.cacheAs = "normal";
			}
			if (top) {
				top.y = -200;
				caches[1] = top.cacheAs;
				top.cacheAs = "normal";
			}
			if (bottom) {
				bottom.y = Laya.stage.height + 100;
				caches[2] = bottom.cacheAs;
				bottom.cacheAs = "normal";
				bottom.staticCache = true;
			}
			if (delay)
				Laya.timer.once(delay, this, show);
			else
				show();
		}
		
		/**
		 * 打开特效
		 */
		private function show():void {
			_target && (_target.mouseEnabled = false);
			if (left)
				Tween.to(left, {x: leftPoint.x}, 500, Ease.backOut);
			if (top)
				Tween.to(top, {y: topPoint.y}, 500, Ease.backOut);
			if (bottom)
				Tween.to(bottom, {y: bottomPoint.y}, 500, Ease.backOut, Handler.create(this, onComplete));
		}
		
		/**
		 * 打开完成
		 */
		private function onComplete():void {
			if (left)
				left.cacheAs = caches[0];
			if (top)
				top.cacheAs = caches[1];
			if (bottom) {
				bottom.cacheAs = caches[2];
				bottom.staticCache = false;
			}
			_target && (_target.mouseEnabled = true);
			complete && complete.run();
		}
		
		/**
		 * 关闭
		 * @param handler
		 */
		public function close(handler:Handler):void {
			_target && (_target.mouseEnabled = false);
			if (left)
				Tween.to(left, {x: -300}, 400, Ease.backIn);
			if (top)
				Tween.to(top, {y: -200}, 400, Ease.backIn, Handler.create(this, function():void {
						handler && handler.run();
						_target && (_target.mouseEnabled = true);
					}));
			if (bottom)
				Tween.to(bottom, {y: Laya.stage.height}, 400, Ease.backIn);
		}
	}

}