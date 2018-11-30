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
			_rootNode = value;
			list.array = getArray();
		}
		
		override protected function getArray():Array 
		{
			var arr:Array;
			arr = [];
			if(_rootNode)
			getDisplayItem(_rootNode, arr);
			return arr;
		}
		
		private function getDisplayItem(node:Object, arr:Array,depth:int=0):void
		{
			
			var childs:Array;
			childs = node.childs;
			node.hasChild = childs && childs.length;
			if (!node.isOpen) return;
			if (!childs) return;
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