package relationmap 
{
	import commonlayout.AutoScrollRecBox;
	import commonlayout.relationmap.RelationMapViewer;
	import laya.events.Event;
	import laya.maths.Point;
	import ui.relationmap.RelationMapEditorUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class RelationMapEditor extends RelationMapEditorUI 
	{
		public var editorBox:AutoScrollRecBox;
		public var mapViewer:RelationMapViewer;
		public function RelationMapEditor() 
		{
			optionTab.selectedIndex = 0;
			saveBtn.on(Event.CLICK, this, onSaveBtn);
			optionTab.on(Event.CHANGE, this, onOpTypeChange);
			editorBox = new AutoScrollRecBox();
			container.addChild(editorBox);
			
			mapViewer = new RelationMapViewer();
			editorBox.addChild(mapViewer);
			
			mapViewer.itemCreater.regItemClassList([RelationLine,RelationNode]);
			
			mapViewer.hitTestPrior = false;
			mapViewer.size(1, 1);
			
			editorBox.left = editorBox.right = editorBox.top = editorBox.bottom = 1;
			editorBox.on(Event.CLICK, this, onMapMouseDown);
			
			editorBox.on("ItemClicked", this, onItemClick);
		}
		
		
		private function onItemClick(target:*):void
		{
			if (target is RelationNode)
			{
				if (isLineMode())
				{
					var tNode:RelationNode;
					tNode = target;
					if (!_lineStart||tNode.getID()==_lineStart.getID())
					{
						_lineStart = tNode;
					}else
					if(!_lineEnd)
					{
						_lineEnd = tNode;
						onAddLineComplete();
					}
				}
			}
		}
		private function onMapMouseDown(e:Event):void
		{
			if (e.target == editorBox)
			{
				handleMouseDownAdd();
			}
			
		}
		
		private function onAddLineComplete():void
		{
			var tData:Object;
			tData = { };
			tData.type = "RelationLine";
			var tProp:Object;
			tProp = { start:_lineStart.getID(), end:_lineEnd.getID() };
			tProp.startX = _lineStart.x;
			tProp.startY = _lineStart.y;
			tProp.endX = _lineEnd.x;
			tProp.endY = _lineEnd.y;
			tData.props = tProp;
			this.dataO.lines.push(tData);
			resetLineInfo();
			freshUI();
		}
		private function handleMouseDownAdd():void
		{
			if (isOperateMode()) return;
			
			var tPos:Point;
			tPos = mapViewer.getMousePoint();
			if (isNodeMode())
			{
				addNode(tPos.x, tPos.y);
			}
			
		}
		
		private function addNode(x:Number, y:Number):void
		{
			var tData:Object;
			tData = { };
			tData.type = "RelationNode";
			tData.props = { x:x, y:y };
			this.dataO.nodes.push(tData);
			freshUI();
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
			resetLineInfo();
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
		
		private var _tLine:RelationLine;
		private var _lineStart:RelationNode;
		private var _lineEnd:RelationNode;
		private function resetLineInfo():void
		{
			_tLine = null;
			_lineStart = null;
			_lineEnd = null;
		}
		public function freshUI():void
		{
			resetLineInfo();
			mapViewer.setData(dataO);
		}
	}

}