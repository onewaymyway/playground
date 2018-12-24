package wraps.colorselect 
{
	import laya.display.Graphics;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.filters.ColorFilter;
	import laya.maths.Rectangle;
	import laya.net.Loader;
	import laya.resource.Texture;
	import laya.utils.Browser;
	
	import laya.debug.tools.ColorTool;
	
	/**
	 * 颜色选取类
	 * @author ww
	 */
	public class ColorSelector extends Sprite 
	{
		
		public function ColorSelector() 
		{
			container = this;
			this.mouseEnabled = true;
			
			createUI();
		}
		
		public static const COLOR_CHANGED:String = "ColorChanged";
		public static const COLOR_CHANGING:String = "COLOR_CHANGING";
		public static const COLOR_CLEARED:String="COLOR_CLEARED";
		
		private var sideColor:Sprite;
		private var mainColor:Sprite;
		private var demoColor:Sprite;
		private var posSp:Sprite;
		private var hPos:Sprite;
		
		
		
		private var container:Sprite;
		
		public static const RecWidth:int = 150;
		
		private var _gradientSp:Sprite;
		private var _darkSp:Sprite;
		private function createUI():void
		{	
			sideColor = new Sprite();
			container.addChild(sideColor);
			sideColor.graphics.drawRect(0, 0, RecWidth, RecWidth, "#ffffff");
			_gradientSp = new Sprite();
			var tex:Texture;
			tex = Loader.getRes(sideColorPic);
			_gradientSp.graphics.drawImage(tex, 0, 0, RecWidth, RecWidth);
			sideColor.addChild(_gradientSp);
			_darkSp = new Sprite();
			sideColor.addChild(_darkSp);
			tex = Loader.getRes(overlayPic);
			_darkSp.graphics.drawImage(tex, 0, 0, RecWidth, RecWidth);
			posSp = new Sprite();
			posSp.pos(100, 100);
			posSp.graphics.drawCircle(0, 0, 5, null, "#ff0000");
			posSp.graphics.drawCircle(0, 0, 6, null, "#ffff00");
//			posSp.size(10, 10);
			posSp.autoSize=true;
//			posSp.setBounds(new Rectangle(-7,-7,14,14));
			//posSp.cacheAsBitmap = true;
			sideColor.addChild(posSp);
			
			sideColor.pos(0, 0);
			sideColor.size(RecWidth, RecWidth);
			sideColor.on(Event.MOUSE_DOWN, this, sideColorClick);
//			sideColor.on(Event.MOUSE_UP, this, sideColorMouseUp);
			
			var i:int;
		    mainColor = new Sprite();
			var g:Graphics;
			g = mainColor.graphics;
		
			var h:Number;
			var s:Number;
			var b:Number;
			
			var rgb:Array;

			tex = Loader.getRes(mainColorPic);
			//g.loadImage(mainColorPic);
			mainColor.graphics.drawImage(tex, 0, 0, tex.width, RecWidth);

			mainColor.pos(RecWidth+4, 0);
			mainColor.size(tex.width, RecWidth);
			//mainColor.cacheAsBitmap = true;
			
			hPos = new Sprite();
			hPos.graphics.drawPie(0, 0, 20, -10, 10, "#ff0000");
			hPos.x = mainColor.x + mainColor.width-20;
			//hPos.visible = false;
			
			container.addChild(mainColor);
			container.addChild(hPos);
			mainColor.on(Event.MOUSE_DOWN, this, mainColorClick);
			
			demoColor = new Sprite();
			demoColor.pos(sideColor.x+44, sideColor.y + sideColor.height + 4);
			demoColor.size(RecWidth, 40);
			container.addChild(demoColor);
			
			this.width = mainColor.x + mainColor.width;
			

			//setColor(9, 95, 99);
			setColorByRGBStr("#099599");
			posSp.on(Event.DRAG_MOVE,this,posDraging);
//			posSp.on(Event.DRAG_END,this,posDragEnd);
//			posSp.on(Event.MOUSE_DOWN,this,posMouseDown);
		}
		private function posMouseDown(e:Event):void
		{
			
			
		}
		public var isChanging:Boolean=false;
		private function posDraging():void
		{
			updatePosSpAndShowColor();
			event(COLOR_CHANGING);
		}
		private function posDragEnd():void
		{
			isChanging=false;
			updatePosSpAndShowColor();
		}
		public function setColorByRGBStr(rgbStr:String):void
		{
			var rgb:Array;
			rgb = ColorTool.getRGBByRGBStr(rgbStr);
			setColor(rgb[0],rgb[1],rgb[2]);
		}
		public function setColor(red:Number, green:Number, blue:Number,notice:Boolean=true):void
		{
			var hsb:Array;
			hsb = ColorTool.rgb2hsb(red, green, blue);
			var tRGB:Array;
			tRGB = ColorTool.hsb2rgb( hsb[0], hsb[1], hsb[2]);
			setColorByHSB(hsb[0],hsb[1],hsb[2],notice);
		}
		public function setColorByHSB(h:Number, s:Number, b:Number,notice:Boolean=true):void
		{
			hPos.y = mainColor.y + h/360*RecWidth;
			
			posSp.x = s * RecWidth;
			posSp.y = (1 - b) * RecWidth;
			updateSideColor(h,notice);
		}
		private function sideColorClick(e:Event):void
		{
			
			isChanging=true;
			posSp.startDrag();
			updatePosSpAndShowColor();
			Laya.stage.off(Event.MOUSE_UP, this, sideColorMouseUp);
			Laya.stage.once(Event.MOUSE_UP, this, sideColorMouseUp);
		}
		private function sideColorMouseUp(e:Event):void
		{
			isChanging=false;
			updatePosSpAndShowColor();
		}
		private function updatePosSpAndShowColor():void
		{
			posSp.x = sideColor.mouseX;
			posSp.y = sideColor.mouseY;
			if(posSp.x<0) posSp.x=0;
			if(posSp.y<0) posSp.y=0;
			if(posSp.x>RecWidth) posSp.x=RecWidth;
			if(posSp.y>RecWidth) posSp.y=RecWidth;
			updateDemoColor();
		}
		public var tColor:Array;
		public var tH:Number;
		private function updateDemoColor(notice:Boolean=true):void
		{
			var h:Number;
			var s:Number;
			var b:Number;
			h = tH;
			s = posSp.x / RecWidth;
			b = 1 - posSp.y / RecWidth;
			tColor = ColorTool.hsb2rgb(h, s, b);
			var g:Graphics;
			g = demoColor.graphics;
			g.clear();
			g.drawRect(0, 0, demoColor.width, demoColor.height, ColorTool.getRGBStr(tColor));
			
			if(isChanging) return;
			if(notice)
			event(COLOR_CHANGED,this);
		}
		
		public function get curColorStr():String
		{
			return ColorTool.getRGBStr(tColor);
		}
		private function mainColorClick(e:Event):void
		{
			updateMainColorValue();
			addMainColorEvents();
		}
		
		private function removeMainColorEvents():void
		{
			Laya.stage.off(Event.MOUSE_MOVE, this, onMainColorMouseMove);
			Laya.stage.off(Event.MOUSE_OUT, this, onMainColorMouseOut);
			Laya.stage.off(Event.MOUSE_UP, this, onMainColorMouseOut);
		}
		
		private function addMainColorEvents():void
		{
			removeMainColorEvents();
			Laya.stage.on(Event.MOUSE_MOVE, this, onMainColorMouseMove);
			Laya.stage.on(Event.MOUSE_OUT, this, onMainColorMouseOut);
			Laya.stage.on(Event.MOUSE_UP, this, onMainColorMouseOut);
		}
		private function updateMainColorValue():void
		{
			var yPos:Number;
			yPos = mainColor.mouseY;
			if (yPos < 0) yPos = 0;
			if (yPos > RecWidth) yPos = RecWidth;
			hPos.y = yPos+mainColor.y;
			var h:Number;
			
			h = yPos / RecWidth * 360;
			updateSideColor(h);
		}
		
		private function onMainColorMouseMove():void
		{
			updateMainColorValue();
		}
		
		private function onMainColorMouseOut():void
		{
			removeMainColorEvents();
		}
		
		public static var overlayPic:String = "color/colorpicker_overlay.png";
		public static var mainColorPic:String = "color/maincolor.png";
		public static var sideColorPic:String = "color/sidecolor.png";
		
		private var _colorFilter:ColorFilter;
		
		private function createColorFilter(arr:Array, colorFilter:ColorFilter):ColorFilter {
			if (!colorFilter) colorFilter = new ColorFilter();
			var mt:Array = [0, 0, 0, 0, arr[0], 0, 0, 0, 0, arr[1], 0, 0, 0, 0, arr[2], 0, 0, 0, 1, 0];
			colorFilter.setByMatrix(mt);
			return colorFilter;
		}
		private function updateSideColor(h:Number,notice:Boolean=true):void
		{
			tH = h;
			var s:Number;
			var b:Number;
			var g:Graphics;
			g = sideColor.graphics;
			var rgb:Array;
			
			rgb = ColorTool.hsb2rgb(h, 1, 1);

			_colorFilter = createColorFilter(rgb, _colorFilter);
			_gradientSp.filters = [_colorFilter];
	
			updateDemoColor(notice);
		}
	}

}