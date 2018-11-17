package mindmap 
{
	import laya.events.Event;
	import ui.mindmap.MapItemUI;
	import laya.debug.uicomps.ContextMenu;
	/**
	 * ...
	 * @author ww
	 */
	public class MindMapItem extends MapItemUI 
	{
		public static var YSpace:Number=20;
		public static var XSpace:Number = 20;
		public var nodeData:MindMapNodeData;
		
		public var childNodes:Array = [];
		private var _menu:ContextMenu;
		public function MindMapItem() 
		{
			_menu = ContextMenu.createMenuByArray(["新建同级"]);
			_menu.on(Event.SELECT, this, onSelect);
			this.on(Event.RIGHT_MOUSE_UP, this, onRightMouseUp);
		}
		private function onSelect(dataO:Object):void
		{
			trace("onMenuSelect:", dataO);
			var label:String;
			label = dataO.target.data;
			trace("Menu:",label);
			switch(label)
			{
				case "":
					break;
			}
		}
		
		private function onRightMouseUp():void
		{
			trace("mindmapitem rightmouseup");
			_menu.show();
		}
		
		public function freshUI():void
		{
			text.text = nodeData.label;
		}
		
		public function get ID():int
		{
			return nodeData.id;
		}
		
		public function getItemHeight(childNodes:Array):Number
		{
			if (!childNodes) childNodes = this.childNodes;
			if (!childNodes || !childNodes.length) return this.height;
			var i:int, len:int;
			len = childNodes.length;
			var tChild:MindMapItem;
			var tHeight:Number = 0;
			var totalHeight:Number;
			totalHeight = 0;
			for (i = 0; i < len; i++)
			{
				tChild = childNodes[i];
				tHeight = tChild.getItemHeight();
				totalHeight += tHeight;
			}
			totalHeight += YSpace * (len - 1);
			return totalHeight;
		}
		
		public function setPos(x:Number,y:Number,isRight:Boolean=true):void
		{
			layoutChilds(this.childNodes, x, y, isRight);
		}
		
		public function layoutAsCenter():void
		{
			if (childNodes.length <= 1)
			{
				layoutChilds(childNodes, this.x, this.y, true);
				return;
			}
			var leftChilds:Array;
			var rightChilds:Array;
			var mid:int;
			mid = Math.round(childNodes.length / 2);
			leftChilds = [];
			rightChilds = [];
			var i:int, len:int;
			len = childNodes.length;
			for (i = 0; i < len; i++)
			{
				if (i <= mid)
				{
					leftChilds.push(childNodes[i]);
				}else
				{
					rightChilds.push(childNodes[i]);
				}
			}
			
			layoutChilds(leftChilds, this.x, this.y, false);
			layoutChilds(rightChilds, this.x, this.y, true);
		}
		
		public function layoutChilds(childNodes:Array,x:Number, y:Number, isRight:Boolean = true):void
		{
			var itemHeight:Number;
			itemHeight = getItemHeight(childNodes);
			this.pos(x, y + itemHeight * 0.5);
			var i:int, len:int;
			len = childNodes.length;
			var childX:Number;
			if (isRight)
			{
				childX = x + this.width + XSpace;
			}else
			{
				childX = x - this.width - XSpace;
			}
			
			var tChild:MindMapItem;
			var tY:Number;
			tY = y;
			for (i = 0; i < len; i++)
			{
				tChild = childNodes[i];
				tChild.setPos(childX, tY,isRight);
				tY += tChild.height + YSpace;
			}
		}
		
		
		
		
		public function addChildNode(node:MindMapItem):void
		{
			childNodes.push(node);
			nodeData.addChild(node.nodeData);
		}
		
		public function removeChildNode(node:MindMapItem):void
		{
			var i:int, len:int;
			len = childNodes.length;
			var tChild:MindMapItem;
			for (i = 0; i < len; i++)
			{
				tChild = childNodes.length;
				if (tChild.ID == node.ID)
				{
					childNodes.splice(i,1);
					nodeData.removeChild(node.nodeData);
					return;
				}
			}
		}
		
		public static function createByData(mindMapNodeData:MindMapNodeData,autoBuildTree:Boolean=false):MindMapItem
		{
			var rst:MindMapItem;
			rst = new MindMapItem();
			rst.nodeData = mindMapNodeData;
			rst.freshUI();
			return rst;
		}
	}

}