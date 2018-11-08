package wheelpicker 
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Rectangle;
	import laya.ui.Box;
	import laya.ui.Label;
	import laya.ui.List;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	/**
	 * ...
	 * @author ww
	 */
	public class WheelPicker extends Box
	{
		
		public function WheelPicker() 
		{
			_content = new Box();
			_content.left = _content.right = 0;
			addChild(_content);
			this.on(Event.MOUSE_DOWN, this, onMouseDown);
			
		}
		
		public function get itemCount():int
		{
			return _array?_array.length:0;
		}
		private var _content:Box;
		private var _array:Array;
		private var _cells:Array = [];
		private var _curOffset:Number = 0;
		
		private var _startMouseY:Number;
		private var _startOffset:Number;
		private var _isDragging:Boolean = false;
		private var _preMouseY:Number;
		private var _lastOffset:Number=0;
		private function onMouseDown():void
		{
			_lastOffset = 0;
			_startMouseY = mouseY;
			_preMouseY = _startMouseY;
			_startOffset = _curOffset;
			startDragOp();
			_isDragging = true;
		}
		
		private function startDragOp():void
		{
			cancelDraging();
			//Laya.stage.on(Event.MOUSE_MOVE, this, onMouseMove);
			Laya.timer.frameLoop(3, this, onMouseMove);
			Laya.stage.on(Event.MOUSE_UP, this, onMouseUp);
			Laya.stage.on(Event.MOUSE_OUT, this, onMouseOut);
		}
		
		
		public var rectColor:String = null;
		
		public function initSize(width:int, height:int):void
		{
			if (!width) width = 150;
			if (!height) height = 100;
			this.size(width, height);
			this.graphics.clear();
			if (rectColor)
			{
				this.graphics.drawRect(0, 0, this.width, this.height, null, rectColor);
			}
			
			_myRec.setTo(0, 0, this.width, this.height);
		}
		private function onMouseMove():void
		{
			if (!_isDragging) return;
			var curMouse:Number;
			curMouse = mouseY;
			_lastOffset = curMouse-_preMouseY;
			if (curMouse == _preMouseY) return;
			
			_curOffset = _startOffset + curMouse-_startMouseY;
			_preMouseY = curMouse;
			freshItems();
			
			
			
		}
		private function onMouseUp():void
		{
			cancelDraging(true);
		}
		private function onMouseOut():void
		{
			cancelDraging(true);
		}
		private function cancelDraging(doTween:Boolean=false):void
		{
			//trace("cancelDraging");
			_isDragging = false;
			Laya.stage.off(Event.MOUSE_MOVE, this, onMouseMove);
			Laya.timer.clear(this, onMouseMove);
			Laya.stage.off(Event.MOUSE_UP, this, onMouseUp);
			Laya.stage.off(Event.MOUSE_OUT, this, onMouseOut);
			
			
			if (!doTween) return;
			var centerIndex:int;
			centerIndex = logicalCenterIndex;
			
			var offsetIndex:int;
			offsetIndex = Math.round(_lastOffset * 20 / cellSize);
			centerIndex -= offsetIndex;
			
			var bestCenter:Number;
			bestCenter = getCenterPosWhenFocusIndex(centerIndex);
			
			var offsetCenter:Number;
			offsetCenter = bestCenter - logicalCenter;
			//trace(centerIndex, offsetCenter);
			Tween.clearTween(this);
			Tween.to(this, { curOffset:curOffset - offsetCenter }, 500, Ease.circOut,Handler.create(this,onTweenEnd));
			
		}
		
		private function onTweenEnd():void
		{
			event(Event.CHANGE,logicalCenterIndex);
		}
		
		public function get selectIndex():int
		{
			return getCircleIndex(logicalCenterIndex);
		}
		
		public function set selectIndex(value:int):void
		{
			_curOffset = -(getCenterPosWhenFocusIndex(value) - this.height * 0.5);
			Tween.clearTween(this);
			freshItems();
			event(Event.CHANGE,logicalCenterIndex);
		}
		
		public function get selectData():Object
		{
			return _array[selectIndex];
		}
		
		private function set curOffset(value:Number):void
		{
			_curOffset = value;
			freshItems();
		}
		
		private function get curOffset():Number
		{
			return _curOffset;
		}
		public function setItems(items:Array):void
		{
			initSize(width, height);
			_array = items;
			_content.removeChildren();
			createItems();
			freshItems();
			selectIndex = 0;
		}
		
		private function getCircleIndex(index:int):int
		{
			index = index % _array.length;
			if (index < 0) index += _array.length;
			return index;
		}
		
		public var labelColor:String = "#ff0000";
		public var labelFontSize:int = 24;
		private function createOne():Box
		{
			//trace("createOne");
			var box:Box;
			box = new Box();
			box.size(200, labelFontSize+2);
			box.left = box.right = 0;
			var label:Label;
			label = new Label();
			label.name = "label";
			
			label.fontSize = labelFontSize;
			label.left = label.right = 0;
			label.color = labelColor;
			label.align = "center";
			label.text = "hihi";
			label.y = 1;
			box.addChild(label);
			box.pivotY = 0.5 * box.height;
			return box;
		}
		private var itemSize:int;
		private var cellSize:int;
		private var _indexToCellDic:Object = { };
		
		private var _upMask:Sprite;
		private var _downMask:Sprite;
		public var maskColor:String = "#000000";
		public var maskLineColor:String = "#333333";
		private function createMaskSprite(sp:Sprite,width:Number,height:Number,lineY:Number):Sprite
		{
			if (!sp) sp = new Sprite();
			sp.graphics.clear();
			sp.graphics.drawRect(0, 0, width, height, maskColor);
			if(maskLineColor)
			sp.graphics.drawLine(0, lineY, width, lineY, maskLineColor);
			sp.alpha = 0.5;
			sp.size(width, height);
			return sp;
		}
		
		
		public var itemSpace:int = 3;
		
		public function getShowRecTop():Number
		{
			return _upMask.y + _upMask.height;
		}
		
		public function getShowRecBottom():Number
		{
			return _downMask.y;
		}
		private function createItems():void
		{
			var i:int, len:int;
			len = _array.length;
			_cells.length = 0;
			var tItem:Sprite;
			tItem = createOne();
			itemSize = tItem.height;
			cellSize = itemSize + itemSpace*2;
			_indexToCellDic = { };
			_cellPool.length = 0;
			var maskHeight:int;
			var dMask:Number;
			dMask = 6;
			maskHeight = (this.height - cellSize-dMask*2)*0.5;
			_upMask = createMaskSprite(_upMask, this.width, maskHeight,maskHeight);
			
			_upMask.y = 0;
			addChild(_upMask);
			_downMask = createMaskSprite(_downMask, this.width, maskHeight,0);
			_downMask.y = this.height - maskHeight;
			addChild(_downMask);
			freshItems();
		}
		
		private var startIndex:int;
		private var endIndex:int;
		private var _cellPool:Array = [];
		
		private function get logicalStart():Number
		{
			return -_curOffset;
		}
		
		private function get logicalEnd():Number
		{
			return logicalStart + this.height;
		}
		
		private function get logicalCenter():Number
		{
			return logicalStart + this.height * 0.5;
		}
		
		private function get logicalCenterIndex():int
		{
			var index:int;
			index = Math.floor((logicalCenter) / cellSize);
			return index;
		}
		
		
		private function getCenterPosWhenFocusIndex(index:int):Number
		{
			//
			//logicalCenter=index*cellSize+itemSize*0.5
			return index * cellSize;
		}
		
		private function getCurRenderItems():void
		{

			var min:Number;
			var max:Number;
			min = -_curOffset;
			max = min + this.height;
			
			var startIndex:int;
			startIndex = Math.floor(min / cellSize);
			var endIndex:int;
			endIndex = Math.ceil(max / cellSize);
			//trace("render:", startIndex, endIndex);
			
			var tIndex:int;
			var key:String;
			var tItem:Sprite;
			for (key in _indexToCellDic)
			{
				tIndex = parseInt(key);
				if (tIndex<startIndex||tIndex>endIndex)
				{
					tItem = _indexToCellDic[tIndex];
					delete _indexToCellDic[tIndex];
					tItem.removeSelf();
					_cellPool.push(tItem);
				}
			}
			this.startIndex = startIndex;
			this.endIndex = endIndex;
		}
		
		private function getCellByIndex(index:int):*
		{
			if (!_indexToCellDic[index])
			{
				var item:*;
				item = _cellPool.length?_cellPool.pop():createOne();
				itemRender(item, getCircleIndex(index));
				_indexToCellDic[index] = item;
			}
			return _indexToCellDic[index];
		}
		
		
		private function freshItems():void
		{
			getCurRenderItems();
			var i:int, len:int;
			len = _cells.length;
			
			for (i = startIndex; i <= endIndex; i++)
			{
				renderOneItem(getCellByIndex(i), i);
			}

		}
		
		private var _labelRec:Rectangle = new Rectangle();
		private var _myRec:Rectangle = new Rectangle();
		
		private function renderOneItem(item:Sprite, index:int):void
		{
			var logicY:Number;
			logicY = index * cellSize;
			logicY += _curOffset;
			item.y = logicY;
			_labelRec.setTo(item.x, item.y, item.width, item.height);
			if (!item.parent)
			{
				_content.addChild(item);
			}
			if (_myRec.intersects(_labelRec))
			{
				item.visible = true;
				item.y = getMapedPos(logicY);
				mapItemInPos(item, logicY);
			}else
			{
				item.visible = false;
			}
		}
		
		private function mapItemInPos(item:Sprite, logicY:Number):void
		{
			var top:Number;
			top = clipValue(logicY-0.5*itemSize, 0, this.height);
			var bottom:Number;
			bottom = clipValue(logicY + 0.5*itemSize, 0, this.height);
			if (top == bottom)
			{
				item.visible = false;
				return;
			}
			item.y = getMapedPos(logicY);
			var height:Number;
			height = getMapedPos(bottom) - getMapedPos(top);
			item.scaleY = (height*2 / itemSize)/Math.PI;
			//trace("scaleY:",item.scaleY);
		
		}
		private function isInRange(value:Number, min:Number, max:Number):Boolean
		{
			return value >= min && value <= max;
		}
		
		
		private function clipValue(value:Number, min:Number, max:Number):Number
		{
			if (value < min) value = min;
			if (value > max) value = max;
			return value;
		}
		
		public function get circleRadius():Number
		{
			return this.height * 0.5;
		}
		public function get circleCenterY():Number
		{
			return this.height * 0.5;
		}
		private function getMapedPos(logicY:Number):Number
		{
			var centerY:Number;
			centerY =circleCenterY;
			var r:Number;
			r = circleRadius;
			var d:Number;
			d = r*2;
			if (!isInRange(logicY, 0, this.height)) return -1;
			
			var dLen:Number;
			dLen = logicY;
			var angle:Number;
			angle = dLen*Math.PI / this.height;
			var mapY:Number;
			mapY = centerY - r * Math.cos(angle);
			return mapY;
			
			
		}

		private function itemRender(cell:Box, index:int):void
		{
			var dataO:Object;
			dataO = _array[index];
			var label:Label;
			label = cell.getChildByName("label") as Label;
			if (label)
			{
				label.text = dataO.label;
			}
		}
		
	}

}