package filekit 
{
	import consts.Msgs;
	import filetoolkit.FileKit;
	import laya.debug.tools.Notice;
	import laya.events.Event;
	import laya.utils.Handler;
	import ui.deskplatform.RemoteTreeUI;
	/**
	 * ...
	 * @author ww
	 */
	public class RemoteTreeView extends RemoteTreeUI
	{
		public var fileKit:FileKit;
		public function RemoteTreeView() 
		{
			
			
			resTree.rootNode = null;
			
			resTree.on(Event.DOUBLE_CLICK, this, onResTreeDoubleClick);
		}
		
		private function onResTreeDoubleClick(e:Event):void {
//			trace("onResTreeDoubleClick");
			if (e.target.parent == resTree.list.content && resTree.selectedItem)
			{
				Notice.notify(Msgs.Open_File, [resTree.selectedItem]);
			}
		}
		public function refresh():void
		{
			fileKit.getFileList("",Handler.create(this,onGetFileList));
		}
		
		private function onGetFileList(dataO:Object):void
		{
			if (dataO.success)
			{
				dataO = dataO.data;
				var root:String;
				root = dataO;
				root.isOpen = true;
				resTree.rootNode = root;
				
			}
		}
		
	}

}