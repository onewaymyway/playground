package code 
{
	import nodetools.devices.FileManager;
	import nodetools.devices.NodeJSTools;
	/**
	 * ...
	 * @author ww
	 */
	public class ProtocolClassCreater 
	{
		private static var clzTpl:String;
		private static var methodTpl:String;
		public static var exportPath:String;
		public function ProtocolClassCreater() 
		{
			
		}
		public static function init():void
		{
			clzTpl = FileManager.readTxtFile(NodeJSTools.getPathByRelatviePath("data/protocoltpl/domain.tpl"));
			methodTpl = FileManager.readTxtFile(NodeJSTools.getPathByRelatviePath("data/protocoltpl/method.tpl"));
			exportPath = NodeJSTools.getPathByRelatviePath("out/debugprotocol");
		}
		public static var domainName:String;
		public static function create(dataO:Object):void
		{
			
			domainName = dataO.domain;
			var cmds:Array;
			cmds = dataO.commands||[];
			
			var events:Array;
			events = dataO.events || [];
			
			var domainO:Object;
			domainO = { };
			domainO.name = domainName;
			domainO.imports = "";
			domainO.doc = "";
			domainO["extends"] = "";
			domainO["package"] = "debugprotocol." + domainName;
			domainO["methods"] = CodeCreateTool.addPreToStr(createMethods(cmds), "  	");
			domainO["events"] = CodeCreateTool.addPreToStr(createMethods(events), "  	");
			domainO["dependencies"] = "";
			if (dataO.dependencies)
			{
				domainO["dependencies"] = dataO["dependencies"].join(",");
			}
			
			var codeStr:String;
			codeStr = CodeCreateTool.createExportCode(clzTpl, domainO);
			
			var codePath:String;
			codePath = FileManager.getPath(exportPath, domainName + ".as");
			FileManager.createTxtFile(codePath, codeStr);
		}
		
		private static function createMethods(cmds:Array):String
		{
			var cmdStrs:Array;
			cmdStrs = [];
			var i:int, len:int;
			len = cmds.length;
			for (i = 0; i < len; i++)
			{
				cmdStrs.push(createMethodCode(cmds[i]));
			}
			return cmdStrs.join("\n");
		}
		
		public static var ParamTpl:String = "{#@name#}:{#@type#} optional:{#@optional#} {#@description#}";
		private static function createMethodCode(dataO:Object):String
		{
			var methodO:Object;
			methodO = { };
			methodO.name = dataO.name;
			methodO.domain = domainName;
			
			var docO:Object;
			docO = { };
			docO.name = dataO.name;
			docO.params = dataO.parameters;
			docO["return"] = "";
			docO.description = dataO.description;
			if (dataO.returns&&dataO.returns[0])
			{
				docO["return"] = CodeCreateTool.createExportCode(ParamTpl,dataO.returns[0]);
			}
			methodO.doc = CodeCreateTool.createDocStr(docO, ParamTpl);
			
			return CodeCreateTool.createExportCode(methodTpl, methodO);
			
		}
	}

}