package commontools 
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.events.EventDispatcher;
	import laya.ui.Label;
	/**
	 * ...
	 * @author ww
	 */
	public class TextTabControl extends EventDispatcher
	{
		
		public var selectFontSize:int = 34;
		public var normalFontSize:int = 28;
		public var selectColor:String = "#666666";
		public var normalColor:String = "#818c92";
		public var hasAction:Boolean = true;
		private var tabList:Array;
		private var _selectIndex:int=-1;
		public function TextTabControl() 
		{
			
		}
		
		public function initTabs(tabList:Array, selectIndex:int = 0,hasAction:Boolean=true):void
		{
			this.hasAction = hasAction;
			this.tabList = tabList;
			var i:int, len:int;
			len = tabList.length;
			var tItem:Sprite;
			for (i = 0; i < len; i++)
			{
				tItem = tabList[i];
				if(hasAction)
				tItem.on(Event.CLICK, this, onTabClick, [i]);
			}
			this.selectIndex = selectIndex;
		}
		
		private function onTabClick(index:int):void
		{
			selectIndex = index;
		}
		
		public function get selectIndex():int
		{
			return _selectIndex;
		}
		
		public function set selectIndex(value:int):void
		{
			if (_selectIndex === value) return;
			_selectIndex = value;
			var i:int, len:int;
			len = tabList.length;
			var tItem:*;
			for (i = 0; i < len; i++)
			{
				updateTabState(i, value == i);
				
			}
			event(Event.CHANGE);
		}
		
		
		private function updateTabState(index:int, isSelect:Boolean):void
		{
			var tItem:Label;
			tItem = tabList[index];
			if (!tItem) return;
			if (isSelect)
			{
				tItem.fontSize = selectFontSize;
				tItem.color = selectColor;
			}else
			{
				tItem.color = normalColor;
				tItem.fontSize = normalFontSize;
			}
		}
		
	}

}