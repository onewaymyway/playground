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
			this.addChild(nodeContainer);
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
		private var mapNodeData:MindMapNodeData;
		public function setData(dataO:Object):void
		{
			this._dataO = dataO;
			mapNodeData = MindMapNodeData.createByObj(dataO);
			freshUI();
		}
		
		
		private function freshUI():void
		{
			nodeContainer.removeChildren();
			var root:MindMapItem;
			root = createMapView(mapNodeData);
			debugger;
			root.pos(200, 200);
			root.layoutAsCenter();
		}
		
		public function createMapView(nodeData:MindMapNodeData):MindMapNodeData
		{
			var rst:MindMapItem;
			rst = createMapItem(nodeData);
			var childs:Array;
			childs = nodeData.childs;
			var i:int, len:int;
			len = childs.length;
			var tChildData:MindMapNodeData;
			var tChildItem:MindMapItem;
			for (i = 0; i < len; i++)
			{
				tChildData = childs[i];
				tChildItem = createMapItem(tChildData);
				rst.addChildNode(tChildItem);
			}
			
			return rst;
		}
		
		private function createMapItem(nodeData:MindMapNodeData):MindMapNodeData
		{
			var rst:MindMapItem;
			rst = MindMapItem.createByData(nodeData);
			nodeContainer.addChild(rst);
			return rst;
		}
	}

}