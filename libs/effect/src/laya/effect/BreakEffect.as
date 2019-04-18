package laya.effect 
{
	import laya.display.Sprite;
	import laya.display.Text;
	import laya.maths.Rectangle;
	import laya.resource.HTMLCanvas;
	import laya.resource.Texture;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	/**
	 * ...
	 * @author ww
	 */
	public class BreakEffect 
	{
		
		public function BreakEffect() 
		{
			
		}
		private var _tar:Sprite;
		
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
		
		private var textures:Array=[];
		private var sprites:Array = [];
		private var preTexture:Texture;
		public function clearPre():void
		{
			var i:int, len:int;
			len = sprites.length;
			var tSp:Sprite;
			for (i = 0; i < len; i++)
			{
				tSp = sprites[i];
				tSp.removeSelf();
				tSp.graphics.clear();
				Tween.clearAll(tSp);
			}
			textures.length = 0;
			if (preTexture)
			{
				preTexture.destroy(true);
				preTexture = null;
			}
		}
		public var xCount:int = 4;
		public var yCount:int = 7;
		public var xRandomLen:Number = 20;
		public var yRandomLen:Number = 100;
		public var yDropLen:Number = 100;
		public var yDropTime:Number = 1000;
		
		public function play():void
		{
			clearPre();
			if (!_tar) return;
			_tar.visible = true;
			var rec:Rectangle;
			rec = _tar.getSelfBounds();
			var htmlCanvas:HTMLCanvas;
			htmlCanvas = _tar.drawToCanvas(rec.width, rec.height, -rec.x, -rec.y);
			var texture:Texture;
			preTexture=texture = new Texture(htmlCanvas);;
			textures.length=0;
			var xD:Number;
			var yD:Number;
			xD = texture.width / xCount;
			yD = texture.height / yCount;
			var i:int, iLen:int;
			var j:int, jLen:int;
			var tTexture:Texture;
			sprites = sprites||[];
			var tSprite:Sprite;
			var stX:Number;
			var stY:Number;
			stX = rec.x + _tar.x;
			stY = rec.y + _tar.y;
			_tar.visible = false;
			var tI:int;
			tI = 0;
			for (i = 0; i < xCount; i++)
			{
				for (j = 0; j < yCount; j++)
				{
					tTexture = Texture.createFromTexture(texture, i * xD, j * yD, xD, yD);
					textures.push(tTexture);
					if(!sprites[tI]) sprites[tI]=new Sprite();
					tSprite = sprites[tI];
					tSprite.graphics.clear();
					tSprite.graphics.drawTexture(tTexture, 0, 0);
					//sprites.push(tSprite);
					tSprite.pos(i * xD+stX, j * yD+stY);
					_tar.parent.addChild(tSprite);
					tI++;
					Tween.to(tSprite, {x:tSprite.x+Math.random()*xRandomLen*(i-xCount*0.5+0.25) }, 100,Ease.cubicInOut);
					Tween.to(tSprite, {y:tSprite.y+Math.random()*yRandomLen+yDropLen }, yDropTime,Ease.elasticIn,Handler.create(this,removeSprites,[tSprite]),Math.random()*200);
				}		
			}
			Laya.timer.once(yDropTime + 100, this, clearPre);
			
		}
		private function removeSprites(sp:Sprite):void
		{
			sp.removeSelf();
		}
		
	}

}