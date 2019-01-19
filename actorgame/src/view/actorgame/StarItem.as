package view.actorgame 
{
	import ui.actorgame.StarItemUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class StarItem extends StarItemUI 
	{
		
		public function StarItem() 
		{
			
		}
		
		private var _dataO:Object;
		public function initByData(dataO:Object):void
		{
			_dataO = dataO;
		}
		
	}

}