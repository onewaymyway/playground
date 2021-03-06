package mindmap 
{
	import extendui.events.ScaleAction;
	import laya.debug.uicomps.ContextMenu;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	import laya.ui.Box;
	import laya.utils.Handler;
	import ui.mindmap.MindMapEditorUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class MindMapEditor extends MindMapEditorUI 
	{
		public static const Save:String = "Save";
		private var _menu:ContextMenu;
		private var nodeContainer:Box;
		private var onMenuSelectHandler:Handler;
		private var onItemActionHandler:Handler;
		private var _userChanged:Boolean = false;
		private var _selectItem:MindMapItem;
		public static var isEditorMode:Boolean = true;
		public function MindMapEditor() 
		{
			_menu = ContextMenu.createMenuByArray(["新建"]);
			_menu.on(Event.SELECT, this, onSelect);
			onMenuSelectHandler = new Handler(this, onSelect);
			onItemActionHandler = new Handler(this, onItemAction);
			//this.on(Event.RIGHT_MOUSE_UP, this, onRightClick);
			nodeContainer = new Box();
			nodeContainer.size(1, 1);
			nodeContainer.hitTestPrior = false;
			//nodeContainer.left = nodeContainer.right = nodeContainer.top = nodeContainer.bottom = 0;
			this.addChild(nodeContainer);
			this.on(Event.RESIZE, this, onResize);
			onResize();
			this.on(Event.MOUSE_DOWN, this, onRightDown);
			this.on(Event.MOUSE_UP, this, onRightUp);
			saveBtn.zOrder = 99;
			saveBtn.on(Event.CLICK, this, onActionBtn, ["save"]);
			
			this.on(Event.MOUSE_WHEEL, this, onMouseWheel);
			
			ScaleAction.setTargetScaleActionEnabled(this);
			this.on(ScaleAction.ScaleActionEvent, this, onScaleAction);
		}
		
		private function onScaleAction(dValue:Number):void
		{
			var scale:Number;
			scale = containerScale;
			scale *= dValue;
			//trace("scale:", dValue);
			if (scale < 0.2)
			{
				scale = 0.2;
			}
			containerScale = scale;
		}
		
		private function onMouseWheel(e:Event):void
		{
			var scale:Number;
			scale = containerScale;
			if (e.delta > 0)
			{
				scale += 0.1;
			}else
			{
				scale-= 0.1;
				if (scale < 0.2)
				{
					scale = 0.2;
				}
			}
			containerScale = scale;
		}
		
		public function get containerScale():Number
		{
			return nodeContainer.scaleX;
		}
		
		public function set containerScale(value:Number):void
		{
			switchPivotCenter();
			nodeContainer.scale(value, value);
			_userChanged = true;
		}
		
		private function onActionBtn(type:String):void
		{
			switch(type)
			{
				case "save":
					debugger;
					trace("save:",_dataO.url, mapNodeData);
					
					event(Save);
					break;
			}
		}
		private function onRightDown(e:Event):void
		{
			if (nodeContainer.contains(e.target) && e.target != nodeContainer) return;
			if (e.touches && e.touches.length > 1)
			{
				nodeContainer.stopDrag();
				return;
			}
			nodeContainer.startDrag();
			_userChanged = true;
		}
		
		private function onRightUp(e:Event):void
		{
			nodeContainer.stopDrag();
			switchPivotCenter();
		}
		
		
		private var _tempPoint:Point = new Point();
		private function switchPivotCenter():void
		{
			_tempPoint.setTo(this.width * 0.5, this.height * 0.5);
			this.localToGlobal(_tempPoint);
			nodeContainer.globalToLocal(_tempPoint);
			var dX:Number, dY:Number;
			dX = _tempPoint.x - nodeContainer.pivotX;
			dY = _tempPoint.y - nodeContainer.pivotY;
			//trace("dX dY:",dX,dY);
			nodeContainer.pivot(_tempPoint.x, _tempPoint.y);
			nodeContainer.x += dX*containerScale;
			nodeContainer.y += dY*containerScale;
			//trace("switchPivotCenter:", _tempPoint.toString(), nodeContainer.pivotX, nodeContainer.pivotY, nodeContainer.x, nodeContainer.y);
			
			//_tempPoint.setTo(this.width * 0.5, this.height * 0.5);
			//this.localToGlobal(_tempPoint);
			//nodeContainer.globalToLocal(_tempPoint);
			//trace("adpt:", _tempPoint.toString());
			//nodeContainer.scaleX += 0.1;
			//nodeContainer.scaleY += 0.1;
		}
		private function onResize():void
		{
			var rec:Rectangle;
			rec = this.scrollRect || new Rectangle();
			rec.setTo(0, 0, this.width, this.height);
			this.scrollRect = rec;
			if (_userChanged) return;
			nodeContainer.pos(this.width * 0.5, this.height * 0.5);
			nodeContainer.pivot(0, 0);
			containerScale = 1;
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
			trace("Menu:", label);
			onItemAction(label, target);
		}
		
		private function onItemAction(action:String, target:MindMapItem):void
		{
			if (!MindMapEditor.isEditorMode) return;
			var parentNode:MindMapItem;
			parentNode = target.parentNode;
			switch(action)
			{
				case "freshLayout":
					freshLayout();
					break;
				case "新建子":
					target.nodeData.addChild(MindMapNodeData.createByLabel("new"));
					freshUI();
					break;
				case "新建同级":
					if (parentNode)
					{
						parentNode.nodeData.addChild(MindMapNodeData.createByLabel("new"));
						freshUI();
					}
					
					break;
				case "删除":
					if (parentNode)
					{
						if (target == _selectItem)
						{
							_selectItem = null;
						}
						parentNode.nodeData.removeChild(target.nodeData);
						freshUI();
					}
					break;
				case "up":
					if (parentNode)
					{
						parentNode.nodeData.moveChild(target.nodeData, -1);
						parentNode.updateNodesToDataOrder();
						freshLayout();
					}
					
					//freshUI();
					break;
				case "down":
					if (parentNode)
					{
						parentNode.nodeData.moveChild(target.nodeData, 1);
						parentNode.updateNodesToDataOrder();
						freshLayout();
					}
					
					//freshUI();
					break;
				case "select":
					if (target == _selectItem)
					{
						if (!target.isSelect())
						{
							_selectItem = null;
							return;
						}
					}
					if (!_selectItem)
					{
						_selectItem = target;
					}else
					{
						target.setSelect(false);
						_selectItem.setSelect(false);
						_selectItem.parentNode.removeChildNode(_selectItem);
						target.addChildNode(_selectItem,true);
						_selectItem = null;
						freshLayout();
					}
					break;
			}
		}
		
		private var _dataO:Object;
		public var mapNodeData:MindMapNodeData;
		public function setData(dataO:Object):void
		{
			this._dataO = dataO;
			_userChanged = false;
			onResize();
			mapNodeData = MindMapNodeData.createByObj(dataO.data||dataO,true);
			freshUI();
		}
		
		public function get data():Object
		{
			return _dataO;
		}
		
		private function clearPreItems():void
		{
			_selectItem = null;
			mindMapItems.length = 0;
			var i:int, len:int;
			len = nodeContainer.numChildren;
			var tChild:MindMapItem;
			for (i = 0; i < len; i++)
			{
				tChild = nodeContainer.getChildAt(i);
				if (tChild is MindMapItem)
				{
					tChild.recover();
				}
			}
			nodeContainer.removeChildren();
		}
		private var root:MindMapItem;
		private var mindMapItems:Array=[];
		private function freshUI():void
		{
			clearPreItems();
			
			root = createMapView(mapNodeData);
			root.pos(0, 0);
			//debugger;
			freshLayout();
		}
		
		private function freshLayout():void
		{
			if (!root) return;
			root.layoutAsCenter();
			nodeContainer.graphics.clear();
			root.drawConnections(nodeContainer);
			trace("data:",root.nodeData);
		}
		

		
		public function createMapView(nodeData:MindMapNodeData):MindMapNodeData
		{
			mindMapItems.length = 0;
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
			rst.onItemActionHandler = onItemActionHandler;
			mindMapItems.push(rst);
			return rst;
		}
	}

}