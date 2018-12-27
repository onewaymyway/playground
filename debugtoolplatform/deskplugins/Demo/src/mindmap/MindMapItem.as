package mindmap 
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.utils.Browser;
	import laya.utils.Handler;
	import laya.utils.Pool;
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
		public var onMenuSelectHandler:Handler;
		public var onItemActionHandler:Handler;
		public var parentNode:MindMapItem;
		public function MindMapItem() 
		{
			this.hitTestPrior = false;
			_menu = ContextMenu.createMenuByArray(["新建同级","新建子","删除"]);
			_menu.on(Event.SELECT, this, onSelect);
			this.on(Event.RIGHT_MOUSE_UP, this, onRightMouseUp);
			text.editable = true;
			text.mouseEnabled = false;
			text.on(Event.BLUR, this, onInputBlur);
			this.on(Event.DOUBLE_CLICK, this, onDoubleClick);
			downBtn.on(Event.CLICK, this, onBtnAction, ["down"]);
			upBtn.on(Event.CLICK, this, onBtnAction, ["up"]);
			selectBtn.on(Event.CLICK, this, onBtnAction, ["select"]);
			selectBtn.selected = false;
			this.on(Event.MOUSE_DOWN, this, onMyMouseDown);
			this.on(Event.MOUSE_UP, this, onMyMouseUp);
			
		}
		
		private var _downTime:Number;
		
		private function onMyMouseDown():void
		{
			_downTime = Browser.now();
		}
		
		private function onMyMouseUp():void
		{
			if (Browser.now() - _downTime > 500)
			{
				onRightMouseUp();
			}
		}
		
		public function setSelect(isSelect:Boolean):void
		{
			selectBtn.selected = isSelect;
		}
		public function isSelect():Boolean
		{
			return selectBtn.selected;
		}
		public function reset():void
		{
			parentNode = null;
			childNodes = [];
			selectBtn.selected = false;
		}
		public function updateNodesToDataOrder():void
		{
			childNodes.sort(sortChildFun.bind(this));
		}
		
		private function sortChildFun(nodeA:MindMapItem, nodeB:MindMapItem):int
		{
			var childs:Array;
			childs = nodeData.childs;
			return childs.indexOf(nodeA.nodeData) - childs.indexOf(nodeB.nodeData);
		}
		private function onBtnAction(action:String):void
		{
			if (onItemActionHandler)
			{
				onItemActionHandler.runWith([action,this]);
			}
		}
		private function onDoubleClick():void
		{
			text.editable = true;
			
			text.focus = true;
		}
		
		private function onInputBlur():void
		{
			text.editable = false;
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
			if (!MindMapEditor.isEditorMode) return;
			_menu.show();
		}
		
		public function freshUI():void
		{
			text.editable = MindMapEditor.isEditorMode;
			text.text = nodeData.label || "";
			text.width = 400;
			text.textField.typeset();
			text.width = text.textField.textWidth + 20;
			this.width = text.textField.textWidth + 20 + 33;
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
			var isRight:Boolean;
			if (parentItem.x < childItem.x)
			{
				leftItem = parentItem;
				rightItem = childItem;
				isRight = true;
			}else
			{
				leftItem = childItem;
				rightItem = parentItem;
				isRight = false;
			}
			var lx:Number, ly:Number;
			var rx:Number, ry:Number;
			lx = leftItem.x + leftItem.width;
			ly = leftItem.y;
			rx = rightItem.x;
			ry = rightItem.y;
			//sprite.graphics.drawCurves(0, 0, [lx, ly, (lx + rx) / 2, (ly + ry) / 2, rx, ry], "#ff0000");
			if (isRight)
			{
				sprite.graphics.drawCurves(0, 0, [lx,ly,(lx+rx)/2,ry,rx,ry], "#ff0000");
			}else
			{
				sprite.graphics.drawCurves(0, 0, [lx,ly,(lx+rx)/2,ly,rx,ry], "#ff0000");
			}
			
			//sprite.graphics.drawLine(leftItem.x + leftItem.width, leftItem.y, rightItem.x, rightItem.y,"#ff0000");
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
		
		public function getItemWidth(childNodes:Array = null):Number
		{
			if (!childNodes) childNodes = this.childNodes;
			if (!childNodes || !childNodes.length) return 0;
			var maxWidth:Number = 0;
			var i:int, len:int;
			len = childNodes.length;
			var tChild:MindMapItem;

			for (i = 0; i < len; i++)
			{
				tChild = childNodes[i];
				maxWidth = Math.max(maxWidth, tChild.width);

			}

			return maxWidth;
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
			var itemWidth:Number;
			itemWidth = getItemWidth(childNodes);
			itemWidth = Math.max(this.width, itemWidth);
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
				childX = x - itemWidth - XSpace;
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
				//tChild.setPos(childX, tY, isRight);
				if (isRight)
				{
					tChild.setPos(childX, tY, isRight);
				}else
				{
					tChild.setPos(x-tChild.width-XSpace, tY,isRight);
				}
				
				tY += childItemHeight + YSpace;
			}
		}
		
		
		
		
		public function addChildNode(node:MindMapItem,addToData:Boolean=false):void
		{
			childNodes.push(node);
			node.parentNode = this;
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
				tChild = childNodes[i];
				if (tChild == node)
				{
					childNodes.splice(i, 1);
					node.parentNode = null;
					nodeData.removeChild(node.nodeData);
					return;
				}
			}
		}
		
		public static function createByData(mindMapNodeData:MindMapNodeData,autoBuildTree:Boolean=false):MindMapItem
		{
			var rst:MindMapItem;
			rst = create();
			rst.nodeData = mindMapNodeData;
			rst.freshUI();
			return rst;
		}
		
		public static function create():MindMapItem
		{
			return Pool.getItemByClass("MindMapItem",MindMapItem );
		}
		public function recover():void
		{
			reset();
			Pool.recover("MindMapItem", this);
		}
	}

}