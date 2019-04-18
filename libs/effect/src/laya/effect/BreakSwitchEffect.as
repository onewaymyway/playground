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
	public class BreakSwitchEffect 
	{
		
		public function BreakSwitchEffect() 
		{
			_piece = new DisplayPieces();
		}
		private var _piece:DisplayPieces;
		public var tar1:Sprite;
		public var tar2:Sprite;
		public var randomR:Number = 500;
		public var minR:Number = 10;
		public var effectTime:Number = 1000;
		public var xCount:int = 15;
		public var yCount:int = 15;
		public function play():void
		{
			_piece.xCount = xCount;
			_piece.yCount = yCount;
			_piece.target = tar1;
			tar2.visible = false;
			_piece.makePieces();
			var sps:Array;
			sps = _piece.sprites;
			var i:int, len:int;
			len = sps.length;
			var tParent:Sprite;
			tParent = tar1.parent as Sprite;
			var tSp:Sprite;
			var cx:Number;
			var cy:Number;
			var rec:Rectangle;
			rec = tar1.getBounds();
			cx = rec.width * 0.5 + rec.x;
			cy = rec.height * 0.5 + rec.y;
			var dR:Number;
			dR = Math.PI * 2 / len;
			var r:Number = randomR;
			var tX:Number;
			var tY:Number;
			tar1.visible = false;
			for (i = 0; i < len; i++) {
				tSp = sps[i];
				tParent.addChild(tSp);
				r = minR + randomR * Math.random();
				tSp.rotation = 0;
				tX = cx + r * Math.cos(dR * i);
				tY = cy + r * Math.sin(dR * i);
				Tween.to(tSp, {x:tX,y:tY,rotation:(720*Math.random()-360)*1}, effectTime, Ease.elasticIn);
			}
			//Laya.timer.once(effectTime*0.5, this, switchPic);
			Laya.timer.once(effectTime+10, this, disappearEnd);
		}
		private function switchPic():void
		{
			_piece.target = tar2;
			_piece.makePieces(false);
		}
		private function disappearEnd():void
		{
			//_piece.clearPre();
			startShowNew();
		}
		
		public function startShowNew():void
		{
			switchPic();
			tar1.visible = false;
			
			var sps:Array;
			sps = _piece.sprites;
			var i:int, len:int;
			len = sps.length;
			var tParent:Sprite;
			tParent = tar2.parent as Sprite;
			var tSp:Sprite;
			tar1.visible = false;
			var posList:Array;
			posList = _piece.posList;
			for (i = 0; i < len; i++) {
				tSp = sps[i];
				tParent.addChild(tSp);
				Tween.to(tSp, {x:posList[i*2],y:posList[i*2+1],rotation:0}, effectTime, Ease.elasticOut);
			}
			Laya.timer.once(effectTime + 100, this, showNewEnd);
		}
		public function showNewEnd():void
		{
			_piece.clearPre();
			tar2.visible = true;
		}
	}

}