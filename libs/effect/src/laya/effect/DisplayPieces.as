package laya.effect 
{
	import laya.display.Sprite;
	import laya.maths.Rectangle;
	import laya.resource.HTMLCanvas;
	import laya.resource.Texture;
	import laya.utils.Tween;
	/**
	 * ...
	 * @author ww
	 */
	public class DisplayPieces 
	{
		
		public function DisplayPieces() 
		{
			
		}
		public var xCount:int = 4;
		public var yCount:int = 7;
		public var target:Sprite;
		public var posList:Array = [];
		public function makePieces(setPos:Boolean=true):void
		{
			clearPre();
			var rec:Rectangle;
			var preVisible:Boolean;
			preVisible = target.visible;
			target.visible = true;
			rec = target.getSelfBounds();
			var htmlCanvas:HTMLCanvas;
			htmlCanvas = target.drawToCanvas(rec.width, rec.height, -rec.x, -rec.y);
			target.visible = preVisible;
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
			var tSprite:Sprite;
			var stX:Number;
			var stY:Number;
			stX = rec.x + target.x;
			stY = rec.y + target.y;
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
					if (setPos)
					{
						tSprite.pos(i * xD+stX, j * yD+stY);
					}
					posList[tI * 2] = i * xD + stX;
					posList[tI * 2+1] = j * yD+stY;
					tI++;
				}		
			}
		}
		public function movePieces(dX:Number, dY:Number):void
		{
			var i:int, len:int;
			len = sprites.length;
			var tSp:Sprite;
			for (i = 0; i < len; i++)
			{
				tSp = sprites[i];
				tSp.x += dX;
				tSp.y += dY;
			}
		}
		private var textures:Array=[];
		public var sprites:Array = [];
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
		
		public function destroy():void
		{
			clearPre();
			sprites.length = 0;
		}
	}

}