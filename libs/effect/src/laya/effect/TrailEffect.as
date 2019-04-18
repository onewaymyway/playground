package laya.effect 
{
	import laya.display.Sprite;
	import laya.renders.RenderContext;
	import laya.resource.Texture;
	/**
	 * ...
	 * @author ww
	 */
	public class TrailEffect extends Sprite
	{
		
		public function TrailEffect() 
		{
			
		}
		public var texture:Texture;
		public var posList:Array = [];
		public var loopTime:Number = 500;
		private var isLooping:Boolean = false;
		public function addTrail(x:Number, y:Number):void
		{
			posList.push(x, y);
			startLoop();
		}
		public function startLoop():void
		{
			if (isLooping) return;
			isLooping = true;
			Laya.timer.loop(loopTime, this, loop);
		}
		public function loop():void
		{
			if (posList.length > 0)
			{
				posList.splice(0, 2);
			}else
			{
				stopLoop();
			}
		}
		public function stopLoop():void
		{
			isLooping = false;
			Laya.timer.clear(this, loop);
		}
		override public function render(context:RenderContext, x:Number, y:Number):void 
		{
			if (!texture) return;
			this.graphics.clear();
			if (!posList || posList.length < 1) return;
			this.graphics.drawTextures(texture, posList);
			super.render(context, x, y);
		}
	}

}