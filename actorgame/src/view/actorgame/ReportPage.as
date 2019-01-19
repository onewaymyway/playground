package view.actorgame 
{
	import laya.events.Event;
	import laya.utils.Handler;
	import scenetools.SceneSwitcher;
	import ui.actorgame.ReportPageUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ReportPage extends ReportPageUI 
	{
		private static var _I:ReportPage;
		public static function get I():ReportPage
		{
			if (!_I) _I = new ReportPage();
			return _I;
		}
		
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
					this.close();
					break;
			}
		}
		
		
		
	}

}