///////////////////////////////////////////////////////////
//  TabEx.as
//  Macromedia ActionScript Implementation of the Class TabEx
//  Created on:      2016-2-29 下午3:07:35
//  Original author: ww
///////////////////////////////////////////////////////////

package extendui.ui
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.ISelect;
	import laya.ui.Image;
	import laya.ui.Tab;
	
	
	/**
	 * 
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2016-2-29 下午3:07:35
	 */
	public class TabEx extends Tab
	{
		public function TabEx()
		{
			super();
			_otherContainer=new Box();
			_otherContainer.mouseEnabled=true;
			
			_otherBtn=new Button();
			_otherBtn.skin="comp/button.png";
			_otherBtn.width=20;
			_otherBtn.on(Event.CLICK,this,switchOtherContainer);
			_otherContainer.on(Event.CLICK,this,hideOtherContainer);
		}
		private var _otherBack:Image;
		private function switchOtherContainer():void
		{
			if(_otherContainer.parent)
			{
				hideOtherContainer();
			}else
			{
				showOtherContainer();
			}
		}
		public function hideOtherContainer():void
		{
			_otherContainer.removeSelf();
			Laya.stage.off(Event.CLICK,this,hideOtherContainer);
		}
		public function showOtherContainer():void
		{
			var tPoint:Point;
			tPoint=Point.TEMP;
			tPoint.setTo(_otherBtn.width,_otherBtn.height);
			tPoint=_otherBtn.localToGlobal(tPoint);
			
			Laya._currentStage.addChild(_otherContainer);
			_otherContainer.pos(tPoint.x-_otherContainer.width,tPoint.y);
			
			Laya.timer.once(100,this,addRemoveEvents);
		}
		private function addRemoveEvents():void
		{
			if(!_otherContainer.parent) return;
			Laya.stage.off(Event.CLICK,this,hideOtherContainer);
			Laya.stage.on(Event.CLICK,this,hideOtherContainer);
		}
		override public function addItem(item:ISelect, autoLayOut:Boolean=true):int
		{
			// TODO Auto Generated method stub
			var rst:int;
			rst= super.addItem(item, autoLayOut);
			updateUI();
			if(maxLen<0) return rst;
			if((item as Sprite).parent==_otherContainer)
			{
				itemClick(rst);
			}
			return _items.indexOf(item);
		}
		
		override public function set selectedIndex(value:int):void
		{
			// TODO Auto Generated method stub
			if(maxLen<0) 
			{
				super.selectedIndex = value;
				return;
			}
			var tItem:Sprite;
			tItem=_items[value] as Sprite;
			if(tItem)
			{
				if(tItem.parent==_otherContainer)
				{
					//					debugger;
					var newIndex:int;
					newIndex=switchItemToDis(value);
					_selectedIndex=-2;
					super.selectedIndex=newIndex;
					return;
				}
			}
			setSelect(_selectedIndex, false);
			_selectedIndex=-2;
			super.selectedIndex = value;
			
		}
		
		
		override public function delItem(item:ISelect, autoLayOut:Boolean=true):void
		{
			var index:int = _items.indexOf(item);
			if (index != -1) {
				var display:Sprite = item as Sprite;
				removeChild(display);
				
				for (var i:int = index + 1, n:int = _items.length; i < n; i++) {
					var child:Sprite = _items[i] as Sprite;
					child.name = "item" + (i - 1);
					if (autoLayOut) {
						if (_direction == "horizontal") {
							child.x -= display.width + _space;
						} else {
							child.y -= display.height + _space;
						}
					}
				}
				_items.splice(index, 1);
				initItems();
				if (_selectedIndex > -1) {
					var newIndex:int;
					newIndex = _selectedIndex < _items.length ? _selectedIndex : (_selectedIndex - 1);
					_selectedIndex=99;
					selectedIndex=newIndex;
				}
			}
			updateUI();
		}
		public function switchItemToDis(index:int):int
		{
		    var tItem:ISelect;
			tItem=_items[index];
			_items.splice(index,1);
			_items.unshift(tItem);
			reNameItems();
			initItems();
			updateUI();
			return _items.indexOf(tItem);
		}
		public function reNameItems():void
		{
			var i:int,len:int;
			var tItem:Sprite;
			len=_items.length;
			for(i=0;i<len;i++)
			{
				tItem=_items[i] as Sprite;
				tItem.name="item"+i;
			}
		}
		override protected function itemClick(index:int):void
		{
//			if(maxLen<0) return super.itemClick(index);;
//			// TODO Auto Generated method stub
//			var tItem:Sprite;
//			tItem=_items[index] as Sprite;
//			if(tItem)
//			{
//				if(tItem.parent==_otherContainer)
//				{
////					debugger;
//					var newIndex:int;
//					newIndex=switchItemToDis(index);
//					super.itemClick(newIndex);
//					return;
//				}
//			}
			super.itemClick(index);
		}
		
		
		public var maxLen:int=-1;
		private var _otherContainer:Sprite;
		private var _otherBtn:Button;
		public function updateUI():void
		{
			if(maxLen<0) return;
			var maxUILen:Number;
			maxUILen=maxLen-_otherBtn.width-2;
			var i:int,len:int;
			len=_items.length;
			var _otherList:Array;
			_otherList=[];
			var preItem:Sprite;
			var tItem:Sprite;
			var tX:Number;
			var tY:Number;
			tX=0;
			tY=0;
			for(i=0;i<len;i++)
			{
				tItem=_items[i] as Sprite;
				tItem.pos(tX,tY);
				
				this.addChild(tItem);
				if (_direction == "horizontal") {
					tX=tItem.x+tItem.width+_space;
					if(tX>maxUILen)
					{
						_otherList.push(tItem);
					}
				} else {
					tY = tItem.y + tItem.height + _space;
				}
				
			}
			if(_otherList.length>0)
			{
				this.addChild(_otherBtn);
				_otherBtn.pos(maxLen-_otherBtn.width,0);
			}else
			{
				_otherBtn.removeSelf();
			}
			setUpOtherList(_otherList);
		}
		
		public function setUpOtherList(_items:Array):void
		{
			if(!_otherBack)
			{
				_otherBack=new Image();
				_otherBack.skin="view/bg_menu.png";
				
			}
			_otherContainer.removeChildren();
			_otherBack.size(10,10);
			_otherContainer.addChild(_otherBack);
			var i:int,len:int;
			len=_items.length;
			var tItem:Sprite;
			var tX:Number;
			var tY:Number;
			tX=0;
			tY=0;
			for(i=0;i<len;i++)
			{
				tItem=_items[i];
				tItem.pos(tX,tY);
				_otherContainer.addChild(tItem);

				tY = tItem.y + tItem.height + _space;
				
				
			}
			_otherBack.size(_otherContainer.width,_otherContainer.height);
		}
		
		override public function initItems():void
		{
			if(maxLen>0)
			{
				if(_items)
				{
					var i:int,len:int;
					len=_items.length;
					var tItem:Sprite;
					for(i=0;i<len;i++)
					{
						tItem=_items[i] as Sprite;
						this.addChild(tItem);
					}
				}
			}

			// TODO Auto Generated method stub
			super.initItems();
		}
		
		
	}
}