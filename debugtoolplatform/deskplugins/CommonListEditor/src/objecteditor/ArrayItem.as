package objecteditor 
{
	import ui.objecteditor.ArrayItemUI;
	import commontools.EventTools;
	import laya.events.Event;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ArrayItem extends ArrayItemUI 
	{
		
		public function ArrayItem() 
		{
			addBtn.on(Event.CLICK, this, onAction, ["add"]);
		}
		
		private function onAction(action:String):void
		{
			switch(action)
			{
				case "add":
					ObjectTreeTool.showAddValueMenu(this);
					break;
			}
		}
		
	}

}