///////////////////////////////////////////////////////////
//  ListBase.as
//  Macromedia ActionScript Implementation of the Class ListBase
//  Created on:      2016-7-6 上午9:42:46
//  Original author: ww
///////////////////////////////////////////////////////////

package extendui.ui
{
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.List;
	import laya.ui.ScrollBar;
	
	
	/**
	 * 
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2016-7-6 上午9:42:46
	 */
	public class ListBase extends List
	{
		public var useFloorMethod:Boolean=false;
		public function ListBase()
		{
			super();
		}
		override public function set selectedIndex(value:int):void {
			if (selectEnable && _scrollBar) {
				var numX:int = _isVertical ? repeatX : repeatY;
				if (!isNumInViewRange(value)) {
					scrollTo(value);
				}
			}
			if (_selectedIndex != value) {
				_selectedIndex = value;
				changeSelectStatus();
				event(Event.CHANGE);
				selectHandler && selectHandler.runWith(value);
			}
			
			
		}
		
		public function isNumInViewRange(value:int):Boolean
		{
//			var isOK:Boolean;
//			isOK=value>=_startIndex&&value<_startIndex+repeatX*repeatY;
//			trace("isNumInViewRange",value,_startIndex,_startIndex+repeatX*repeatY,isOK);
//			if(!isOK) debugger;
			return value>=_startIndex&&value<_startIndex+repeatX*repeatY;
		}
		public function scrollToIndex(value:int):void
		{
			if (selectEnable && _scrollBar) {
				var numX:int = _isVertical ? repeatX : repeatY;
				if (!isNumInViewRange(value)) {
					scrollTo(value);
				}
			}
		}
		
		override protected function changeCells():void
		{
			_cellChanged = false;
			if (_itemRender) {
				//获取滚动条
				scrollBar = getChildByName("scrollBar") as ScrollBar;
				
				//自适应宽高				
				var cell:Box = _getOneCell();
				
				var cellWidth:Number = (cell.width + _spaceX) || 1;
				var cellHeight:Number = (cell.height + _spaceY) || 1;
				
				if(useFloorMethod)
				{
					if (_width > 0) _repeatX2 = _isVertical ? Math.floor(_width / cellWidth) : Math.floor(_width / cellWidth);
					if (_height > 0) _repeatY2 = _isVertical ? Math.floor(_height / cellHeight) : Math.floor(_height / cellHeight);
				}else
				{
					if (_width > 0) _repeatX2 = _isVertical ? Math.round(_width / cellWidth) : Math.ceil(_width / cellWidth);
					if (_height > 0) _repeatY2 = _isVertical ? Math.ceil(_height / cellHeight) : Math.round(_height / cellHeight);
				}
				
				
				var listWidth:Number = _width ? _width : (cellWidth * repeatX - _spaceX);
				var listHeight:Number = _height ? _height : (cellHeight * repeatY - _spaceY);
				_cellSize = _isVertical ? cellHeight : cellWidth;
				_cellOffset = _isVertical ? (cellHeight * Math.max(_repeatY2, _repeatY) - listHeight - _spaceY) : (cellWidth * Math.max(_repeatX2, _repeatX) - listWidth - _spaceX);
				
				if (_isVertical && _scrollBar) _scrollBar.height = listHeight;
				else if (!_isVertical && _scrollBar) _scrollBar.width = listWidth;
				setContentSize(listWidth, listHeight);
				
				//创建新单元格				
				var numX:int = _isVertical ? repeatX : repeatY;
				var numY:int = (_isVertical ? repeatY : repeatX) + (_scrollBar ? 1 : 0);
				_createItems(0, numX, numY);
				_createdLine = numY;
				
				if (_array) {
					array = _array;
					runCallLater(renderItems);
				}
			}
		}
		
		
	}
}