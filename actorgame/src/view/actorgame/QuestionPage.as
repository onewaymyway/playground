package view.actorgame 
{
	import laya.utils.Handler;
	import ui.actorgame.QuestionPageUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class QuestionPage extends QuestionPageUI 
	{
		private static var _I:QuestionPage;
		public static function get I():QuestionPage
		{
			if (!_I) _I = new QuestionPage();
			return _I;
		}
		
		public function QuestionPage() 
		{
			selectList.renderHandler = new Handler(this, itemRender);
		}
		
		private function itemRender(cell:QuestionSelectItem, index:int):void
		{
			cell.initByData(cell.dataSource);
		}
		
		private function setData(questionO:Object):void
		{
			if(!questionO)
			questionO = QGameDataManager.I.getRandomQuestion();
			questionTxt.text = questionO.label;
			selectList.array = questionO.ops;
		}
		
		public function start(questionO:Object=null):void
		{
			setData(questionO);
			this.popup();
		}
		
	}

}