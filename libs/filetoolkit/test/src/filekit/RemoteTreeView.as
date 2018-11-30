package filekit 
{
	import consts.Msgs;
	import filetoolkit.FileKit;
	import laya.debug.tools.Notice;
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Image;
	import laya.ui.Label;
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
			
			//快捷工具栏
			opBox.on(Event.CLICK,this, onOpBoxClick);
			resTree.rootNode = null;
			resTree.renderHandler = new Handler(this, resTreeRender);
			resTree.on(Event.DOUBLE_CLICK, this, onResTreeDoubleClick);
		}
		private function onOpBoxClick(e:Event):void {
			var btn:Button = e.target as Button;
			if (btn) {
				switch (btn.name) {

					case "setPropBtn": 
						LoginView.instance.start();
						break;
					case "refreshBtn": 
						refresh();
						break;
				}
			}
		}
		
		private function resTreeRender(cell:Box, index:int):void {
			var item:Object = cell.dataSource;
//			trace("resTreeRender");
			var compStr:String;
			if (item) {
				var icon:Image = cell.getChildByName("icon") as Image;
				var isDirectory:Boolean = item.child || item.isFolder;
				var label:Label = cell.getChildByName("label") as Label;
				//icon.width=StyleConsts.DisplayIconWidth;
				//icon.height=StyleConsts.DisplayIconHeight;

				if (isDirectory) {
//					icon.skin = "comp/folder.png";
					if(item.isOpen)
					{
						icon.skin = "view/folder_open.png";
					}else
					{
						icon.skin = "view/folder_close.png";
					}
					//label.color=StyleConsts.TreeFolderColor;
					//compStr=FileManager.adptToCommonUrl(FileManager.getResRelativePath(item.path));

				} else {
					
					//label.text = item.label;
					
					//compStr=FileManager.adptToCommonUrl(FileManager.getResRelativePath(item.path));


					//label.color = StyleConsts.TreeItemColor;
					icon.skin = "view/ui.png";



				}
			}
		}
		private function onResTreeDoubleClick(e:Event):void {
//			trace("onResTreeDoubleClick");
			if (e.target.parent == resTree.list.content && resTree.selectedItem)
			{
				if (resTree.selectedItem.isFolder) return;
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