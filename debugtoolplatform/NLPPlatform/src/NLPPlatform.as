package  
{
	import electrontools.drags.SystemDragOverManager;
	import electrontools.menus.ContextMenu;
	import laya.display.Sprite;
	import laya.display.Stage;
	import laya.net.Loader;
	import laya.ui.Styles;
	import laya.utils.Handler;
	import nlp.NLP;
	import nodetools.devices.CMDShell;
	import nodetools.devices.Device;
	import nodetools.devices.DialogTools;
	import nodetools.devices.FileTools;
	import nodetools.devices.OSInfo;
	import nodetools.devices.Paths;
	import nodetools.devices.PythonTools;
	import nodetools.devices.SystemSetting;
	import view.nlpplatform.PlatformMain;
	/**
	 * ...
	 * @author ww
	 */
	public class NLPPlatform 
	{
		
		public function NLPPlatform() 
		{
			Laya.init(800, 600);
			Laya.stage.scaleMode = Stage.SCALE_FULL;
			UIConfig.touchScrollEnable = false;
			Styles.buttonLabelColors = ["#ffffff", "#32cc6b", "#ff0000", "#C0C0C0"];
			init();
			trace("version:33");
			var loadList:Array;
			loadList = [{"url":"res/atlas/comp.json", "type":Loader.ATLAS}];
			loadList.push({url:"data/CoreNatureDictionary.txt", type:Loader.TEXT });
			loadList.push({url:"data/中文字典1.txt",type:Loader.TEXT });
			Laya.loader.load(loadList, new Handler(this, test));
			Laya.stage.graphics.fillText("loading", 10, 10, null, "#ff0000",null);
		}
		private function init():void {
			Device.Buffer = __JS__("Buffer");
			Device.init();
			SystemSetting.isCMDVer = true;
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
			DialogTools.init();
			SystemDragOverManager.init();
			ContextMenu.init();
		
		}
		private function test():void
		{
			trace("AppPath:", FileTools.appPath);
			NLP.initWordCutter("data/中文字典1.txt","data/CoreNatureDictionary.txt");
			Laya.stage.graphics.fillText("ready", 10, 10, null, "#ff0000", null);
			
			var mainUI:PlatformMain;
			mainUI = new PlatformMain();
			mainUI.left = mainUI.right = mainUI.top = mainUI.bottom = 0;
			Laya.stage.addChild(mainUI);
		}
	}

}