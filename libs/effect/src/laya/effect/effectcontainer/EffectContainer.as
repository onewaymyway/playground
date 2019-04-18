package laya.effect.effectcontainer 
{
	import laya.display.Graphics;
	import laya.display.Sprite;
	import laya.renders.RenderContext;
	
	/**
	 * ...
	 * @author ww
	 */
	public class EffectContainer extends Sprite 
	{
		public var drawList:Array=[];
		public function EffectContainer() 
		{
			
		}
		public function addDraw(draw:DrawBase):void
		{
			drawList.push(draw);
		}
		public function removeDraw(draw:DrawBase):void
		{
			var i:int, len:int;
			len = drawList.length;
			for (i = 0; i < len; i++)
			{
				if (drawList == draw)
				{
					drawList.splice(i, 1);
					return;
				}
			}
		}
		override public function render(context:RenderContext, x:Number, y:Number):void 
		{
			if (!drawList) return;
			var i:int, len:int;
			len = drawList.length;
			var tDraw:DrawBase;
			var g:Graphics;
			g = this.graphics;
			g.clear();
			var time:Number;
			time = 1 / 60;
			for (i = len - 1; i >= 0; i--)
			{
				tDraw = drawList[i];
				tDraw.update(time);
				if (tDraw.dead)
				{
					drawList.splice(i, 1);
				}
			}
			len = drawList.length;
			for (i = 0; i < len; i++)
			{
				tDraw = drawList[i];		
				tDraw.drawToGraphic(g);
			}
			super.render(context, x, y);
		}
	}

}