///////////////////////////////////////////////////////////
//  NodeTree.as
//  Macromedia ActionScript Implementation of the Class NodeTree
//  Created on:      2015-12-25 下午2:21:31
//  Original author: ww
///////////////////////////////////////////////////////////

package extendui.ui
{
	import laya.ui.Box;
	import laya.ui.Tree;
	
	
	/**
	 * 节点树基类
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2015-12-25 下午2:21:31
	 */
	public class NodeTree extends Tree
	{
		public static const TreeSpaceLeft:int=15;
		public function NodeTree()
		{
			super();
			spaceLeft = TreeSpaceLeft;
//			list.spaceY = 2;
		}
		public function refreshList():void {
			_list.array = getArray();
		}
		
		public function selectByCompId(compId:int):void
		{
			var arr:Array;
			arr=list.array;
			var i:int,len:int;
			len=arr.length;
			var tItem:Object;
			for(i=0;i<len;i++)
			{
				tItem=arr[i];
				if(tItem.compId==compId)
				{
					list.selectedIndex=i;
					return;
				}
			}
		}
	
		public var arrFilterFun:Function;

		
		public function getParentIndex(item:Object):int
		{
			if(!_treeData)
			{
			   return getIndexByData(item.nodeParent);
			}
			
			return -1;
		}
		
		private function getIndexByData(dis:Object):int {
			var dataList:Array;
			dataList = list.array;
			var i:int, len:int;
			len = dataList.length;
			for (i = 0; i < len; i++) {
				if (dataList[i] == dis) {
					return i;
				}
			}
			return -1;
		}

		
		
	}
}