package view.actorgame 
{
	import ui.actorgame.QuestionSelectItemUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class QuestionSelectItem extends QuestionSelectItemUI 
	{
		
		public function QuestionSelectItem() 
		{
			
		}
		
		private var _dataO:Object;
		public function initByData(dataO:Object):void
		{
			_dataO = dataO;
		}
	}

}