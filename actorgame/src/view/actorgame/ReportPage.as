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
		
		private function itemRender(cell:ReportItem, index:int):void
		{
			cell.initByData(cell.dataSource);
		}
		
		private var paramO:Object;
		public function onSetParam(paramO:Object):void
		{
			this.paramO = paramO;
			QGameState.I.updateRoleState(paramO.ops);
			QGameState.I.todayInfo();
			infoTxt.text = "剩余资金:" + QGameState.I.money + " 今日:" + QGameState.I.changedMoney;
			reportList.array = QGameState.I.roleStates;
		}
		
		
		
		private function onBtnAction(type:String):void
		{
			switch(type)
			{
				case "continue":
					GameMain.I.nextDay();
					this.close();
					break;
			}
		}
		
		
		
	}

}