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
			list.renderHandler = new Handler(this, itemRender);
		}
		
		private function itemRender(cell:*, index:int):void
		{
			cell.initByData(cell.dataSource);
		}
	}

}