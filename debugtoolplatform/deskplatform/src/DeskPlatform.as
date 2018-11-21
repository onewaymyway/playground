package  
{
	import electrontools.drags.SystemDragOverManager;
	import electrontools.menus.ContextMenu;
	import extendui.ui.ListBase;
	import extendui.ui.ListEx;
	import extendui.ui.TabEx;
	import extendui.ui.TreeBase;
	import extendui.ui.TreeEx;
	import laya.debug.DebugPanel;
	import laya.display.Stage;
	import laya.net.Loader;
	import laya.ui.Styles;
	import laya.ui.View;
	import laya.utils.Browser;
	import laya.utils.Handler;
	import nodetools.devices.CMDShell;
	import nodetools.devices.Device;
	import nodetools.devices.FileManager;
	import nodetools.devices.FileTools;
	import nodetools.devices.OSInfo;
	import nodetools.devices.Paths;
	import nodetools.devices.PythonTools;
	import nodetools.devices.SystemSetting;
	import platform.layout.LayoutRecManager;
	import platform.managers.CursorManager;
	import platform.managers.EditRenderManager;
	import platform.managers.LayerManager;
	import platform.managers.NoticeRouter;
	import platform.rendercanvas.CanvasSprite;
	import platform.rendercanvas.DialogHook;
	import view.MainView;
	import view.ResPanel;
	/**
	 * ...
	 * @author ww
	 */
	public class DeskPlatform 
	{
		
		public function DeskPlatform() 
		{
			Laya.init(800, 600);
			Laya.stage.scaleMode = Stage.SCALE_FULL;
			Laya.stage.bgColor = "#ffffff";
			UIConfig.touchScrollEnable = false;
			Styles.buttonLabelColors = ["#ffffff", "#32cc6b", "#ff0000", "#C0C0C0"];
			//注册组件
			View.regComponent("TreeEx", TreeEx);
			View.regComponent("Tab", TabEx);
			View.regComponent("List", ListBase);
			View.regComponent("Tree", TreeBase);
			View.regComponent("ListEx", ListEx);
			init();
			
			DialogHook.I.hookDialog();
			CanvasSprite.parentNode=Browser.container;
			var resList:Array;
			resList = [ { "url":"res/atlas/comp.json", "type":Loader.ATLAS } ];
			resList.push( { "url":"res/atlas/view.json", "type":Loader.ATLAS } );
			resList.push({"url":"res/atlas/play.json","type":Loader.ATLAS});
			Laya.loader.load(resList, new Handler(this, test));
		}
		private function init():void {
			Device.Buffer = __JS__("Buffer");
			Device.init();
			SystemSetting.isCMDVer = false;
			OSInfo.init();
			//Browser.userAgent = OSInfo.type;
			//Browser.userAgent = OSInfo.type;
			//Browser.userAgent = OSInfo.type;
			//trace(Browser.userAgent);
			//CMDShell.init();
			//Device.init();
			//初始化文件系统
			FileTools.init2();
			CMDShell.init();
			//CMDShell.childProcess = Device.requireRemote("child_process");
			PythonTools.PythonFolder = FileTools.getAppPath("pythontools") + "/";
			Paths.tempPath = FileTools.getAppPath("tempdata") + "/";
			Paths.dataPath = FileTools.getAppPath("data") + "/";
			SystemDragOverManager.init();
			ContextMenu.init();
			SystemSetting.appPath = FileTools.appPath;
		
		}
		private function test():void
		{
			trace("AppPath:", FileTools.appPath);
			initApp();
			return;
			testResPanel();
			return;
			var mainView:MainView;
			mainView = new MainView();
			mainView.left = mainView.right = mainView.top = mainView.bottom = 5;
			Laya.stage.addChild(mainView);
		}
		
		private function testResPanel():void
		{
			SystemSetting.assetsPath = "D:/codes/playground.git/trunk/debugtoolplatform/deskplatform";
			ResPanel.instance.init(SystemSetting.assetsPath);
			ResPanel.instance.top = 0;
			ResPanel.instance.bottom = 0;
			Laya.stage.addChild(ResPanel.instance);
		}
		
		private function initApp():void
		{
			EditRenderManager.init();
			NoticeRouter.init();
			
			CursorManager.init();
			//SystemSetting.assetsPath = "D:/codes/playground.git/trunk/debugtoolplatform/deskplatform";
			SystemSetting.assetsPath = FileManager.getAppPath("files");;
			ResPanel.instance.init(SystemSetting.assetsPath);
			LayerManager.init();
			LayoutRecManager.init();
			LayoutRecManager.createDefault();
			//DebugPanel.init();
		}
	}

}