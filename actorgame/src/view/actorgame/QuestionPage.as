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
		
		private function itemRender(cell:*, index:int):void
		{
		}
		
		public function start():void
		{
			this.popup();
		}
		
	}

}