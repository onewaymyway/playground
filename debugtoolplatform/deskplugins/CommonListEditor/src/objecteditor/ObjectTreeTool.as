package objecteditor 
{
	import laya.debug.uicomps.ContextMenu;
	import laya.debug.uicomps.ContextMenuItem;
	import laya.events.Event;
	/**
	 * ...
	 * @author ww
	 */
	public class ObjectTreeTool 
	{
		private var _menu:ContextMenu;
		public function ObjectTreeTool() 
		{
			
		}
		
		public static function init():void
		{
			_menu = ContextMenu.createMenuByArray(["Array","Object","Value"]);
			_menu.on(Event.SELECT, this, onEmunSelect);
		}
		private static var _tItem:*;
		private static function onEmunSelect(e:Event):void
		{
			var data:Object = ContextMenuItem(e.target).data;
			if (data is String)
			{
				var key:String;
				key = data as String;
				trace("menuDown:",key);
				switch (key)
				{
					case "Array": 
						if (_tItem && _tItem.addChildData)
						{
							_tItem.addChildData(ObjectDataTpl.createArrayData());
						}
						break;
					case "Object": 
						if (_tItem && _tItem.addChildData)
						{
							_tItem.addChildData(ObjectDataTpl.createObjectData());
						}
						break;
					case "Value": 
						if (_tItem && _tItem.addChildData)
						{
							_tItem.addChildData(ObjectDataTpl.createValueData());
						}
						break;
						
				
				}
			}
		}
		
		public static function showAddValueMenu(item:*):void
		{
			_tItem = item;
			_menu.show();
		}
		
	}

}