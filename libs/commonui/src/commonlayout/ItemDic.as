package commonlayout 
{
	/**
	 * ...
	 * @author ww
	 */
	public class ItemDic 
	{
		public var idNodeDic:Object = { };
		public var unSolveList:Array;
		public var allNodeList:Array;
		
		public var groupDic:Object={};
		
		public var itemCreater:ItemCreater;
		public var curMax:int;
		
		public function ItemDic() 
		{
			
		}
		
		
		public function reset():void
		{
			idNodeDic = { };
			unSolveList = [];
			allNodeList = [];
			curMax = 1;
			groupDic = { };
		}
		
		public function getGroupItems(group:String):Array
		{
			if (!groupDic[group])
			{
				groupDic[group] = [];
			}
			return groupDic[group];
		}
		public function recoverItems():void
		{
			if (!allNodeList) return;
			var tItem:*;
			var i:int, len:int;
			len = allNodeList.length;
			for (i = 0; i < len; i++)
			{
				tItem = allNodeList[i];
				tItem.recover();
				tItem.removeSelf();
			}
			reset();
		}
		
		public function getItemByID(id:int):*
		{
			return idNodeDic[id];
		}
		
		public function solveIDs():void
		{
			var i:int, len:int;
			len = unSolveList.length;
			var tItem:Object;
			var tData:Object;
			curMax++;
			for (i = 0; i < len; i++)
			{
				tItem = unSolveList[i];
				tData = tItem.getData();
				tData.id = curMax;
				idNodeDic[tData.id] = tItem;
				curMax++;
			}
		}
		
		public function createMapItems(nodeDataList:Array,group:String=null):void
		{
			if (!nodeDataList) return;
			var nodeList:Array;	
			var i:int, len:int;
			var tItem:*;
			var tData:Object;
			var tID:int;
			
			var tGroupList:Array;
			if (group)
			{
				tGroupList = getGroupItems(group);
			}
		
				
			nodeList = nodeDataList;
			len = nodeList.length;
			
			for (i = 0; i < len; i++)
			{
				tData = nodeList[i];
				tItem = itemCreater.createByType(tData.type);
				allNodeList.push(tItem);
				if (tGroupList)
				{
					tGroupList.push(tItem);
				}
				tItem.itemDic = this;
				tItem.setData(tData);
				tID = tData.id;
				if (tID && !idNodeDic[tID])
				{
					if (tID > curMax)
					{
						curMax = tID;
					}
					idNodeDic[tID] = tItem;
				}else
				{
					unSolveList.push(tItem);
				}
			}
		}
	}

}