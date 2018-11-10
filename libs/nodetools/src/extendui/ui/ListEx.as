///////////////////////////////////////////////////////////
//  ListEx.as
//  Macromedia ActionScript Implementation of the Class ListEx
//  Created on:      2015-11-13 上午11:27:36
//  Original author: ww
///////////////////////////////////////////////////////////

package extendui.ui
{
	import extendui.KeyManager;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.List;
	import laya.utils.Handler;
	
	
	/**
	 * 节点树上用的List 支持多选
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2015-11-13 上午11:27:36
	 */
	public class ListEx extends ListBase
	{
		public function ListEx()
		{
			super();
		}
		
		public var _selectIndexs:Array=[];
		public function isIDSelected(id:int):Boolean
		{
			return _selectIndexs.indexOf(id)>=0;
	    }
		public function setSelectList(selectList:Array):void
		{
			_selectIndexs=selectList;
			
			changeSelectStatus();
			if(_selectIndexs&&_selectIndexs.length>0)
			{
				_selectedIndex=selectList[0];
				scrollToIndex(_selectIndexs[0]);
			}
			
		}
		
		
		
		public function getCellUnderMouse(maxLen:int=5):*
		{
			if(!_cells||_cells.length<1) return null;
			var mouseY:Number=this.mouseY;
			var i:int,len:int;
			len=_cells.length;
			var tCell:Sprite;
			var mCell:Sprite;
			for(i=0;i<len;i++)
			{
				tCell=_cells[i];
				if(tCell.y<=mouseY&&tCell.y+tCell.height>=mouseY)
				{
					return tCell;
				}
				trace(Math.abs(tCell.y-mouseY));
				if(Math.abs(tCell.y-mouseY)<maxLen)
				{
					mCell=tCell;
				}
			}
			return mCell;
		}
		private var _preIndex:int;
		private var _preClickIndex:int;
		public var onlySameParentSelect:Boolean=false;
		private function get tSelectParent():int
		{
			if(!_selectIndexs||_selectIndexs.length<1) return -1;
			var i:int,len:int;
			var item:Object;
			return getParentByIndex(_selectIndexs[0]);
		}
		private function getParentByIndex(index:int):int
		{
			var item:Object;
			item=getItem(index);
			if(item)
			{
				return item.nodeParent;
			}
			return -1;
		}
		public var mutiSelectEnable:Boolean=true;
		private var _preNoShiftIndex:int=-1;
		override protected function onCellMouse(e:Event):void
		{
			if (e.type === Event.MOUSE_DOWN) _isMoved = false;
			var cell:Box = e.currentTarget as Box;
			var index:int = _startIndex + _cells.indexOf(cell);
			var ctrl:Boolean=e.nativeEvent.ctrlKey;
			var shift:Boolean=e.nativeEvent.shiftKey;
			//trace("onCellMouse");
			if (index < 0) return;
			
			if (e.type === Event.MOUSE_DOWN || e.type === Event.RIGHT_MOUSE_DOWN) {
				_preIndex=-1;
				_preClickIndex=index;
				if(ctrl&&mutiSelectEnable)
				{
					if(onlySameParentSelect)
					{
						var tP:int;
						tP=tSelectParent;
					    if(tP<=0||tP==getParentByIndex(index))
						{
							switchSelect(index);
						}
					}else
					{
						switchSelect(index);
					}
					
				}else
				{
					if(shift&&mutiSelectEnable)
					{
					}else
					if(isIDSelected(index))
					{
//						clearSelect();
//						changeSelectStatus();
//						if (selectEnable && !_isMoved) selectedIndex = index;
//						else changeCellState(cell, true, 0);
					}else
					{
						clearSelect();
						
						if (selectEnable && !_isMoved)
						{
							selectedIndex = index;	
							_preIndex=index;
						} 				
						else changeCellState(cell, true, 0);
					}

				}

			}else
			if (e.type === Event.CLICK || e.type === Event.RIGHT_CLICK) {
				var isShiftSelectSuccess:Boolean;
				if(shift&&mutiSelectEnable){
					if(mutiSelectEnable)
					{
						isShiftSelectSuccess=dealShiftSelect(index);
					}
					
				}
				else
				if(ctrl)
				{
				}else
				{
					if(isIDSelected(index)&&index!=_preIndex&&index==_preClickIndex)
					{
						if(_selectIndexs.length==1&&_selectIndexs[0]==index||e.type==Event.RIGHT_CLICK)
						{
						}else
						{
							clearSelect();
							changeSelectStatus();
							if (selectEnable && !_isMoved) selectedIndex = index;
							else changeCellState(cell, true, 0);
						}
						
					}
					
				}
				
				if(!isShiftSelectSuccess)
				{
					if(isIDSelected(index))
					{
						_preNoShiftIndex=index;
					}
				}
//				if(!shift)
//				{
//					if(isIDSelected(index))
//					{
//						_preNoShiftIndex=index;
//					}
//				}else
//				{
////					_preNoShiftIndex=-1;
//				}
			} else if ((e.type === Event.MOUSE_OVER || e.type === Event.MOUSE_OUT) && !isIDSelected( index)) {
				changeCellState(cell, e.type === Event.MOUSE_OVER, 0);
			}
			mouseHandler && mouseHandler.runWith([e, index]);
		}
		private function dealShiftSelect(index:int):Boolean
		{
//			trace("dealShiftSelect:",index,_preNoShiftIndex);
			if(_preNoShiftIndex<0) return false;
			if(!isIDSelected(_preNoShiftIndex)) return false;
			var i:int,len:int;
			clearSelect();
			var min:int,max:int;
			if(index>_preNoShiftIndex)
			{
				min=_preNoShiftIndex;
				max=index;
			}else
			{
				max=_preNoShiftIndex;
				min=index;
			}
			var parent:int;
			parent=getParentByIndex(min);
			if(parent!=getParentByIndex(max)) return false;
			
			for(i=min;i<=max;i++)
			{
				if(getParentByIndex(i)==parent)
				{
					_selectIndexs.push(i);
				}
				
			}
			changeSelectStatus();
			return true;
		}
		public function reRender():void
		{
			renderItems();
		}
		public var changeCellStateH:Handler;
		/**
		 * @private
		 * 改变单元格的可视状态。
		 * @param cell 单元格对象。
		 * @param visable 是否显示。
		 * @param index 单元格的属性 <code>index</code> 值。
		 */
		override protected function changeCellState(cell:Box, visable:Boolean, index:int):void {
			super.changeCellState(cell,visable,index);
			if(changeCellStateH)
			{
				changeCellStateH.runWith([cell,visable,index]);
			}
		}
		override protected function changeSelectStatus():void
		{
			for (var i:int = 0, n:int = _cells.length; i < n; i++) {
				changeCellState(_cells[i], isIDSelected( _startIndex + i), 1);
			}
		}
		override protected function renderItem(cell:Box, index:int):void 
		{
			if (index >= 0 && index < _array.length) {
				cell.visible = true;
				cell.dataSource = _array[index];
				posCell(cell, index);
			} else {
				cell.visible = false;
				cell.dataSource = null;
			}
			event(Event.RENDER, [cell, index]);
			renderHandler && renderHandler.runWith([cell, index]);
		}
		private function posCell(cell:Box, cellIndex:int):void {
			if (!_scrollBar) return;
			if (!_isVertical) return;
			var lineX:int = (_isVertical ? this.repeatX : this.repeatY);
			var lineY:int = (_isVertical ? this.repeatY : this.repeatX);
			var pos:Number = Math.floor(cellIndex / lineX) * _cellSize;
			_isVertical ? cell.y = pos : cell.x = pos;
		}
		public function getIndexByCell(cell:Box):int
		{
			return _array.indexOf(cell.dataSource);
		}
		public function clearSelect(autoChange:Boolean=false):void
		{
			_selectedIndex=-1;
			_selectIndexs.length=0;
			if(autoChange)
			{
				changeSelectStatus();
			}
		}
		private function switchSelect(index:int):void
		{
			var i:int;
			for(i=_selectIndexs.length-1;i>=0;i--)
			{
				if(index==_selectIndexs[i])
				{
					_selectIndexs.splice(i,1);
					changeSelectStatus();
					return;
				}
			}
			_selectIndexs.push(index);
			changeSelectStatus();
		}
		private function addSelect(index:int):void
		{
//			var item:Object;
//			item=getItem(index);
			if(!isIDSelected(index))
			{
				_selectIndexs.push(index);
			}
		}
		
		private var _selectItems:Array=[];
		public function get selectItems():Array
		{
			_selectItems.length=0;
			var i:int,len:int;
			len=_selectIndexs.length;
			var tItem:*;
			for(i=0;i<len;i++)
			{
				tItem=getItem(_selectIndexs[i]);
				if(tItem)
				_selectItems.push(tItem);
			}
			return _selectItems;
		}
		private var _plainSelectList:Array=[];
		public function get plainSelectItems():Array
		{
			_plainSelectList.length=0;
			var selectList:Array;
			selectList=selectItems;
			var i:int,len:int;
			len=selectList.length;
			var tItem:Object;
			var tItemParent:Object;
			for(i=0;i<len;i++)
			{
				tItem=selectList[i];
				if(selectList.indexOf(tItem.parent)<0)
				{
					_plainSelectList.push(tItem);
				}
			}
			return _plainSelectList;
		}
		override public function get selectedIndex():int
		{
			// TODO Auto Generated method stub
			return super.selectedIndex;
		}
		
		override public function set selectedIndex(value:int):void
		{
			// TODO Auto Generated method stub
			clearSelect();
			addSelect(value);
//			trace("select:",value);
			_selectedIndex=-1;
			super.selectedIndex = value;
//			trace("selectedIndex:",value);
		}
		
		override public function get selectedItem():Object
		{
			// TODO Auto Generated method stub
			return super.selectedItem;
		}
		
		override public function set selectedItem(value:Object):void
		{
			// TODO Auto Generated method stub
			super.selectedItem = value;
		}
		
		public static function dealAbcKey(keyCode:int,list:List):void
		{
			if(!list) return;
			var key:String;
			key=KeyManager.getCharByCode(keyCode);
			key=key.toLowerCase();
			var i:int,len:int;
			var startI:int;
			startI=list.selectedIndex;
			if(startI<0) startI=0;
			var arr:Array;
			arr=list.array;
			len=arr.length;
			var tLabel:String;
			for(i=startI+1;i<len;i++)
			{
				if(arr[i])
					tLabel=arr[i]["label"];
				if(tLabel&&tLabel.charAt(0).toLowerCase()==key)
				{
					list.selectedIndex=i;
					return;
				}
			}
			for(i=0;i<len;i++)
			{
				if(arr[i])
					tLabel=arr[i]["label"];
				if(tLabel&&tLabel.charAt(0).toLowerCase()==key)
				{
					list.selectedIndex=i;
					return;
				}
			}
		}
		
		
	}
}