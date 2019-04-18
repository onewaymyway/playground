package laya.effect 
{
	import laya.display.Graphics;
	import laya.display.Sprite;
	import laya.utils.Browser;
	
	/**
	 * ...
	 * @author ww
	 */
	public class AniTrailEffect extends Sprite 
	{
		
		public function AniTrailEffect() 
		{
			
		}
		public var textures:Array;
		public var posList:Array = [];
		public var disappearTime:Number = 2000;
		public function addTrail(x:Number, y:Number):void
		{
			posList.push(x, y,Browser.now());
		}
		
		override public function render(context:RenderContext, x:Number, y:Number):void 
		{
			if (!textures) return;
			var g:Graphics = this.graphics;
			g.clear();
			if (!posList || posList.length < 1) return;
			var i:int, len:int;
			len = posList.length;
			var tTime:Number = Browser.now();
			var tIndex:int;
			var maxIndex:int = textures.length;
			var timeRate:Number;
			timeRate = maxIndex / disappearTime;
			var removeI:int = 0;
			
			for (i = len-1-2; i >=0; i-=3)
			{
				tIndex = Math.floor((tTime-posList[i + 2]) * timeRate);
				if (tIndex >= maxIndex)
				{
					posList.splice(0, i+3);
					break;
				}else
				{
					g.drawTexture(textures[tIndex], posList[i], posList[i + 1]);
				}
			} 
			super.render(context, x, y);
		}
	}

}