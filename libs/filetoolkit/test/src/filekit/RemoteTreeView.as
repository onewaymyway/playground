package filekit 
{
	import consts.Msgs;
	import filetoolkit.FileKit;
	import laya.debug.tools.Notice;
	import laya.debug.uicomps.ContextMenu;
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Component;
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
		private var _menu:ContextMenu;
		private var _mutiMenu:ContextMenu;
		private var _menuDir:ContextMenu;
		public function RemoteTreeView() 
		{
			
			//快捷工具栏
			opBox.on(Event.CLICK,this, onOpBoxClick);
			resTree.rootNode = null;
			resTree.renderHandler = new Handler(this, resTreeRender);
			resTree.on(Event.DOUBLE_CLICK, this, onResTreeDoubleClick);
			resTree.on(Event.RIGHT_CLICK, this,onResTreeRightMouseDown);
			
			var menu:ContextMenu = ContextMenu.createMenuByArray(["新建", "", "重命名", "删除","新建目录"]);
			menu.on(Event.SELECT, this,onEmunSelect);
			_menu = menu;
			
//			_menuDir=ContextMenu.createMenu("设置默认属性", "打开所在目录","重新打包", "", "重命名", "删除");
			_menuDir = ContextMenu.createMenuByArray(["新建", "", "重命名", "删除"]);
			
			_menuDir.on(Event.SELECT, this,onEmunSelect);
			_mutiMenu= ContextMenu.createMenuByArray(["删除"]);
			_mutiMenu.on(Event.SELECT, this,onEmunSelect);
		}
		
		
		/**获取当前目录*/
		private function get currDirectory():String {
			
			var directory:String = "";
			//trace("selectedItem:",pageTree.selectedItem );
			if (resTree.selectedItem != null)
			{
				var path:String = resTree.selectedItem.path;
				//trace("path:"+path);
				//return FileTools.getFileDir(path);
			}
			return directory;
		}
		
		private function onEmunSelect(dataO:Object):void
		{
			trace("onMenuSelect:", dataO);
			var label:String;
			label = dataO.target.data;
			trace("Menu:", label);
			switch (label) {
				case "设置默认属性": 

					break;
				case "打开所在目录": 
					//openCurrPath();
					break;
				case "重命名": 
					//checkRename();
					break;
				case "删除": 
					//deleteRes();
					break;
				case "新建目录": 
					//Notice.notify(PlatformEvents.OPEN_ADDDIR);
					break;
				
			}
			
		}
		
		private function createNew():void
		{
			
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
		
		private function onResTreeRightMouseDown(e:Event):void {
			trace("onResTreeRightMouseDown");
			//if(resTree.mList.selectItems&&resTree.mList.selectItems.length>1)
			//{
				//_mutiMenu.show();
				//return;
			//}
			var comp:Component = e.target as Component;
			if (comp && comp.dataSource) {
				resTree.selectedItem = comp.dataSource;
			}
			if(resTree.selectedItem&&resTree.selectedItem.isFolder)
			{
				_menuDir.show();
				return;
			}

			_menu.show();
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