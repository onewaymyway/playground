package view.actorgame 
{
	import laya.events.Event;
	import scenetools.SceneSwitcher;
	import ui.actorgame.QuestionSelectItemUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class QuestionSelectItem extends QuestionSelectItemUI 
	{
		
		public function QuestionSelectItem() 
		{
			actionBtn.on(Event.CLICK, this, onClick);
		}
		
		private var _dataO:Object;
		public function initByData(dataO:Object):void
		{
			_dataO = dataO;
			actionBtn.label = dataO.labelEx||dataO.label;
		}
		
		private function onClick():void
		{
			QuestionPage.I.close();
			SceneSwitcher.I.showDialog(ReportPage, _dataO, true, true);
		}
	}

}