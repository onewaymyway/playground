package view.actionlist 
{
	import laya.utils.Handler;
	import ui.simulator.ActionListUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ActionList extends ActionListUI 
	{
		
		public function ActionList() 
		{
			initList();
		}
		
		public function setData(dataList:Array):void
		{
			list.array = dataList;
		}
		
		
		private function initList():void
		{
			list.scrollBar.autoHide = true;
			list.renderHandler = new Handler(this, itemRender);
		}
		public var actionClickHandler:Handler;
		private function itemRender(cell:*, index:int):void
		{
			cell.clickHandler = actionClickHandler;
			cell.initByData(cell.dataSource);
		}
	}

}