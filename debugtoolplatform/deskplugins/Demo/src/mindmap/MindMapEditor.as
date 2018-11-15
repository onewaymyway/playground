package mindmap 
{
	import laya.debug.uicomps.ContextMenu;
	import laya.events.Event;
	import laya.ui.Box;
	import ui.mindmap.MindMapEditorUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class MindMapEditor extends MindMapEditorUI 
	{
		private var _menu:ContextMenu;
		private var nodeContainer:Box;
		public function MindMapEditor() 
		{
			_menu = ContextMenu.createMenuByArray(["新建"]);
			_menu.on(Event.SELECT, this, onSelect);
			this.on(Event.RIGHT_MOUSE_UP, this, onRightClick);
			nodeContainer = new Box();
			nodeContainer.left = nodeContainer.right = nodeContainer.top = nodeContainer.bottom = 0;
			this.addChildAt();
		}
		
		
		private function onRightClick():void
		{
			_menu.show();
		}
		
		private function onSelect(dataO:Object):void
		{
			trace("onMenuSelect:", dataO);
			var label:String;
			label = dataO.target.data;
			trace("Menu:",label);
			switch(label)
			{
				
			}
		}
		
		private var _dataO:Object;
		private var mapData:MindMapData;
		public function setData(dataO:Object):void
		{
			this._dataO = dataO;
			mapData = MindMapData.createByObj(dataO);
			freshUI();
		}
		
		
		private function freshUI():void
		{
			
		}
		
		
		
	}

}