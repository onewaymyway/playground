package commonui.colorpanel.colorselectorpanel 
{
	import commonui.colorpanel.ColorPickerWithIndex;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.net.Loader;
	import laya.net.LocalStorage;
	import wraps.colorselect.ColorSelector;
	
	/**
	 * ...
	 * @author ww
	 */
	public class SelectorColorPicker extends ColorPickerWithIndex 
	{
		private var colorSelector:ColorSelector;
		private var resetBtn:Sprite;
		public function SelectorColorPicker() 
		{
			super();
			
		}
		
		override public function changePanel(hasImage:Boolean = true):void 
		{
			xCount = 13;
			super.changePanel(hasImage);
			ColorSelector.overlayPic = "res/comp/colorpicker_overlay.png";
			ColorSelector.mainColorPic = "res/comp/maincolor.png";
			ColorSelector.sideColorPic = "res/comp/sidecolor.png";
			
			
			colorSelector = new ColorSelector();
			//colorSelector.x = _colorTiles.x + _colorTiles.width;
			colorSelector.x = this.width - colorSelector.width-2;
			colorSelector.on(ColorSelector.COLOR_CHANGED, this, onColorSelectorColorChanged);
			addChild(colorSelector);
			
			resetBtn = new Sprite();
			resetBtn.size(40, 40);
			resetBtn.graphics.drawImage(Loader.getRes("res/comp/icon_reset.png"), 2, 2, 36, 36);
			addChild(resetBtn);
			resetBtn.x = colorSelector.x;
			resetBtn.y = this.height - resetBtn.height - 4;
			resetBtn.on(Event.CLICK, this, onResetBtn);
		}
		
		private function onResetBtn():void
		{
			resetColorInfo();
		}
		
		private function onColorSelectorColorChanged():void
		{
			//trace("colorChange:", colorSelector.curColorStr);
			_colors[_tColorIndex] = colorSelector.curColorStr;
			renderColors();
			_tSelectColor = colorSelector.curColorStr;
			event(Event.CHANGE,  _tSelectColor);
			saveColorInfo();
		}
		
		override protected function checkSelectColor():void 
		{
			super.checkSelectColor();
			if (_tSelectColor)
			{
				colorSelector.setColorByRGBStr(_tSelectColor);
			}
		}
		private static var ColorStateSign:String = "CommonUI_ColorStateSign";
		public function recoverColorInfo():void
		{
			try
			{
				_colors = LocalStorage.getJSON(ColorStateSign) as Array;
			}catch (e:*)
			{
			}
			if (!_colors)
			{
				_colors = createColorListWork();
			}
			//resetHelpInfo();
		}
		
		public function saveColorInfo():void
		{
			LocalStorage.setJSON(ColorStateSign, _colors);
		}
		
		public function resetColorInfo():void
		{
			_colors = createColorListWork();
			saveColorInfo();
			renderColors();
			_tSelectColor = _colors[_tColorIndex];
			event(Event.CHANGE,  _tSelectColor);
		}
		
		override protected function createColorListForDraw(hasImage:Boolean=true):void 
		{
			recoverColorInfo();
		}
		
		public function createColorListWork():Array 
		{
			var depth:int;
			depth = 5;
			var colors:Array;
			colors = ColorTableTool.createColorTable(xCount, depth);
			var newColors:Array;
			newColors = [];
			newColors.length = colors.length;
			var i:int, len:int;
			len = newColors.length;
			var tColor:String;
			var curPos:Point;
			var x:int, y:int;
			for (i = 0; i < len; i++)
			{
				tColor = colors[i];
				x = Math.floor(i / depth);
				y = i % depth;
				newColors[x+y*xCount] =tColor ;
			}
			return newColors;
			
		}
		
		
		
		override protected function getImageList():Array 
		{
			return [];
		}
		
		override protected function setUpSize(curPos:Point):void 
		{
			this.width = 720;
			this.height = curPos.y * _gridSize + _gridSize;
			_colorTiles.size(_gridSize * xCount, this.height);
			this.graphics.clear();
			this.graphics.drawRect(-2, -2, this.width+4, this.height+4, "#283840", "#000000");
		}
		
	}

}