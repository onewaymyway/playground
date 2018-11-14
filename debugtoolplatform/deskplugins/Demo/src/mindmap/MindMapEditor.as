package mindmap 
{
	import laya.debug.uicomps.ContextMenu;
	import laya.events.Event;
	import ui.mindmap.MindMapEditorUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class MindMapEditor extends MindMapEditorUI 
	{
		private var _menu:ContextMenu;
		public function MindMapEditor() 
		{
			_menu = ContextMenu.createMenuByArray(["新建"]);
			this.on(Event.RIGHT_MOUSE_UP, this, onRightClick);
		}
		
		
		private function onRightClick():void
		{
			_menu.show();
		}
		
		private var _dataO:Object;
		
		public function setData(dataO:Object):void
		{
			this._dataO = dataO;
			freshUI();
		}
		
		
		private function freshUI():void
		{
			
		}
		
		
		
	}

}