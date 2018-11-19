package mindmap 
{
	import laya.debug.uicomps.ContextMenu;
	import laya.events.Event;
	import laya.ui.Box;
	import laya.utils.Handler;
	import nodetools.devices.FileManager;
	import ui.mindmap.MindMapEditorUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class MindMapEditor extends MindMapEditorUI 
	{
		private var _menu:ContextMenu;
		private var nodeContainer:Box;
		private var onMenuSelectHandler:Handler;
		private var _userChanged:Boolean = false;
		public function MindMapEditor() 
		{
			_menu = ContextMenu.createMenuByArray(["新建"]);
			_menu.on(Event.SELECT, this, onSelect);
			onMenuSelectHandler = new Handler(this, onSelect);
			//this.on(Event.RIGHT_MOUSE_UP, this, onRightClick);
			nodeContainer = new Box();
			nodeContainer.size(1, 1);
			nodeContainer.hitTestPrior = false;
			//nodeContainer.left = nodeContainer.right = nodeContainer.top = nodeContainer.bottom = 0;
			this.addChild(nodeContainer);
			this.on(Event.RESIZE, this, onResize);
			onResize();
			this.on(Event.RIGHT_MOUSE_DOWN, this, onRightDown);
			this.on(Event.RIGHT_MOUSE_UP, this, onRightUp);
			
			saveBtn.on(Event.CLICK, this, onActionBtn, ["save"]);
		}
		
		private function onActionBtn(type:String):void
		{
			switch(type)
			{
				case "save":
					debugger;
					trace("save:",_dataO.url, mapNodeData);
					FileManager.createJSONFile(_dataO.url, mapNodeData);
					break;
			}
		}
		private function onRightDown(e:Event):void
		{
			if (nodeContainer.contains(e.target)&&e.target!=nodeContainer) return;
			nodeContainer.startDrag();
			_userChanged = true;
		}
		
		private function onRightUp(e:Event):void
		{
			nodeContainer.stopDrag();
		}
		private function onResize():void
		{
			if (_userChanged) return;
			nodeContainer.pos(this.width*0.5,this.height*0.5);
		}
		
		private function onRightClick():void
		{
			_menu.show();
		}
		
		private function onSelect(dataO:Object,target:MindMapItem):void
		{
			trace("onMenuSelect:", dataO,target);
			var label:String;
			label = dataO.target.data;
			trace("Menu:",label);
			switch(label)
			{
				case "新建子":
					target.nodeData.addChild(MindMapNodeData.createByLabel("new"));
					freshUI();
					break;
			}
		}
		
		private var _dataO:Object;
		private var mapData:MindMapData;
		private var mapNodeData:MindMapNodeData;
		public function setData(dataO:Object):void
		{
			this._dataO = dataO;
			mapNodeData = MindMapNodeData.createByObj(dataO.data,true);
			freshUI();
		}
		
		
		private function freshUI():void
		{
			nodeContainer.removeChildren();
			var root:MindMapItem;
			root = createMapView(mapNodeData);
			//debugger;
			root.pos(0, 0);
			root.layoutAsCenter();
			nodeContainer.graphics.clear();
			root.drawConnections(nodeContainer);
			trace("data:",root.nodeData);
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
				tChildItem = createMapTree(tChildData);
				rst.addChildNode(tChildItem);
			}
			
			return rst;
		}
		
		private function createMapTree(nodeData:MindMapNodeData):MindMapNodeData
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
				tChildItem = createMapTree(tChildData);
				rst.addChildNode(tChildItem);
			}
			
			return rst;
		}
		
		private function createMapItem(nodeData:MindMapNodeData):MindMapNodeData
		{
			var rst:MindMapItem;
			rst = MindMapItem.createByData(nodeData);
			nodeContainer.addChild(rst);
			rst.onMenuSelectHandler = onMenuSelectHandler;
			return rst;
		}
	}

}