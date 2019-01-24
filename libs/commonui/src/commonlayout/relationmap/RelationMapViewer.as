package commonlayout.relationmap 
{
	import commonlayout.ItemCreater;
	import commonlayout.ItemDic;
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
			_itemDic = new ItemDic();
		}
		
		
		private var _itemCreater:ItemCreater;
		private var _itemDic:ItemDic;
		private var _dataO:Object;
		public function setData(dataO:Object):void
		{
			this._dataO = dataO;
			createMapItems();
		}
		
		private function onCreateItem(item:RelationMapItemBase):void
		{
			item.itemDic = _itemDic;
		}
		private function createMapItems():void
		{
			_itemDic.recoverItems();
			if (!_dataO.nodes) _dataO.nodes = [];
			if (!_dataO.lines) _dataO.lines = [];
			_itemDic.reset();
			_itemDic.createMapItems(_dataO.nodes);
			_itemDic.createMapItems(_dataO.lines);
			_itemDic.solveIDs();
			
			var nodes:Array;
			nodes = _itemDic.allNodeList;
			var i:int, len:int;
			len = nodes.length;
			var tItem:RelationMapItemBase;
			for (i = 0; i < len; i++)
			{
				tItem = nodes[i];
				addChild(tItem);
			}
		}
		
	}

}