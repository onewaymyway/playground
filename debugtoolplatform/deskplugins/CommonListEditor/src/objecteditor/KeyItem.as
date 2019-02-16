package objecteditor 
{
	import commontools.EventTools;
	import laya.events.Event;
	import ui.objecteditor.KeyItemUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class KeyItem extends KeyItemUI 
	{
		
		public function KeyItem() 
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
		
		override public function addChildData(dataO:Object):void 
		{
			_dataO.childs.length = 0;
			super.addChildData(dataO);
		}
		
	}

}