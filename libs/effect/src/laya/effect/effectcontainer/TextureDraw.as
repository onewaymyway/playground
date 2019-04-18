package laya.effect.effectcontainer 
{
	import laya.display.Graphics;
	import laya.maths.Matrix;
	import laya.resource.Texture;
	/**
	 * ...
	 * @author ww
	 */
	public class TextureDraw extends DrawBase
	{
		public var texture:Texture;
		public var x:Number=0;
		public var y:Number=0;
		public var alpha:Number=1;
		public var rotation:Number=0;
		public var scale:Number = 1;
		public var px:Number = 0;
		public var py:Number = 0;
		public var enableMt:Boolean = false;
		private var _mt:Matrix=new Matrix();
		
		public function TextureDraw() 
		{
			
		}
		override public function drawToGraphic(g:Graphics):void 
		{
			if (!texture) return;
			if (alpha <= 0.01) return;
			if (!enableMt)
			{
				g.drawTexture(texture, x-px, y-px, 0, 0, null, alpha);
				return;
			}
			_mt.identity();
			_mt.scale(scale, scale);
			_mt.rotate(Math.PI*rotation/180);
			_mt.setTranslate(x, y);
			g.drawTexture(texture, -px, -py, 0, 0, _mt, alpha);
		}
	}

}