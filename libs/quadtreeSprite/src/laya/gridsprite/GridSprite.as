package laya.gridsprite 
{
	import laya.display.Node;
	import laya.display.Sprite;
	import laya.maths.MathUtil;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	import laya.renders.RenderContext;
	import laya.renders.RenderSprite;
	import laya.utils.Utils;
	/**
	 * ...
	 * @author ww
	 */
	public class GridSprite extends Sprite
	{
		private var _dirty:Boolean;
		private var _viewport:Rectangle;
		
		private var _xCount:int;
		private var _yCount:int;
		private var _wordWidth:int;
		private var _wordHeight:int;
		private var _gridWidth:int;
		private var _gridHeight:int;
		private var _gridList:Array;
		
		private var _wordSpace:Rectangle;
		public function GridSprite(worldSpace:Rectangle,xCount:int=40,yCount:int=40) 
		{
			_renderType |= RenderSprite.CHILDS;
			_wordSpace = worldSpace;
			_wordWidth = worldSpace.width;
			_wordHeight = worldSpace.height;
			_xCount = xCount;
			_yCount = yCount;
			_gridWidth = _wordWidth / xCount;
			_gridHeight = _wordHeight / yCount;
			
			var i:int, iLen:int;
			var j:int, jLen:int;
			var tGrid:Sprite;
			_gridList = [];
			iLen = yCount;
			jLen = xCount;
			for (i = 0; i < iLen; i++)
			{
				for (j = 0; j < jLen; j++)
				{
					tGrid = new Sprite();
					//super.addChild(tGrid);
					_gridList.push(tGrid);
				}
				
			}
		}
		
		public function getWrapGrid(x:Number, y:Number, width:Number, height:Number):Array
		{
			var rst:Array;
			rst = [];
			rst.length = 4;
			var tP:Point;
			tP = getGridIJ(x, y);
			rst[0] = tP.x;
			rst[1] = tP.y;
			tP = getGridIJ(x+width, y+height);
			rst[2] = tP.x;
			rst[3] = tP.y;
			
			return rst;
		}
		private static const _gridIJ:Point=new Point();
		public function getGridIJ(x:Number, y:Number):Point
		{
			x -= _wordSpace.x;
			y -= _wordSpace.y;
			var i:int;
			i = Math.floor(x / _gridWidth);
			var j:int;
			j = Math.floor(y / _gridHeight);
			if (i < 0) i = 0;
			if (j < 0) j = 0;
			
			_gridIJ.setTo(i, j);
			return _gridIJ;
		}
		public function getIndexByIJ(i:int, j:int):int
		{
			if (i < 0) i = 0;
			if (j < 0) j = 0;
			//trace("pos:",i,j,i + j*_xCount);
			return i + j*_xCount;
		}
		public function getGridIndexByPos(x:Number, y:Number):int
		{
			var p:Point;
			p = getGridIJ(x, y);
			return getIndexByIJ(p.x, p.y);
		}
		public function getGridByPos(x:Number, y:Number):Sprite
		{
			return _gridList[getGridIndexByPos(x,y)];
		}
		private function _addChildTo(child:Sprite):Sprite
		{
			var rec:Rectangle;
			rec = child.getBounds();
			var grid:Sprite;
			grid = getGridByPos(rec.x + rec.width, rec.y + rec.height);
			//grid = getGridByPos(rec.x , rec.y);
			if (grid)
			{
				grid.addChild(child);
			}else
			{
				trace("grid not find");
			}
			return grid;
		}
		override public function addChild(node:Node):Node 
		{
			updateChild(node as Sprite);
			return node;
		}

		public function updateChild(child:Sprite):Sprite
		{
			_dirty = true;
			return _addChildTo(child);
		}
		
		public function getGridByChild(child:Sprite):Sprite
		{
			if (child.parent && child.parent.parent == this) return child.parent as Sprite;
			return null;
		}
		public function get visibleViewport():Rectangle
		{
			return _viewport;
		}
		
		public function set visibleViewport(viewport:Rectangle):void
		{
			if (viewport.equals(_viewport))
				return;
			
			_viewport = viewport.clone(_viewport);
			//scrollRect = _viewport;
			_dirty = true;
		}

		
		override public function set scrollRect(value:Rectangle):void 
		{
			visibleViewport = value;
			super.scrollRect = value;
			_dirty = true;
		}
		public function get dirty():Boolean
		{
			return _dirty;
		}
		
		public function invalidate():void
		{
			_dirty = true;
		}
			
		private static var _temRec:Rectangle=new Rectangle();
		public function refresh():void
		{
			if (!_dirty)
				return;		
			_dirty = false;		
			_updateVisibles();
		}
		private function _updateVisibles():void
		{
			var i:int, iLen:int;
			var j:int, jLen:int;
			var tGrid:Sprite;
			var range:Array;
			range = getWrapGrid(_viewport.x, _viewport.y, _viewport.width, _viewport.height);
			iLen = range[3]+1;
			jLen = range[2]+1;
			
			var index:int;
			this._childs.length = 0;
			//removeChildren();
			for (i = range[1]; i < iLen; i++)
			{
				for (j = range[0]; j < jLen; j++)
				{
					index = getIndexByIJ(j, i);
					tGrid = _gridList[index];
					if (tGrid)
					{
						Utils.concatArray(_childs, tGrid._childs);
					}
					//this._childs.push(tGrid);
				}
			}
		}
		override public function render(context:RenderContext, x:Number, y:Number):void
		{
			refresh()
			super.render(context, x, y);
		}
	}

}