package view.actionlist 
{
	import ui.simulator.ActionItemUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ActionItem extends ActionItemUI 
	{
		
		public function ActionItem() 
		{
			
		}
		
		private var dataO:Object;
		public function initByData(dataO:Object):void
		{
			this.dataO = dataO;
			actionText.text = dataO.tip;
		}

	}

}