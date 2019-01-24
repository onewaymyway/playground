package relationmap 
{
	import commonlayout.AutoScrollRecBox;
	import laya.events.Event;
	import ui.relationmap.RelationMapEditorUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class RelationMapEditor extends RelationMapEditorUI 
	{
		public var editorBox:AutoScrollRecBox;
		public function RelationMapEditor() 
		{
			optionTab.selectedIndex = 0;
			saveBtn.on(Event.CLICK, this, onSaveBtn);
			optionTab.on(Event.CHANGE, this, onOpTypeChange);
			editorBox = new AutoScrollRecBox();
			container.addChild(editorBox);
		}
		
		
		
		public function isLineMode():Boolean
		{
			return optionTab.selectedIndex == 2;
		}
		
		public function isNodeMode():Boolean
		{
			return optionTab.selectedIndex == 1;
		}
		
		public function isOperateMode():Boolean
		{
			return optionTab.selectedIndex == 0;
		}
		
		private function onOpTypeChange():void
		{
			
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