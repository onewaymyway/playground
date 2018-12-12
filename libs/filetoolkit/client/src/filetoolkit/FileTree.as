package filetoolkit 
{
	import laya.ui.Tree;
	/**
	 * ...
	 * @author ww
	 */
	public class FileTree extends Tree
	{
		
		public function FileTree() 
		{
			
		}
		
		private var _rootNode:Object;
		public function set rootNode(value:Object):void
		{
			recoverState(value, _rootNode);
			_rootNode = value;
			
			list.array = getArray();
		}
		
		public function recoverState(newTree:Object,oldTree:Object):void
		{
			if (!newTree || !oldTree) return;
			var newDic:Object;
			newDic = buildTreeLabelDic(newTree);
			var oldDic:Object;
			oldDic = buildTreeLabelDic(oldTree);
			var key:String;
			
			for (key in newDic)
			{
				if (newDic[key] && newDic[key].isFolder && oldDic[key])
				{
					newDic[key].isOpen = oldDic[key].isOpen;
				}
			}
		}
		
		public static function buildTreeLabelDic(node:Object, parentLabel:String=null, rstObj:Object=null):Object
		{
			if (!rstObj)
			{
				rstObj = { };
			}
			if (!parentLabel) parentLabel = "";
			var tLabel:String;
			tLabel = node.label;
			tLabel = parentLabel + "," + tLabel;
			rstObj[tLabel] = node;
			var i:int, len:int;
			var childs:Array;
			childs = node.childs;
			if (childs)
			{
				len = childs.length;
				for (i = 0; i < len; i++)
				{
					buildTreeLabelDic(childs[i], tLabel, rstObj);
				}
			}
			return rstObj;
		}
		
		public function get rootNode():Object
		{
			return _rootNode;
		}
		
		override protected function getArray():Array 
		{
			var arr:Array;
			arr = [];
			if(_rootNode)
			getDisplayItem(_rootNode, arr);
			return arr;
		}
		
		public var childSortFun:Function;
		private function getDisplayItem(node:Object, arr:Array,depth:int=0):void
		{
			
			var childs:Array;
			childs = node.childs;
			node.hasChild = childs && childs.length;
			if (!node.isOpen) return;
			if (!childs) return;
			if (childSortFun != null && childs.length)
			{
				childs.sort(childSortFun);
			}
			var i:int, len:int;
			len = childs.length;
			var tChild:Object;
			for (i = 0; i < len; i++)
			{
				tChild = childs[i];
				tChild.x = _spaceLeft * depth;
				arr.push(tChild);
				if (tChild.isFolder)
				{
					
					
					getDisplayItem(tChild, arr,depth+1);
				}else
				{
					
				}
			}
			
		}
	}

}