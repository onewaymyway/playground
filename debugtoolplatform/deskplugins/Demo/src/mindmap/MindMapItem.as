package mindmap 
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.utils.Handler;
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
		private var onMenuSelectHandler:Handler;
		public function MindMapItem() 
		{
			_menu = ContextMenu.createMenuByArray(["新建同级","新建子"]);
			_menu.on(Event.SELECT, this, onSelect);
			this.on(Event.RIGHT_MOUSE_UP, this, onRightMouseUp);
			text.editable = true;
			text.on(Event.BLUR, this, onInputBlur);
			this.on(Event.MOUSE_DOWN, this, onDoubleClick);
		}
		private function onDoubleClick():void
		{
			//text.editable = true;
			text.focus = true;
		}
		
		private function onInputBlur():void
		{
			//text.editable = false;
			nodeData.label = text.text;
			freshUI();
		}
		private function onSelect(dataO:Object):void
		{
			if (onMenuSelectHandler)
			{
				onMenuSelectHandler.runWith([dataO,this]);
			}
			trace("onMenuSelect:", dataO);
			var label:String;
			label = dataO.target.data;
			trace("Menu:",label);
			
		}
		
		private function onRightMouseUp():void
		{
			trace("mindmapitem rightmouseup");
			_menu.show();
		}
		
		public function freshUI():void
		{
			text.text = nodeData.label||"";
		}
		
		public function drawConnections(sprite:Sprite):void
		{
			var i:int, len:int;
			len = childNodes.length;
			var tChild:MindMapItem;
			for (i = 0; i < len; i++)
			{
				tChild = childNodes[i];
				tChild.drawConnections(sprite);
				drawOneLine(this, tChild, sprite);
			}
		}
		
		public function drawOneLine(parentItem:Sprite, childItem:Sprite,sprite:Sprite):void
		{
			var leftItem:Sprite;
			var rightItem:Sprite;
			if (parentItem.x < childItem.x)
			{
				leftItem = parentItem;
				rightItem = childItem;
			}else
			{
				leftItem = childItem;
				rightItem = parentItem;
			}
			sprite.graphics.drawLine(leftItem.x + leftItem.width, leftItem.y, rightItem.x, rightItem.y,"#ff0000");
		}
		
		public function get ID():int
		{
			return nodeData.id;
		}
		
		public function getItemHeight(childNodes:Array=null):Number
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
			mid = Math.floor(childNodes.length / 2);
			leftChilds = [];
			rightChilds = [];
			var i:int, len:int;
			len = childNodes.length;
			for (i = 0; i < len; i++)
			{
				if (i < mid)
				{
					leftChilds.push(childNodes[i]);
				}else
				{
					rightChilds.push(childNodes[i]);
				}
			}
			
			layoutChilds(leftChilds, this.x, this.y, false,true);
			layoutChilds(rightChilds, this.x, this.y, true,true);
		}
		
		public function layoutChilds(childNodes:Array,x:Number, y:Number, isRight:Boolean = true,lockPos:Boolean=false):void
		{
			var itemHeight:Number;
			itemHeight = getItemHeight(childNodes);
			if (!lockPos)
			{
				this.pos(x, y + itemHeight * 0.5);
			}else
			{
				this.pos(x, y);
			}
			
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
			if (lockPos)
			{
				tY -= itemHeight * 0.5;
			}
			var childItemHeight:Number;
			for (i = 0; i < len; i++)
			{
				tChild = childNodes[i];
				childItemHeight = tChild.getItemHeight();
				tChild.setPos(childX, tY,isRight);
				tY += childItemHeight + YSpace;
			}
		}
		
		
		
		
		public function addChildNode(node:MindMapItem,addToData:Boolean=false):void
		{
			childNodes.push(node);
			if(addToData)
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