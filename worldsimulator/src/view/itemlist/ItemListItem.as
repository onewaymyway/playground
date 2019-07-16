package view.itemlist 
{
	import ui.simulator.ItemListItemUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ItemListItem extends ItemListItemUI 
	{
		
		public function ItemListItem() 
		{
			
		}
			
		private var dataO:Object;
		public function initByData(dataO:Object):void
		{
			this.dataO = dataO;
			if (dataO.count > 1)
			{
				itemText.text = dataO.name + ":" + dataO.count;
			}else
			{
				itemText.text = dataO.name;
			}
		}
	}

}