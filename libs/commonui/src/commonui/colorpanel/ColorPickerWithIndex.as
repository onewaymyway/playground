package commonui.colorpanel
{
	import laya.display.Graphics;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.ui.UIUtils;

	/**
	 * ...
	 * @author ww
	 */
	public class ColorPickerWithIndex extends Box
	{
		private var tipRec:Sprite;
		private var tipImg:Image;
		private var selectFocusSp:Sprite;
		public function ColorPickerWithIndex() 
		{
			this.hitTestPrior = false;
			addChild(_colorTiles = new Sprite());
			selectFocusSp = new Sprite();
			
			tipRec = new Sprite();
			tipImg = new Image();
			
			changePanel();
			_colorTiles.on(Event.MOUSE_DOWN, this, onMouseDown);
			_colorTiles.on(Event.MOUSE_MOVE, this, onMouseMove);
			_colorTiles.on(Event.MOUSE_UP, this,onMouseUp);
			_colorTiles.on(Event.MOUSE_OUT, this, onMouseOut);
		}
		/**
		 * @private
		 * 表示颜色网格。
		 */
		protected var _colorTiles:Sprite;
		/**
		 * @private
		 * 表示颜色值列表。
		 */
		protected var _colors:Array = [];
		/**
		 * @private
		 * 指定每个正方形的颜色小格子的宽高（以像素为单位）。
		 */
		protected var _gridSize:int = 40;
		protected var _imgs:Array = [];
		
		public var xCount:int = 18;
		
		
		private var _isSelectingColor:Boolean = false;
		private function onMouseDown(e:Event):void
		{
			e.stopPropagation();
			_isSelectingColor = true;
			checkSelectColor();
		}
		private function onMouseMove():void
		{
			if (_isSelectingColor)
			{
				checkSelectColor();
			}
		}
		private function onMouseUp():void
		{
			_isSelectingColor = false;
			hideSelectColorTip();
		}
		private function onMouseOut():void
		{
			_isSelectingColor = false;
			hideSelectColorTip();
		}
		
		protected var _tSelectColor:*;
		protected var _tColorIndex:int;
		protected function checkSelectColor():void
		{
			var color:String;
			
			color = getColorByMouse();
			_tColorIndex = getCurColorIndex();
			if (color != _tSelectColor)
			{
				event(Event.CHANGE, color);
			}
			_tSelectColor = color;
//			trace("SelectColor:", _tSelectColor);
			showSelectColorTip();
		}
		public var tipRecWidth:Number = 60;
		public var tipRecOffset:Number = 100;
		protected function showSelectColorTip():void
		{
			if (!_tSelectColor)
			{
				hideSelectColorTip();
				return;
			} 
			var tRecSp:Sprite;
			if (_tSelectColor is String)
			{
				tipRec.graphics.clear();
				tipRec.graphics.drawRect( -tipRecWidth, -tipRecWidth, tipRecWidth * 2, tipRecWidth * 2, _tSelectColor,"#ffffff", 4);
				tRecSp = tipRec;
				tipImg.removeSelf();
			}else
			{
				tipImg.skin = _tSelectColor.smallPic;
				tipImg.pivot(tipRecWidth-4, tipRecWidth-4);
				tipImg.size((tipRecWidth-4) * 2, (tipRecWidth-4) * 2);
				//tRecSp = tipImg;
				//tipRec.removeSelf();
				tipRec.graphics.clear();
				tipRec.addChild(tipImg);
				tipRec.graphics.drawRect( -tipRecWidth, -tipRecWidth, tipRecWidth * 2, tipRecWidth * 2, null,"#ffffff", 4);
				tRecSp = tipRec;
			}
			
			posRecSp(tRecSp);
			
			addChild(selectFocusSp);
			var curPos:Point;
			curPos = getColorStartPosByMouse();
			selectFocusSp.pos(curPos.x, curPos.y);
			
		}
		
		protected function posRecSp(tRecSp:Sprite):void
		{
			addChild(tRecSp);
			tRecSp.pos(this.width * 0.5, -tipRecWidth * 2 - tipRecOffset);
		}
		protected function hideSelectColorTip():void
		{
			tipRec.removeSelf();
			tipImg.removeSelf();
		}
		protected function createColorList():Array
		{
			var i:int, len:int;
			var rst:Array;
			rst = [];
			var grayList:Array;
			grayList = ColorTableTool.createGrayColor(18);
			for (i = 0; i < 12; i++) {
				for (var j:int = 0; j < 18; j++) {
					var color:uint;

					color = (((i * 3 + j / 6) % 3 << 0) + ((i / 6) << 0) * 3) * 0x33 << 16 | j % 6 * 0x33 << 8 | (i << 0) % 6 * 0x33;
					
					var strColor:String = UIUtils.toColor(color);
					rst.push(strColor);
				}
			}
			rst = rst.concat(grayList);
			return rst;
		}
		
		protected function getImageList():Array
		{
			var i:int, len:int;
			var rst:Array;
			rst = [];
			len = 9;
			var tImageO:Object;
			var img:Image;
			var child:Sprite;
			var index:int;
			for (i = 0; i < len; i++)
			{
				index = i + 1;
				tImageO = { };
				tImageO.name = "i:"+i;
				tImageO.smallPic = Server.url_file+"/scenes/sky/" + index + "/preview.jpg";
				tImageO.file = Server.url_file+"/scenes/sky/"+index+"/"+index+".lmat";
				img = new Image();
				img.skin = tImageO.smallPic;
				tImageO.img = img;
				child = new Sprite();
				img.addChild(child);
				tImageO.bg = child;
				rst.push(tImageO);
			}
			return rst;
		}
		
		public var preHasImage:Boolean;
		
		public function setHasImage(hasImage:Boolean):void
		{
			if (hasImage == preHasImage) return;
			changePanel(hasImage);
		}
		
		protected function createColorListForDraw(hasImage:Boolean=true):void
		{
			_colors = [];
			_colors = _colors.concat(createColorList());
			if(hasImage)
			_colors = _colors.concat(getImageList());
		}
		/**
		 * 改变颜色样本列表面板。
		 */
		public function changePanel(hasImage:Boolean=true):void {
			preHasImage = hasImage;

			
			createColorListForDraw(hasImage);
			var curPos:Point;
			curPos=renderColors();
			
			selectFocusSp.graphics.clear();
			selectFocusSp.graphics.drawRect(0, 0, _gridSize, _gridSize, null, "#ff0000",3);
			setUpSize(curPos);
		}
		
		protected function renderColors():Point
		{
			var g:Graphics;
			
			_colorTiles.removeChildren();
			g = _colorTiles.graphics;
			g.clear(true);
			
			var colorList:Array;
		
			var i:int, len:int;
			len = _colors.length;
			var curPos:Point;
			var tImageO:*;
			var tImg:Image;
			var tImgBg:Sprite;
			for (i = 0; i < len; i++)
			{
				curPos = getIJByIndex(i);
				tImageO = _colors[i];
				if (tImageO is String)
				{
					g.drawRect(curPos.x*_gridSize, curPos.y*_gridSize, _gridSize, _gridSize, tImageO, "#000000");
				}else
				{
					tImg = tImageO.img;
					tImgBg = tImageO.bg;
					tImg.size(_gridSize, _gridSize);
					tImg.pos(curPos.x * _gridSize, curPos.y * _gridSize);
					tImgBg.graphics.clear();
					tImgBg.graphics.drawRect(0, 0, _gridSize, _gridSize, null, "#000000", 1);
					_colorTiles.addChild(tImg);
				}
			}
			return curPos;
		}
		
		protected function setUpSize(curPos:Point):void
		{
			this.width = 720;
			this.height = curPos.y * _gridSize + _gridSize;
			_colorTiles.size(this.width, this.height);
		}
		
		/**
		 * 通过鼠标位置取对应的颜色块的颜色值。
		 */
		protected function getColorByMouse():String {
			var point:Point = getColorIJByMouse();
			return _colors[getIndexByIJ(point.x,point.y)];
		}
		
		protected function getCurColorIndex():int
		{
			var point:Point = getColorIJByMouse();
			return getIndexByIJ(point.x, point.y);
		}
		
		protected function getColorIJByMouse():Point
		{
			var point:Point = _colorTiles.getMousePoint();
			var x:int = Math.floor(point.x / _gridSize);
			var y:int = Math.floor(point.y / _gridSize);
			return _ijPoint.setTo(x, y);
		}
		
		protected function getColorStartPosByMouse():Point
		{
			var point:Point;
			point = getColorIJByMouse();
			point.x = point.x * _gridSize;
			point.y = point.y * _gridSize;
			return point;
		}
		
		private static var _ijPoint:Point = new Point();
		protected function getIJByIndex(index:int):Point
		{
			var i:int,j:int;
			i = index % xCount;
			j = Math.floor(index / xCount);
			_ijPoint.setTo(i, j);
			return _ijPoint;
		}
		
		protected function getIndexByIJ(i:int, j:int):int
		{
			return i + j * xCount;
		}
	}

}