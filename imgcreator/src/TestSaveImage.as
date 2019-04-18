package  
{
	import laya.debug.tools.Base64Tool;
	import laya.debug.tools.ColorTool;
	import laya.display.Graphics;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.renders.Render;
	import laya.utils.Browser;
	import wraps.filesaver.FileSaver;
	/**
	 * ...
	 * @author ww
	 */
	public class TestSaveImage 
	{
		
		
	
		public function TestSaveImage() 
		{
			Laya.init(1000, 900);
			Laya.stage.bgColor = "#ff0000";
			test();
		}
		
		private var sp:Sprite;
		private var mainColor:Sprite;
		private var sideColor:Sprite;
		private var bgCircleColor:Sprite;
		public static const RecWidth:int = 150;
		public static var barWidth:int = 40;
		private function test():void
		{
			
			//sp = new Sprite();
			//sp.graphics.drawRect(0, 0, 100, 100, "#ff0000");
			//sp.size(100, 100);
			Laya.stage.on(Event.CLICK, this, onClick);
			
			createMainColor();
			createLineGradient();
			createRadGradient();
		}
		
		private function onClick():void
		{
			//saveSprite(sp);
			saveSprite(mainColor, "maincolor.png");
			saveSprite(sideColor, "sidecolor.png");
			saveSprite(bgCircleColor,"colorpicker_overlay.png");
		}
		private function createRadGradient():void
		{
			bgCircleColor = new Sprite();
			var tH:Number;
			var h:Number;
			h = 180;
			tH = h;
			var s:Number;
			var b:Number;
			var g:Graphics;
			g = bgCircleColor.graphics;
			g.clear();
			bgCircleColor.cacheAsBitmap = true;

			//var gradient:*= Render.context.ctx.createLinearGradient(0, 0, 80, 0);
			//var gradient:*= Render.context.ctx.createRadialGradient(0, 0, 0, 0, 0, RecWidth * 1.2);
			var gradient:*=Render.context.ctx.createLinearGradient(0,0,0,RecWidth);
			
			//gradient.addColorStop(1, ColorTool.getRGBStr(rgb));		
			gradient.addColorStop(1, "#000000");		
			gradient.addColorStop(0,"#ffffff");
			bgCircleColor.graphics.drawRect(0, 0, RecWidth, RecWidth, gradient);
			
			bgCircleColor.size(RecWidth, RecWidth);
			
			bgCircleColor.pos(200, 400);
			Laya.stage.addChild(bgCircleColor);
		}
		private function createLineGradient():void
		{
			sideColor = new Sprite();
			var tH:Number;
			var h:Number;
			h = 180;
			tH = h;
			var s:Number;
			var b:Number;
			var g:Graphics;
			g = sideColor.graphics;
			g.clear();
			sideColor.cacheAsBitmap = true;
			var rgb:Array;
			
			rgb=ColorTool.hsb2rgb(h, 1, 1);
			//var gradient:*= Render.context.ctx.createLinearGradient(0, 0, 80, 0);
			var gradient:*=Render.context.ctx.createLinearGradient(0,0,RecWidth,0);
			gradient.addColorStop(0,"rgba(255,255,255,0)");
			//gradient.addColorStop(1, ColorTool.getRGBStr(rgb));		
			gradient.addColorStop(1,"rgba(255,255,255,255)");		
			sideColor.graphics.drawRect(0, 0, RecWidth, RecWidth, gradient);
			
			sideColor.size(RecWidth, RecWidth);
			
			sideColor.pos(200, 200);
			Laya.stage.addChild(sideColor);
		}
		private function createMainColor():void
		{
			var i:int;
		    mainColor = new Sprite();
			var g:Graphics;
			g = mainColor.graphics;
		
			var h:Number;
			var s:Number;
			var b:Number;
			
			var rgb:Array;
			for (i = 0; i < RecWidth; i++)
			{
				rgb = ColorTool.hsb2rgb(i/RecWidth*360, 1, 1);
				g.drawLine(0, i, barWidth, i, ColorTool.getRGBStr(rgb));
			}

			mainColor.pos(RecWidth+10, 0);
			mainColor.size(barWidth, i);
			
			Laya.stage.addChild(mainColor);
		}
		
		private function saveSprite(view:Sprite,name:String):void
		{
			var pic:*;
			var bounds:Rectangle;
			bounds=view.getSelfBounds();
			pic = view.drawToCanvas(view.width, view.height,0 ,0 ).source;
//			trace("viewBounds:",bounds.toString());
//			trace("pic:", pic);
			var baseStr:String;
			baseStr=pic.toDataURL("image/png");
			trace("baseStr:",baseStr);
			baseStr = baseStr.replace(/^data:image\/\w+;base64,/, "");
			
			var ba:*;
			ba = Base64Tool.decode(baseStr);
			trace("ba:", ba);
			FileSaver.saveCanvas(name, pic);
		}
		
	}

}