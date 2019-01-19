package view.actorgame 
{
	import laya.events.Event;
	import ui.actorgame.ActorItemUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ActorItem extends ActorItemUI 
	{
		
		public function ActorItem() 
		{
			icon.on(Event.CLICK, this, onClick);
		}
		private var _dataO:Object;
		public function initByData(dataO:Object):void
		{
			_dataO = dataO;
		}
		
		private function onClick():void
		{
			QuestionPage.I.start();
		}
		
	}

}