package view.actorgame 
{
	import laya.utils.Handler;
	import ui.actorgame.ReportItemUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ReportItem extends ReportItemUI 
	{
		
		public function ReportItem() 
		{
			starList.renderHandler = new Handler(this, itemRender);
		}
		
		private function itemRender(cell:*, index:int):void
		{
		}
		
		private var _dataO:Object;
		public function initByData(dataO:Object):void
		{
			_dataO = dataO;
		}
		
	}

}