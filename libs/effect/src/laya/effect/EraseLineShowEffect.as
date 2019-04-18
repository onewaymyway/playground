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
	public class EraseLineShowEffect 
	{
		
		public function EraseLineShowEffect() 
		{
			blendSp = new Sprite();
			blendSp.graphics.drawCircle(0, 0, 100, "#ff0000");
		}
		protected var _tar:Sprite;
		protected var blendSp:Sprite;
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
		
		protected var _rec:Rectangle;
		public function play():void
		{
			if (!_tar) return;
			
			var rec:Rectangle;
			_rec=rec = _tar.getSelfBounds();
			blendSp.pos(0, 0);
			_tar.mask = blendSp;
			blendSp.graphics.clear();
			Laya.timer.frameLoop(3, this, loop);
			Laya.timer.once(1000, this, tweenComplete);
		}
		protected function loop():void
		{
			blendSp.graphics.drawLine(_rec.x - 10, Math.random() * _rec.height + _rec.y, _rec.x + _rec.width + 10, Math.random() * _rec.height + _rec.y, "#ff0000", 2+Math.random()*5);
			blendSp.graphics.drawLine(_rec.x - 10, Math.random() * _rec.height + _rec.y, _rec.x + _rec.width + 10, Math.random() * _rec.height + _rec.y, "#ff0000", 2+Math.random()*5);
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