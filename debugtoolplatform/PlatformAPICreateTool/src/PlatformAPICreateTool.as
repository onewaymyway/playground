package {
	import laya.debug.tools.DTrace;
	import laya.debug.tools.ObjectTools;
	import laya.debug.tools.StringTool;
	import laya.debug.tools.TraceTool;
	import laya.fileconfig.RunConfig;
	import laya.utils.Browser;
	import laya.utils.Byte;
	import laya.utils.Handler;
	import laya.utils.Utils;
	import nodetools.devices.CMDShell;
	import nodetools.devices.Device;
	import nodetools.devices.FileManager;
	import nodetools.devices.FileTools;
	import nodetools.devices.NodeJSTools;
	import nodetools.devices.OSInfo;
	import nodetools.devices.SystemSetting;
	import wraps.SMD5;
	
	/**
	 * ...
	 * @author ww
	 */
	public class PlatformAPICreateTool {
		public static var I:PlatformAPICreateTool;
		public function PlatformAPICreateTool() {
			I = this;
			var fun:Function;
			fun = Utils.bind(beginWork, this);
			__JS__("setTimeout(fun,1000)");
			//beginWork();
		}
		private function beginWork():void
		{
			init();
			parseCMD(NodeJSTools.getArgv());
			DTrace.timeStart("PlatformAPICreateTool");
			work();
			
			//trace("myPath:",NodeJSTools.getMyPath());
		}
		private function workDone():void
		{
			trace("work done");
			DTrace.timeEnd("PlatformAPICreateTool");
		}
		private function parseCMD(args:Array):void {
			NodeJSTools.parseArgToObj(args, 1, RunConfig);
			if (!RunConfig.paramFile) return;
			
			var paramFile:String;
			paramFile = paramFile;
			if (!FileTools.isAbsPath(paramFile))
			{
				FileManager.getPath(NodeJSTools.getMyPath(), "param.json");
			}
			if (FileManager.exists(paramFile))
			{
				trace("parseParamFileToObj");
				NodeJSTools.parseParamFileToObj(paramFile, RunConfig);
			}
		}
		
		private var codeTpl:String;
		private function init():void {
			NodeJSTools.init();
		
			var codeTplPath:String;
			codeTplPath = FileTools.getPath(NodeJSTools.getMyPath(), "data/IFrameAPIInsertTool.tpl");
			codeTpl=FileManager.readTxtFile(codeTplPath);
		}
		
		private var _importList:Array;
		private var _insertList:Array;
		public function work():void
		{

			RunConfig.sourcePath = NodeJSTools.getAbsPath(RunConfig.sourcePath);
			trace("root:",RunConfig.sourcePath);
			_importList = [];
			_insertList = [];
			var files:Array;
			files = FileTools.getFileList(RunConfig.sourcePath);
			var i:int, len:int;
			len = files.length;
			var extension:String;
			var tFile:String;
			var tFileName:String;
			var tRPath:String;
			var fullClassPath:String;
			var fileContent:String;
			for (i = 0; i < len; i++)
			{
				tFile = files[i];
				extension = FileTools.getExtensionName(tFile);
				if (extension == "as")
				{
					fileContent = FileManager.readTxtFile(tFile);
					if (fileContent.indexOf("/*[IF-FLASH]*/") < 0&&fileContent.indexOf("/*[PACKAGE-SAVEDISBALE]*/")<0) continue;
					
					tFileName = FileTools.getFileName(tFile);
					tRPath = FileManager.getRelativePath(RunConfig.sourcePath, tFile);
					fullClassPath = StringTool.getReplace(tRPath, "/", ".").replace(".as","");
					_importList.push("	import "+fullClassPath+";");
					_insertList.push(tFileName);
				}
			}
			
			trace("importList:", _importList);
			trace("insertList:", _insertList);
			var dataO:Object;
			dataO = { };
			dataO.imports = _importList.join("\n");
			dataO.inserts = _insertList.join(",");
			
			var codeRst:String;
			codeRst = createExportCode(codeTpl, dataO);
			
			var codeOutPath:String;
			codeOutPath = FileTools.getPath(NodeJSTools.getMyPath(), "out/IFrameAPIInsertTool.as");
			FileManager.createTxtFile(codeOutPath, codeRst);
		}
		
		/**
		 * 根据代码模板和数据生成代码
		 * @param tplStr
		 * @param data
		 * @return
		 *
		 */
		public static function createExportCode(tplStr:String, data:Object):String {
			var rst:String;
			var key:String;
			rst = tplStr;
			for (key in data) {
				rst = StringTool.getReplace(rst, "{#@" + key + "#}", data[key]);
			}
			return rst;
		}
	}

}