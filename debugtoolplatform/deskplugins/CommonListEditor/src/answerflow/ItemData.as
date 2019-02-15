package answerflow 
{
	import laya.events.Event;
	import ui.answerflow.ItemDataUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ItemData extends ItemDataUI 
	{
		public static var itemLabels:String;
		public function ItemData() 
		{
			setUpTextInput(item, "item");
			setUpTextInput(count, "count");
			removeBtn.on(Event.CLICK, this, removeFromParent);
		}
		
		override protected function renderByData():void 
		{
			super.renderByData();
			
			item.text = _dataO.props["item"] || "";
			count.text = _dataO.props["count"] || "";
			if (itemLabels)
			{
				item.labels = itemLabels;
			}
		}
	}

}