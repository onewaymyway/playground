package commonlayout.relationmap 
{
	import commonlayout.ItemCreater;
	import commonlayout.ItemDic;
	import laya.debug.tools.ClassTool;
	import laya.display.Graphics;
	import laya.renders.RenderContext;
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
			itemCreater = new ItemCreater();
			_itemDic = new ItemDic();
			_itemDic.itemCreater = itemCreater;
		}
		
		
		public var itemCreater:ItemCreater;
		private var _itemDic:ItemDic;
		private var _dataO:Object;
		
		public var lines:Array;
		
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
			_itemDic.createMapItems(_dataO.lines,"line");
			_itemDic.solveIDs();
			
			lines = _itemDic.getGroupItems("line");
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
		
		override public function render(context:RenderContext, x:Number, y:Number):void 
		{
			this.graphics.clear();
			if (lines)
			{
				var g:Graphics;
				g = this.graphics;
				var i:int, len:int;
				len = lines.length;
				var tLine:*;
				for (i = 0; i < len; i++)
				{
					tLine = lines[i];
					tLine.drawLineToGraphics(g);
				}
			}
			super.render(context, x, y);
		}
		
	}

}