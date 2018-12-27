package commonlayout.mindmaptree 
{
	import laya.display.Sprite;
	/**
	 * ...
	 * @author ww
	 */
	public class MindMapTreeLayouter 
	{
		
		public function MindMapTreeLayouter() 
		{
			
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
		}
		
		public function drawConnections(treeItem:IMindMapTreeItem,sprite:Sprite):void
		{
			var childNodes:Array;
			childNodes = treeItem.childNodes;
			var i:int, len:int;
			len = childNodes.length;
			var tChild:IMindMapTreeItem;
			for (i = 0; i < len; i++)
			{
				tChild = childNodes[i];
				drawConnections(tChild,sprite);
				drawOneLine(treeItem as Sprite, tChild as Sprite, sprite);
			}
		}
		
		public function getItemHeight(tree:IMindMapTreeItem,childNodes:Array=null):Number
		{
			if (!childNodes) childNodes = tree.childNodes;
			if (!childNodes || !childNodes.length) return tree.height;
			var i:int, len:int;
			len = childNodes.length;
			var tChild:IMindMapTreeItem;
			var tHeight:Number = 0;
			var totalHeight:Number;
			totalHeight = 0;
			for (i = 0; i < len; i++)
			{
				tChild = childNodes[i];
				tHeight = getItemHeight(tChild);
				totalHeight += tHeight;
			}
			totalHeight += YSpace * (len - 1);
			return totalHeight;
		}
		
		public function getItemWidth(tree:IMindMapTreeItem,childNodes:Array = null):Number
		{
			if (!childNodes) childNodes = tree.childNodes;
			if (!childNodes || !childNodes.length) return 0;
			var maxWidth:Number = 0;
			var i:int, len:int;
			len = childNodes.length;
			var tChild:IMindMapTreeItem;

			for (i = 0; i < len; i++)
			{
				tChild = childNodes[i];
				maxWidth = Math.max(maxWidth, tChild.width);

			}

			return maxWidth;
		}
		
		public function setPos(tree:IMindMapTreeItem,x:Number,y:Number,isRight:Boolean=true):void
		{
			layoutChilds(tree,tree.childNodes, x, y, isRight);
		}
		
		public function layoutAsCenter(tree:IMindMapTreeItem,onlyRight:Boolean=false):void
		{
			var childNodes:Array;
			childNodes = tree.childNodes;
			if (onlyRight||childNodes.length <= 1)
			{
				layoutChilds(tree,childNodes, tree.x, tree.y, true,true);
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
			
			layoutChilds(tree,leftChilds, tree.x, tree.y, false,true);
			layoutChilds(tree,rightChilds, tree.x, tree.y, true,true);
		}
		
		public var XSpace:Number = 10;
		public var YSpace:Number = 10;
		public function layoutChilds(parent:IMindMapTreeItem,childNodes:Array,x:Number, y:Number, isRight:Boolean = true,lockPos:Boolean=false):void
		{
			var itemHeight:Number;
			itemHeight = getItemHeight(parent,childNodes);
			var itemWidth:Number;
			itemWidth = getItemWidth(parent,childNodes);
			itemWidth = Math.max(parent.width, itemWidth);
			if (!lockPos)
			{
				parent.setLayoutPos(x, y + itemHeight * 0.5);
			}else
			{
				parent.setLayoutPos(x, y);
			}
			
			var i:int, len:int;
			len = childNodes.length;
			var childX:Number;
			if (isRight)
			{
				childX = x + parent.width + XSpace;
			}else
			{
				childX = x - itemWidth - XSpace;
			}
			
			var tChild:IMindMapTreeItem;
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
				childItemHeight = getItemHeight(tChild);
				//tChild.setPos(childX, tY, isRight);
				if (isRight)
				{
					setPos(tChild,childX, tY, isRight);
				}else
				{
					setPos(tChild,x-tChild.width-XSpace, tY,isRight);
				}
				
				tY += childItemHeight + YSpace;
			}
		}
	}

}