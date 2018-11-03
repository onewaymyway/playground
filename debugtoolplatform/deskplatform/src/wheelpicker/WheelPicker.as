package wheelpicker 
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Rectangle;
	import laya.ui.Box;
	import laya.ui.Label;
	import laya.ui.List;
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
		private var _content:Box;
		private var _array:Array;
		private var _cells:Array = [];
		private var _curOffset:Number = 0;
		
		private var _startMouseY:Number;
		private var _startOffset:Number;
		private var _isDragging:Boolean = false;
		private var _preMouseY:Number;
		private function onMouseDown():void
		{
			
			_startMouseY = mouseY;
			_preMouseY = _startMouseY;
			_startOffset = _curOffset;
			startDragOp();
			_isDragging = true;
		}
		
		private function startDragOp():void
		{
			cancelDraging();
			Laya.stage.on(Event.MOUSE_MOVE, this, onMouseMove);
			Laya.stage.on(Event.MOUSE_UP, this, onMouseUp);
			Laya.stage.on(Event.MOUSE_OUT, this, onMouseOut);
		}
		public function initSize(width:int, height:int):void
		{
			this.size(width, height);
			this.graphics.clear();
			this.graphics.drawRect(0, 0, this.width, this.height, null, "#00ff00");
			_myRec.setTo(0, 0, this.width, this.height);
		}
		private function onMouseMove():void
		{
			if (!_isDragging) return;
			var curMouse:Number;
			curMouse = mouseY;
			if (curMouse == _preMouseY) return;
			_curOffset = _startOffset + curMouse-_startMouseY;
			_preMouseY = curMouse;
			freshItems();
		}
		private function onMouseUp():void
		{
			cancelDraging();
		}
		private function onMouseOut():void
		{
			cancelDraging();
		}
		private function cancelDraging():void
		{
			_isDragging = false;
			Laya.stage.off(Event.MOUSE_MOVE, this, onMouseMove);
			Laya.stage.off(Event.MOUSE_UP, this, onMouseUp);
			Laya.stage.off(Event.MOUSE_OUT, this, onMouseOut);
		}
		public function setItems(items:Array):void
		{
			_array = items;
			_content.removeChildren();
			createItems();
			freshItems();
		}
		
		private function getCircleIndex(index:int):int
		{
			index = index % _array.length;
			if (index < 0) index += _array.length;
			return index;
		}
		
		private function createOne():Box
		{
			var box:Box;
			box = new Box();
			box.size(200, 30);
			box.left = box.right = 0;
			var label:Label;
			label = new Label();
			label.name = "label";
			
			label.fontSize = 24;
			label.left = label.right = 0;
			label.color = "#ff0000";
			label.align = "center";
			label.text = "hihi";
			box.addChild(label);
			return box;
		}
		private var itemSize:int;
		private var cellSize:int;
		private function createItems():void
		{
			var i:int, len:int;
			len = _array.length;
			_cells.length = 0;
			var tItem:Sprite;
			for (i = 0; i < len; i++)
			{
				tItem = createOne();
				_cells.push(tItem);
				tItem.visible = false;
				_content.addChild(tItem);
				itemRender(tItem, i);
			}
			itemSize = tItem.height;
			cellSize = itemSize + 5;
			freshItems();
		}
		
		private var startIndex:int;
		private var endIndex:int;
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
			trace("render:", startIndex, endIndex);
			this.startIndex = startIndex;
			this.endIndex = endIndex;
		}
		private function freshItems():void
		{
			getCurRenderItems();
			var i:int, len:int;
			len = _cells.length;
			
			for (i = startIndex; i <= endIndex; i++)
			{
				renderOneItem(_cells[getCircleIndex(i)], i);
			}
			//for (i = 0; i < len; i++)
			//{
				//renderOneItem(_cells[i], i);
			//}
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
			top = clipValue(logicY, 0, this.height);
			var bottom:Number;
			bottom = clipValue(logicY + item.height, 0, this.height);
			if (top == bottom)
			{
				item.visible = false;
				return;
			}
			item.y = getMapedPos(top);
			var height:Number;
			height = getMapedPos(bottom) - item.y;
			item.scaleY = height / item.height;
		
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
		private function getMapedPos(logicY:Number):Number
		{
			var centerY:Number;
			centerY = this.height * 0.5;
			var r:Number;
			r = this.height * 0.5;
			var d:Number;
			d = this.height;
			if (!isInRange(logicY, 0, this.height)) return -1;
			
			var dLen:Number;
			dLen = logicY;
			var angle:Number;
			angle = dLen*Math.PI / d;
			var mapY:Number;
			mapY = centerY - r * Math.cos(angle);
			return mapY;
			
			
		}

		private function itemRender(cell:Box, index:int):void
		{
			var dataO:Object;
			dataO = _array[index];
			var label:Label;
			label = cell.getChildByName("label");
			if (label)
			{
				label.text = dataO.label;
			}
		}
		
	}

}