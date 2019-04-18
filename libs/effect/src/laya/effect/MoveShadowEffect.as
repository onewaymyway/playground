package laya.effect 
{
	import laya.display.Node;
	import laya.display.Sprite;
	import laya.renders.RenderContext;
	import laya.resource.Texture;
	import laya.utils.Handler;
	import laya.utils.Tween;
	/**
	 * ...
	 * @author ww
	 */
	public class MoveShadowEffect extends Sprite
	{
		
		public function MoveShadowEffect() 
		{
			
		}
		public var tex:Texture;
		public var effectContainer:Sprite;
		public var times:Array = [100,200,300,400];
		public var posList:Array = [];
		private var tPropDic:Object = { };
		public function move(startX:Number, startY:Number, tarX:Number, tarY:Number,time:Number=400):void
		{
			effectContainer.addChild(this);
			Tween.clearAll(posList);
			var i:int, len:int;
			len = times.length;
			var tX:int, tY:int;
			var complete:Handler;
			var rate:Number;
			rate = time / times[times.length - 1];
			
			for (i = 0; i < len; i++)
			{
				tX = i*2;
				tY = tX + 1;
				posList[tX] = startX;
				posList[tY] = startY;
				if (i == len - 1)
				{
					complete = Handler.create(this, moveEnd);
				}
				var tPropO:Object;
				if (!tPropDic[i]) tPropDic[i] = { };
				tPropO = tPropDic[i];
				tPropO[tX] = tarX;
				tPropO[tY] = tarY;
				Tween.to(posList, tPropO, times[i]*rate,null,complete);
			}
		}
		
		private function moveEnd():void
		{
			this.removeSelf();
		}
		
		override public function render(context:RenderContext, x:Number, y:Number):void 
		{
			this.graphics.clear();
			var i:int, len:int;
			len = times.length;
			var tX:int, tY:int;
			for (i = 0; i < len; i++)
			{
				tX = i*2;
				tY = tX + 1;
				this.graphics.drawTexture(tex, posList[tX], posList[tY]);
			}
			super.render(context, x, y);
		}
		
	}

}