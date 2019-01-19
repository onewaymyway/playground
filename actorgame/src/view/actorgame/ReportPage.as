package view.actorgame 
{
	import laya.events.Event;
	import laya.utils.Handler;
	import ui.actorgame.ReportPageUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ReportPage extends ReportPageUI 
	{
		
		public function ReportPage() 
		{
			reportList.renderHandler = new Handler(this, itemRender);
			continueBtn.on(Event.CLICK, this, onBtnAction, ["continue"]);
		}
		
		private function itemRender(cell:*, index:int):void
		{
		}
		
		private function onBtnAction(type:String):void
		{
			switch(type)
			{
				case "continue":
					
					break;
			}
		}
		
	}

}