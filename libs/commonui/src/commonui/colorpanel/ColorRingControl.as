package commonui.colorpanel 
{
	import laya.display.Sprite;
	import laya.display.Text;
	import laya.events.Event;
	import laya.resource.Texture;
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Image;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	/**
	 * ...
	 * @author ww
	 */
	public class ColorRingControl 
	{
		public static var defaultColor:String = "#c8e216";
		private var colorRec:Sprite;
		public var colorRing:ColorRing;
		//public var samplingBtn:Box;
		public var bgColorBtn:Button;
		public function ColorRingControl() 
		{
			
		}
		
		public function initSize(width:int, height:int):void
		{
			colorRec = new Sprite();
			colorRing = new ColorRing();
			colorRing.initSize(width, width);
			colorRing.on(Event.CHANGE, this, onColorChange);
			colorRing.drawCircle();
			colorRing.findColorPos(defaultColor);
			
			//samplingBtn = new Box();
			//samplingBtn.size(100, 100);
			//var icon:Sprite;
			//icon = new Sprite();
			//icon.texture = "res/editor/straw.png" as Texture;
			//icon.pos(29, 11);
			//samplingBtn.addChild(icon);
			//var text:Text;
			//text = new Text();
			//text.color = "#666666";
			//text.fontSize = 22;
			//text.text = "吸色";
			//text.align = "center";
			//text.width = 80;
			//text.pos(10, 63);
			//samplingBtn.addChild(text);
			//colorRing.addChild(samplingBtn);
			//samplingBtn.pos(colorRing.ringSprite.x - samplingBtn.width * 0.5, 110);
			//samplingBtn.pos(colorRing.width - samplingBtn.width - 5, 0);
			//samplingBtn.on(Event.MOUSE_DOWN, this, stopEvent);

			bgColorBtn = new Button();
			bgColorBtn.stateNum = 1;
			bgColorBtn.skin = "res/start/sure.png";
			
			bgColorBtn.size(100, 60);
			bgColorBtn.pivotX = 0.5 * bgColorBtn.width;
			bgColorBtn.label = "底色";
			bgColorBtn.labelSize = 24;
			bgColorBtn.labelColors = "#ffffff,#ffffff,#ffffff,#ffffff";
			colorRing.addChild(bgColorBtn);
			bgColorBtn.pos(colorRing.ringSprite.x, 120);
			bgColorBtn.on(Event.MOUSE_DOWN, this, stopEvent,["bgColor"]);
			setBgColorMode(false);
		}
		
		
		public var isBgColorMode:Boolean = false;
		public function setBgColorMode(isBgColorMode:Boolean):void
		{
			this.isBgColorMode = isBgColorMode;
			if (isBgColorMode)
			{
				bgColorBtn.gray = false;
			}else
			{
				bgColorBtn.gray = true;
			}
		}
		private function stopEvent(type:String,e:Event):void
		{
			if (type == "bgColor")
			{
				setBgColorMode(!isBgColorMode);
				colorRing.event("change",-1);
			}
			e.stopPropagation();
		}
		private static const recWidth:int = 60;
		
		public var parentBox:Sprite;
		private function onColorChange():void {
			var color:String = colorRing.selectColor;
			if (!color) color = defaultColor;
		
			colorRec.graphics.clear();
			colorRec.graphics.drawRect(-recWidth, -recWidth, recWidth * 2, recWidth * 2, color, "#ffffff", 2);
			
		}
		
		public function switchColorPanel(show:Boolean):void {
			if (show) {
				var targetY:Number;
				targetY = parentBox.height - 0.4 * colorRing.height;
				colorRing.y = parentBox.height;
				colorRing.x = parentBox.width * 0.5 - 0.5 * colorRing.width;
				parentBox.addChildAt(colorRing, 0);
				Tween.clearTween(colorRing);
				
				Tween.to(colorRing, {y: targetY}, 200, Ease.circOut);
				Laya.timer.once(200, this, onColorPanelShowFinish);
				colorRec.x = parentBox.width * 0.5;
				colorRec.y = targetY - recWidth - 100;
				
				onColorChange();
			} else {
				Laya.timer.clear(this, onColorPanelShowFinish);
				Tween.clearTween(colorRec);
				Tween.to(colorRec, {scaleX: 0.01, scaleY: 0.01}, 200, Ease.circOut);
				targetY = parentBox.height;
				Tween.to(colorRing, {y: targetY}, 200, Ease.circOut, Handler.create(this, onColorPanelHideFinish));
			}
		}
		
		private function onColorPanelHideFinish():void {
			colorRing.removeSelf();
			colorRec.removeSelf();
		}
		
		private function onColorPanelShowFinish():void {
			if (!colorRing.parent) return;
			Tween.clearTween(colorRec);
			parentBox.addChild(colorRec);
			colorRec.scale(0.01, 0.01)
			Tween.to(colorRec, {scaleX: 1, scaleY: 1}, 200, Ease.circIn);
		}
	}

}