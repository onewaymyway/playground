package view.actorgame 
{
	import ui.actorgame.ActorItemUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ActorItem extends ActorItemUI 
	{
		
		public function ActorItem() 
		{
			
		}
		private var _dataO:Object;
		public function initByData(dataO:Object):void
		{
			_dataO = dataO;
		}
		
	}

}