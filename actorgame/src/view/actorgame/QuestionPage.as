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
		
		public function QuestionPage() 
		{
			selectList.renderHandler = new Handler(this, itemRender);
		}
		
		private function itemRender(cell:*, index:int):void
		{
		}
		
	}

}