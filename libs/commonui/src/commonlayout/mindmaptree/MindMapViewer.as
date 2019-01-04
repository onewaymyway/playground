package commonlayout.mindmaptree 
{
	import laya.debug.tools.ClassTool;
	import laya.debug.tools.ObjectTools;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	import laya.ui.Box;
	import laya.utils.Pool;
	/**
	 * ...
	 * @author ww
	 */
	public class MindMapViewer extends Box
	{
		private var _typeClassDic:Object = { };
		public function regItemCreater(type:String, clz:Class):void
		{
			_typeClassDic[type] = clz;
		}
		public function regItemClassList(clzList:Array):void
		{
			var i:int, len:int;
			len = clzList.length;
			var tClz:Class;
			for (i = 0; i < len; i++)
			{
				tClz = clzList[i];
				regItemCreater(ClassTool.getClassName(tClz), tClz);
			}
		}
		public function createByType(type:String):*
		{
			var clz:Class;
			clz = _typeClassDic[type];
			return Pool.getItemByClass(ClassTool.getClassName(clz), clz);
			//return _typeClassDic[type]();
		}
		
		private var _layouter:MindMapTreeLayouter;
		private var nodeContainer:Box;
		private var _userChanged:Boolean = false;
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
		
		public function MindMapViewer() 
		{
			_layouter = new MindMapTreeLayouter();
			nodeContainer = new Box();
			nodeContainer.size(1, 1);
			nodeContainer.hitTestPrior = false;
			//nodeContainer.left = nodeContainer.right = nodeContainer.top = nodeContainer.bottom = 0;
			this.addChild(nodeContainer);
			this.on(Event.RESIZE, this, onResize);
			onResize();
		}
		
		private function onResize():void
		{
			var rec:Rectangle;
			rec = this.scrollRect || new Rectangle();
			rec.setTo(0, 0, this.width, this.height);
			//this.scrollRect = rec;
			if (_userChanged) return;
			nodeContainer.pos(this.width * 0.5, this.height * 0.5);
			nodeContainer.pivot(0, 0);
			containerScale = 1;
		}
		private var _dataO:Object;
		public function setData(dataO:Object):void
		{
			this._dataO = dataO;
			_userChanged = false;
			onResize();
			createMindMapItems();
		}
		
		private var _root:IMindMapTreeItem;
		public function createMindMapItems():void
		{
			clearPreItems();
			_root = createNodeByData(_dataO);
			_layouter.layoutAsCenter(_root, true);
			_layouter.drawConnections(_root, nodeContainer);
		}
		
		public static function addChildNode(parent:IMindMapTreeItem, child:IMindMapTreeItem):void
		{
			parent.childNodes.push(child);
			child.parentNode = parent;
		}
		
		public static function removeChildNode(parent:IMindMapTreeItem, child:IMindMapTreeItem):void
		{
			var childNodes:Array;
			childNodes = parent.childNodes;
			var i:int, len:int;
			len = childNodes.length;
			var tChild:IMindMapTreeItem;
			tChild = ObjectTools.removeFromArr(childNodes, child);
			if (tChild)
			{
				tChild.parentNode = null;
				ObjectTools.removeFromArr(parent.getData().childs, tChild.getData());
			}
		}
		private function createNodeByData(dataO:Object):*
		{
			if (!dataO) debugger;
			var tItem:IMindMapTreeItem;
			tItem = createByType(dataO.type);
			tItem.setData(dataO);
			var childs:Array;
			childs = dataO.childs;
			var i:int, len:int;
			len = childs.length;
			var tChild:IMindMapTreeItem;
			for (i = 0; i < len; i++)
			{
				tChild = createNodeByData(childs[i]);
				addChildNode(tItem, tChild);
			}
			
			nodeContainer.addChild(tItem as Sprite);
			return tItem;
		}
		private function clearPreItems():void
		{
			nodeContainer.graphics.clear();
			var i:int, len:int;
			len = nodeContainer.numChildren;
			var tChild:IMindMapTreeItem;
			for (i = len - 1; i >= 0; i--)
			{
				tChild = nodeContainer.getChildAt(i);
				if (tChild is IMindMapTreeItem)
				{
					tChild.recover();
				}
			}
			nodeContainer.removeChildren();
		}
		
	}

}