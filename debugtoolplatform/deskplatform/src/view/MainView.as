package view 
{
	import laya.utils.Handler;
	import nodetools.devices.FileManager;
	import nodetools.devices.FileTools;
	import platform.extenddisplay.IFrameSprite;
	import platform.tools.Notice;
	import platform.tools.Notices;
	import ui.deskplatform.MainViewUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class MainView extends MainViewUI 
	{
		private var iframeSprite:IFrameSprite;
		public function MainView() 
		{
			iframeSprite = new IFrameSprite();
			iframeSprite.left = iframeSprite.right = iframeSprite.top = iframeSprite.bottom = 0;
			itemList.renderHandler = new Handler(this, itemRender);
			init();
			Notice.listen(Notices.OPEN_PLUGIN, this, onOpenPlugin);
		}
		
		private function onOpenPlugin(path:String):void
		{
			trace("onOpenPlugin:",path);
			iframeSprite.setUrl(path + "/index.html");
			contentBox.addChild(iframeSprite);
		}
		private function init():void
		{
			var pluginFolder:String;
			pluginFolder = FileManager.getAppPath("plugins/");
			trace("pluginFolder:", pluginFolder);
			if (!FileManager.exists(pluginFolder)) return;
			var folders:Array;
			folders = FileTools.getDirChildDirs(pluginFolder);
			var i:int, len:int;
			len = folders.length;
			
			var items:Array;
			items = [];
			var tItem:Object;
			var tFile:String;
			for (i = 0; i < len; i++)
			{
				tFile = folders[i];
				trace("Plugin:", folders[i]);
				tItem = { };
				tItem.name = FileTools.getFileName(tFile);
				tItem.path = tFile;
				items.push(tItem);
			} 
			itemList.array = items;
		}
		
		private function itemRender(cell:*, index:int):void
		{
			(cell as MainViewItem).initByData(cell.dataSource);
		}
		
	}

}