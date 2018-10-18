package view.actionlist 
{
	import laya.events.Event;
	import laya.utils.Handler;
	import ui.simulator.ActionItemUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ActionItem extends ActionItemUI 
	{
		public var clickHandler:Handler;
		public function ActionItem() 
		{
			actionBtn.on(Event.CLICK, this, onActionClick);
		}
		
		private function onActionClick():void
		{
			if (clickHandler)
			{
				clickHandler.runWith(dataO);
			}
		}
		
		private var dataO:Object;
		public function initByData(dataO:Object):void
		{
			this.dataO = dataO;
			actionText.text = dataO.tip;
			actionBtn.x = actionText.x + actionText.width + 5;
		}

	}

}