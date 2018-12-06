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
	import laya.events.Event;
	import laya.net.Loader;
	import laya.ui.Button;
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
		private var switchBtn:Button;
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
		
		private var container:Sprite;
		private function test():void
		{
			
			switchBtn = new Button();
			switchBtn.skin = "comp/button.png";
			switchBtn.label = "Switch";
			
			
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
			
			
			container.addChild(switchBtn);
			switchBtn.left = mindMapEditor.left;
			switchBtn.on(Event.CLICK, this, onSwitchBtn);
			Notice.listen(Msgs.Open_File, this, onOpenFile);
		}
		
		private function onSwitchBtn():void
		{
			if (tree.parent)
			{
				tree.removeSelf();
				mindMapEditor.left = 2;
				switchBtn.left = mindMapEditor.left;
			}else
			{
				container.addChild(tree);
				mindMapEditor.left = tree.x + tree.width + 2;
				switchBtn.left = mindMapEditor.left;
			}
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
		private var tID:int = 0;
		private var preLoadFile:String;
		private function onOpenFile(dataO:Object):void
		{
			var filePath:String;
			filePath = dataO.path;
			if (filePath == preLoadFile) return;
			preLoadFile = filePath;
			tID++;
			fileKit.getFile(filePath,Handler.create(this,onFileGet,[filePath,tID]),true);
		}
		
		private function onFileGet(filePath:String,rID:int, dataO:Object):void
		{
			
			trace("onFileGet:", filePath, dataO);
			if (rID != tID) return;
			tFile = filePath;
			if (dataO)
			{
				mindMapEditor.setData(dataO);
				mindMapEditor.visible = true;
			}
		}
	}

}