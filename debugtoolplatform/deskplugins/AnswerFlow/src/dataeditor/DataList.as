package dataeditor 
{
	import commontools.uitools.UIGroupControl;
	import laya.debug.tools.resizer.DisResizer;
	import laya.events.Event;
	import laya.utils.Handler;
	import ui.dataeditor.DataListUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class DataList extends DataListUI 
	{
		private var itemActionHandler:Handler;
		public var isMin:Boolean = false;
		public var itemsControl:UIGroupControl;
		public function DataList() 
		{
			itemsControl = new UIGroupControl();
			itemsControl.items = [addBtn,itemList];
			itemActionHandler = new Handler(this.onItemAction);
			addBtn.on(Event.CLICK, this, onAddBtn);
			titleTxt.on(Event.DOUBLE_CLICK, this, onTitleDoubleClick);
			itemList.renderHandler = new Handler(this, itemListItemRender);
			
			
			this.on(Event.MOUSE_DOWN, this, onMouseDown);
		}
		
		private function onMouseDown():void
		{
			DisResizer.setUp(this);
		}
		
		public function switchState():void
		{
			isMin = !isMin;
			updateState();
		}
		
		private function updateState():void
		{
			if (isMin)
			{
				itemsControl.removeSelf();
				this.width = titleTxt.width + 5;
				this.height = titleTxt.height + 5;
			}else
			{
				this.width = dataO.width;
				this.height = dataO.height;
				
			}
		}
		
		private function onTitleDoubleClick():void
		{
			switchState();
		}
		private function onAddBtn():void
		{
			
		}
		
		private function onItemAction(type:String, item:DataItem):void
		{
			switch(type)
			{
				
			}
		}
		
		private var dataO:Object;
		/**
		 * {
		 *   "title":"title",
		 *   "type":"type",
		 *   "props":
			 * {
			 *    "isMin":false,
			 *    "width":400,
			 * 	  "height":400
			 * },
			 * "itemtpl":{}
		 * 	
		 * }
		 * @param	dataO
		 */
		public function setData(dataO:Object):void
		{
			DataTpl.adptDataListData(dataO);
			this.dataO = dataO;
		}
		
		private function itemListItemRender(cell:DataItem, index:int):void
		{
			//var label:Label;
			//label = cell.getChildByName("label");
			//var dataO:Object;
			//dataO = cell.dataSource;
			//label.text = dataO;
			cell.actionHandler = itemActionHandler;
			cell.initByData(cell.dataSource);
		}
		
	}

}