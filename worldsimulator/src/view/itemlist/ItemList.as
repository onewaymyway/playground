package view.itemlist 
{
	import laya.utils.Handler;
	import ui.simulator.ItemListUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ItemList extends ItemListUI 
	{
		
		public function ItemList() 
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
		
		private function itemRender(cell:*, index:int):void
		{
			cell.initByData(cell.dataSource);
		}
	
	}

}