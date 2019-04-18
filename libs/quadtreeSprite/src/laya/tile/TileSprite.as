package laya.tile {
	import laya.display.Graphics;
	import laya.display.Sprite;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	import laya.net.Loader;
	import laya.renders.Render;
	import laya.renders.RenderContext;
	import laya.renders.RenderSprite;
	import laya.resource.Texture;
	import laya.utils.Handler;
	
	/**
	 * ...
	 * @author ww
	 */
	public class TileSprite extends Sprite {
		private var _dirty:Boolean = true;
		private var _viewport:Rectangle;
		
		private var _xCount:int;
		private var _yCount:int;
		private var _wordWidth:int;
		private var _wordHeight:int;
		private var _gridWidth:int;
		private var _gridHeight:int;
		private var _drawCount:int;
		private var _preRec:Rectangle = new Rectangle();
		private var _preRange:Array = [];
		public var cacheGrid:int = 0;

		private var _wordSpace:Point;
		
		public var textureList:Array;
		public var layers:Array;
		
		public function TileSprite(worldSpace:Point = null) {
			if (!worldSpace)
				worldSpace = new Point();
			_wordSpace = worldSpace;
		
		}
		
		public function setSizeInfo(info:Object):void
		{
			_xCount = info.width;
			_yCount = info.height;
			
			_gridWidth = info.tilewidth;
			_gridHeight = info.tileheight;
			
			_wordWidth = _gridWidth * _xCount;
			_wordHeight = _gridHeight * _yCount;
		}
		
		public function setLayers(layers:Array):void
		{
			this.layers = layers;
		}
		
		private static var _range:Array = [];
		
		public function getWrapGrid(x:Number, y:Number, width:Number, height:Number):Array {
			var rst:Array;
			rst = _range;
			//rst.length = 4;
			var tP:Point;
			tP = getGridIJ(x, y);
			rst[0] = tP.x;
			rst[1] = tP.y;
			tP = getGridIJ(x + width, y + height);
			rst[2] = tP.x;
			rst[3] = tP.y;
			
			return rst;
		}
		private static const _gridIJ:Point = new Point();
		
		public function getGridIJ(x:Number, y:Number):Point {
			x -= _wordSpace.x;
			y -= _wordSpace.y;
			var i:int;
			i = Math.floor(x / _gridWidth);
			var j:int;
			j = Math.floor(y / _gridHeight);
			if (i < 0)
				i = 0;
			if (j < 0)
				j = 0;
			if (i >= _xCount)
				i = _xCount - 1;
			if (j >= _yCount)
				j = _yCount - 1;
			
			_gridIJ.setTo(i, j);
			return _gridIJ;
		}
		
		public function getIndexByIJ(i:int, j:int):int {
			if (i < 0)
				i = 0;
			if (j < 0)
				j = 0;
			//trace("pos:",i,j,i + j*_xCount);
			return i + j * _xCount;
		}
		
		public function getGridIndexByPos(x:Number, y:Number):int {
			var p:Point;
			p = getGridIJ(x, y);
			return getIndexByIJ(p.x, p.y);
		}
		
		public function get dirty():Boolean {
			return _dirty;
		}
		
		public function get visibleViewport():Rectangle {
			return _viewport;
		}
		
		public function set visibleViewport(viewport:Rectangle):void {
			if (viewport.equals(_viewport))
				return;
			
			_viewport = viewport.clone(_viewport);
			//scrollRect = _viewport;
			_dirty = true;
		}
		
		public function initByDataParser(tileParser:TileDataParser):void
		{
			this.setSizeInfo(tileParser.jsonData);
			this.textureList = tileParser.textureList;
			this.setLayers(tileParser.jsonData.layers);
			this.invalidate();
		}
		public function moveViewPort(dx:Number, dy:Number):void
		{
			_viewport.x = dx;
			_viewport.y= dy;
			_dirty = true;
			//repaint();
		}
		public function invalidate():void {
			_dirty = true;
		}
		
		public function refresh():void {
			_dirty = false;
			_updateVisibles();
		}
		private var _mBounds:Rectangle = new Rectangle();
		private function _updateVisibles():void {
			var range:Array;
			if (!_viewport)
				return;
			if (!layers) return;
			//trace(_preRec,_viewport,_preRec.contains(_viewport.x, _viewport.y),_preRec.contains(_viewport.right, _viewport.bottom));
			//当前视口在已渲染的区域中，不用重绘
			if (_preRec.contains(_viewport.x, _viewport.y) && _preRec.contains(_viewport.right, _viewport.bottom)) return;
			range = getWrapGrid(_viewport.x, _viewport.y, _viewport.width, _viewport.height);
			//之前的range包含了当前新的range，也不用重绘(切到边缘的时候，向边缘方向继续前进的时候会出现这种情况)
			if (_preRange[0] <= range[0] && _preRange[1] <= range[1] && _preRange[2] >= range[2] && _preRange[3] >= range[3] ) return;
			
			//记录之前的range
			_preRange[0] = range[0];
			_preRange[1] = range[1];
			_preRange[2] = range[2];
			_preRange[3] = range[3];
			
		
			
			//如果有cache格子,扩大渲染范围
			if (cacheGrid > 0)
			{
				range[0] -= cacheGrid;
				if (range[0] < 0) range[0] = 0;
				range[2] += cacheGrid;
				if (range[2] >= _xCount) range[2] = _xCount - 1;
				
				range[1] -= cacheGrid;
				if (range[1] < 0) range[1] = 0;
				range[3] += cacheGrid;
				if (range[3] >= _yCount) range[3] = _yCount - 1;
			}
			
			//记录当前渲染的区域
			_preRec.x = range[0] * _gridWidth;
			_preRec.y = range[1] * _gridHeight;
			_preRec.width = (range[2] - range[0]+1) * _gridWidth;
			_preRec.height = (range[3] - range[1]+1) * _gridHeight;
			//trace(range.join(","));
			setBounds(_preRec);
			var g:Graphics;
			g = this.graphics;
			g.clear();
			var index:int;
			
			_drawCount = 0;
			
			//渲染每一层
			var i:int, len:int;
			len = layers.length;
			var tTileData:Array;
			for (i = 0; i < len; i++)
			{
				tTileData = layers[i].data;
				if (!tTileData) continue;
				renderTileDataToGraphic(tTileData, range, g);	
			}
			
			trace("drawCount:", _drawCount);
		}
		
		private function renderTileDataToGraphic(tileData:Array, range:Array,g:Graphics):void
		{
			var i:int, iLen:int;
			var j:int, jLen:int;
			var tGrid:Texture;
			var tGridTextureID:int;
			var index:int;
			iLen = range[3] + 1;
			jLen = range[2] + 1;
			for (i = range[1]; i < iLen; i++) {
				for (j = range[0]; j < jLen; j++) {
					index = getIndexByIJ(j, i);
					tGridTextureID = tileData[index] - 1;
					tGrid = textureList[tGridTextureID];
					if (tGrid) {
						_drawCount++;
						g.drawTexture(tGrid, j * _gridWidth, i * _gridHeight);
					}
				}
			}
		}
		override public function render(context:RenderContext, x:Number, y:Number):void {
			if (_dirty) refresh()
			super.render(context, x, y);
		}
	}

}

