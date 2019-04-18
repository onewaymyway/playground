package laya.effect {
	import laya.display.Sprite;
	import laya.maths.Rectangle;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	/**
	 * ...
	 * @author ww
	 */
	public class GatherEffect {
		
		public function GatherEffect() {
			_piece = new DisplayPieces();
		}
		private var _tar:Sprite;
		
		/**
		 * 设置控制对象
		 * @param tar
		 */
		public function set target(tar:Sprite):void {
			_tar = tar;
		}
		
		public function get target():Sprite {
			return _tar;
		}
		
		private var _piece:DisplayPieces;
		
		public var randomR:Number = 300;
		public var minR:Number = 10;
		public var effectTime:Number = 1000;
		
		public function play():void {
			if (!_tar) return;
			_piece.target = _tar;
			_piece.makePieces();
			var sps:Array;
			sps = _piece.sprites;
			var i:int, len:int;
			len = sps.length;
			var tParent:Sprite;
			tParent = _tar.parent as Sprite;
			var tSp:Sprite;
			var cx:Number;
			var cy:Number;
			var rec:Rectangle;
			rec = _tar.getBounds();
			cx = rec.width * 0.5 + rec.x;
			cy = rec.height * 0.5 + rec.y;
			var dR:Number;
			dR = Math.PI * 2 / len;
			var r:Number = randomR;
			var tX:Number;
			var tY:Number;
			_tar.visible = false;
			for (i = 0; i < len; i++) {
				tSp = sps[i];
				tParent.addChild(tSp);
				r = minR + randomR * Math.random();
				tSp.rotation = 0;
				tX = cx + r * Math.cos(dR * i);
				tY = cy + r * Math.sin(dR * i);
				Tween.from(tSp, {x:tX,y:tY,rotation:720*Math.random()-360}, effectTime, Ease.cubicInOut);
			}
			Laya.timer.once(effectTime + 100, this, end);
		}
		
		private function end():void
		{
			_piece.clearPre();
			target.visible = true;
		}
	}

}