package laya.effect 
{
	import laya.display.Sprite;
	import laya.maths.Rectangle;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	/**
	 * ...
	 * @author ww
	 */
	public class EraseShowEffect 
	{
		
		public function EraseShowEffect() 
		{
			blendSp = new Sprite();
			blendSp.graphics.drawCircle(0, 0, 100, "#ff0000");
		}
		private var _tar:Sprite;
		private var blendSp:Sprite;
		/**
		 * 设置控制对象 
		 * @param tar
		 */		
		public function set target(tar:Sprite):void
		{
			_tar = tar;
		}
		
		public function get target():Sprite
		{
			return _tar;
		}
		
		public function play():void
		{
			if (!_tar) return;
			
			var rec:Rectangle;
			rec = _tar.getSelfBounds();
			blendSp.pos(rec.x+rec.width*0.5, rec.y+rec.height*0.5);
			blendSp.scale(0.01, 0.01);
			_tar.mask = blendSp;
			var tarScale:Number;
			tarScale = 1.1 * Math.max(rec.width, rec.height) / 100;
			Tween.clearAll(blendSp);
			Laya.timer.frameLoop(1, this, loop);
			Tween.to(blendSp, {scaleX:tarScale,scaleY:tarScale }, 1000, Ease.strongIn, Handler.create(this, tweenComplete));
		}
		private function loop():void
		{
			_tar.mask = null;
			_tar.mask = blendSp;
		}
		private function tweenComplete():void
		{
			Laya.timer.clear(this, loop);
			_tar.mask = null;
			blendSp.removeSelf();
		}
	}

}