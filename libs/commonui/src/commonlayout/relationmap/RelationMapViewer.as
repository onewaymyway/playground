package commonlayout.relationmap 
{
	import commonlayout.ItemCreater;
	import laya.debug.tools.ClassTool;
	import laya.ui.Box;
	import laya.utils.Pool;
	/**
	 * ...
	 * @author ww
	 */
	public class RelationMapViewer extends Box
	{
		
		public function RelationMapViewer() 
		{
			_itemCreater = new ItemCreater();
		}
		
		
		private var _itemCreater:ItemCreater;
		private var _dataO:Object;
		public function setData(dataO:Object):void
		{
			this._dataO = dataO;
			createMapItems();
		}
		
		private function createMapItems():void
		{
			if (!_dataO.nodes) _dataO.nodes = [];
			if (!_dataO.lines) _dataO.lines = [];
			
			var idNodeDic:Object = { };
			var unSolveList:Array;
			unSolveList = [];
			var nodeList:Array;
			nodeList = _dataO.nodes;
			var i:int, len:int;
			len = nodeList.length;
			var tItem:RelationMapItemBase;
			var tData:Object;
			var tID:int;
			var curMax:int;
			curMax = 1;
			for (i = 0; i < len; i++)
			{
				tData = nodeList[i];
				tItem = _itemCreater.createByType(tData.type);
				tID = tData.id;
				if (tID && !idNodeDic[tID])
				{
					if (tID > curMax)
					{
						curMax = tID;
					}
					idNodeDic[tID] = tItem;
				}
			}
		}
		
	}

}