package objecteditor 
{
	import commontools.EventTools;
	import laya.debug.tools.ObjectTools;
	import laya.events.Event;
	import ui.objecteditor.ObjectItemUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ObjectItem extends ObjectItemUI 
	{
		public function ObjectItem() 
		{
			addBtn.on(Event.CLICK, this, onAction, ["add"]);
		}
		
		private function onAction(action:String):void
		{
			switch(action)
			{
				case "add":
					_dataO.childs.push(ObjectDataTpl.createKeyData());
					//Notice.notify(AnswerFlowEvents.DataChanged);
					EventTools.sendEventOnTree(this, "DataChanged");
					break;
			}
		}
		
	}

}