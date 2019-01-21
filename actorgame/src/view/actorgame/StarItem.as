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
		
		public function initByData(dataO:*):void
		{
			_dataO = dataO;
			switch(dataO)
			{
				case 0:
					icon.skin = "comp/prop.png";
					break;
				case 2:
					icon.skin = "comp/prop_gray.png";
					break;
				case 1:
					icon.skin = "comp/prop_green.png";
					break;
			}
		}
		
	}

}