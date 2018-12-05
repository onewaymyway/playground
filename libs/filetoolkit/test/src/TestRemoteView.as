package  
{
	import consts.Msgs;
	import electrontools.MessageManager;
	import extendui.ui.PixelRatioBox;
	import filekit.RemoteTreeView;
	import filetoolkit.FileKit;
	import filetoolkit.FileTree;
	import laya.debug.tools.Notice;
	import laya.debug.uicomps.ContextMenu;
	import laya.debug.uicomps.ContextMenuItem;
	import laya.display.Sprite;
	import laya.display.Stage;
	import laya.net.Loader;
	import laya.ui.View;
	import laya.utils.Browser;
	import laya.utils.Handler;
	import mindmap.MindMapEditor;
	/**
	 * ...
	 * @author ww
	 */
	public class TestRemoteView 
	{
		
		public function TestRemoteView() 
		{
			Laya.init(800, 600);
			Laya.stage.scaleMode = Stage.SCALE_FULL;
			Laya.stage.screenMode = Stage.SCREEN_HORIZONTAL;
			Laya.stage.bgColor = "#000000";
			ContextMenu.init();
			ContextMenuItem.labelColors = "#ffffff,#ffffff,#ffffff,#ffffff";
			ContextMenuItem.btnSkin = "comp/button.png";
			View.regComponent("TreeEx", FileTree);
			var resList:Array;
			resList = [ { "url":"res/atlas/comp.json", "type":Loader.ATLAS } ];
			resList.push( { "url":"res/atlas/view.json", "type":Loader.ATLAS } );
			resList.push({"url":"res/atlas/play.json","type":Loader.ATLAS});
			Laya.loader.load(resList, new Handler(this, initFileToolKit));
			MindMapEditor.isEditorMode = false;
		}
		private var mindMapEditor:MindMapEditor;
		public var fileKit:FileKit;
		private var tree:RemoteTreeView;
		private function initFileToolKit():void
		{
			FileKit.root = "https://stk.orzooo.com:9953";
			//FileKit.root = "http://127.0.0.1:9953";
			fileKit = new FileKit();
			FileKit.I = fileKit;
			//fileKit.username = "deathnote";
			//fileKit.pwd = "deathnotefilekit";
			fileKit.on(FileKit.Logined,this,onLogin);
			//fileKit.login();
			test();
		}
		
		private function onLogin():void
		{
			mindMapEditor.saveBtn.visible = true;
			MindMapEditor.isEditorMode = true;
		}
		private function test():void
		{
			
			
			var container:Sprite;
			if (Browser.pixelRatio > 1)
			{
				container = new PixelRatioBox();
				Laya.stage.addChild(container);
				Laya._currentStage = container;
			}else
			{
				container = Laya.stage;
			}
			tree = new RemoteTreeView();
			tree.top = tree.bottom = 5;
			tree.fileKit = fileKit;
			tree.refresh();
			container.addChild(tree);
			
			
			mindMapEditor = new MindMapEditor();
			mindMapEditor.visible = false;
			mindMapEditor.left = tree.x + tree.width + 2;
			mindMapEditor.right = mindMapEditor.top = mindMapEditor.bottom = 2;
			mindMapEditor.on(MindMapEditor.Save, this, onMindMapSave);
			mindMapEditor.saveBtn.visible = false;
			container.addChild(mindMapEditor);
			
			Notice.listen(Msgs.Open_File, this, onOpenFile);
		}
		
		private function onMindMapSave():void
		{
			trace("save:", tFile, mindMapEditor.mapNodeData);
			fileKit.addFile(tFile, mindMapEditor.mapNodeData,Handler.create(this,onSaveBack) );
		}
		private function onSaveBack(dataO:Object):void
		{
			trace("onSaveBack:", dataO);
			if (dataO.success)
			{
				MessageManager.I.show("保存成功");
			}else
			{
				MessageManager.I.show("保存失败");
			}
		}
		
		private var tFile:String;
		private function onOpenFile(dataO:Object):void
		{
			var filePath:String;
			filePath = dataO.path;
			fileKit.getFile(filePath,Handler.create(this,onFileGet,[filePath]),true);
		}
		
		private function onFileGet(filePath:String, dataO:Object):void
		{
			trace("onFileGet:", filePath, dataO);
			tFile = filePath;
			if (dataO)
			{
				mindMapEditor.setData(dataO);
				mindMapEditor.visible = true;
			}
		}
	}

}