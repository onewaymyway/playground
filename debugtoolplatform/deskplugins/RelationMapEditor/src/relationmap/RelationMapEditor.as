package relationmap 
{
	import laya.events.Event;
	import ui.relationmap.RelationMapEditorUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class RelationMapEditor extends RelationMapEditorUI 
	{
		
		public function RelationMapEditor() 
		{
			saveBtn.on(Event.CLICK, this, onSaveBtn);
		}
		
		
		private function onSaveBtn():void
		{
			event("save");
		}
		
		public var dataO:Object;
		public function setData(dataO:Object):void
		{
			this.dataO = dataO;
			freshUI();
		}
		
		public function freshUI():void
		{
			
		}
	}

}