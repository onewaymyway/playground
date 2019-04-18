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
	public class SideShowEffect 
	{
		
		public function SideShowEffect() 
		{
			blendSp = new Sprite();
		}
		private var _tar:Sprite;
		private var blendSp:Sprite;
		public var type:String = "top";
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
			blendSp.pos(rec.x , rec.y);
			blendSp.graphics.drawRect(0, 0, rec.width, rec.height, "#ff0000");
			//blendSp.scaleY = 0.01;
			//blendSp.y -= rec.height;
			var tarKey:String;
			var tarValue:Number;

			switch(type)
			{
				case "top":
					blendSp.y -= rec.height;
					tarKey = "y";
					tarValue = rec.y;
					break;
				case "bottom":
					blendSp.y += rec.height;
					tarKey = "y";
					tarValue = rec.y;
					break;
			    case "left":
					blendSp.x -= rec.width;
					tarKey = "x";
					tarValue = rec.x;
					break;
				case "right":
					blendSp.x += rec.width;
					tarKey = "x";
					tarValue = rec.x;
					break;
			}
			_tar.mask = blendSp;
			Tween.clearAll(blendSp);
			Laya.timer.frameLoop(1, this, loop);
			var dataO:Object;
			dataO = { };
			dataO[tarKey] = tarValue;
			Tween.to(blendSp, dataO, 1000, Ease.cubicOut, Handler.create(this, tweenComplete));
		}
		private function loop():void
		{
			//blendSp.scaleY += 0.01;
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