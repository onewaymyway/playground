package laya.effect {
	import laya.display.Sprite;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	/**
	 * ...
	 * @author ww
	 */
	public class Fris {
		
		public function Fris() {
			// 设置容器为画布缓存
			mainSP.cacheAs = "bitmap";
			
			
			//设置叠加模式
			showArea.blendMode = "destination-out";
			mainSP.addChild(showArea);
		}
		private var mainSP:Sprite = new Sprite();
		private var showArea:Sprite = new Sprite();
		
		private var tar:Sprite;
		
		public function set target(tar:Sprite):void
		{
			this.tar = tar;
		}
		public function play():void {
		
			if (!tar) return;
			var tP:Sprite;
			tP = tar.parent as Sprite;
			mainSP.graphics.clear();
			mainSP.graphics.drawRect(0, 0, tP.width, tP.height, "#000000");
			tP.addChild(mainSP);
			showArea.graphics.clear();
			showArea.graphics.drawCircle(0, 0, 100, "#ff0000");
			showArea.x = tar.x+tar.width*0.5;
			showArea.y = tar.y+tar.height*0.5;
			showArea.scale(0.01, 0.01);
			var tarScale:Number;
			tarScale = 1.1 * Math.max(tP.width, tP.height) / 100;
			Tween.clearAll(showArea);
			Tween.to(showArea, {scaleX:tarScale,scaleY:tarScale }, 1000, Ease.strongIn, Handler.create(this, tweenComplete));
		
		}
		private function tweenComplete():void
		{
			mainSP.removeSelf();
		}
	}

}