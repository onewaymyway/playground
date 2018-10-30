package view 
{
	import laya.events.Event;
	import platform.tools.Notice;
	import platform.tools.Notices;
	import ui.deskplatform.MainViewItemUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class MainViewItem extends MainViewItemUI 
	{
		
		public function MainViewItem() 
		{
			this.on(Event.CLICK, this, onClick);
		}
		
		private var _dataO:Object;
		public function initByData(dataO:Object):void
		{
			_dataO = dataO;
			this.label.text = dataO.name;
		}
		
		private function onClick():void
		{
			trace("onClick:", _dataO);
			Notice.notify(Notices.OPEN_PLUGIN, _dataO.path);
		}
	}

}