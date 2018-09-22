package  
{
	import code.ClassCreater;
	import code.ClassManager;
	import code.CodeCreateTool;
	import code.FunctionCreater;
	import code.ProtocolClassCreater;
	import nodetools.devices.FileManager;
	import nodetools.devices.NodeJSTools;
	/**
	 * ...
	 * @author ww
	 */
	public class DesToCode 
	{
		
		public function DesToCode() 
		{
			init();
			work();
		}
		
		private function init():void
		{
			NodeJSTools.init();
		}
		
		private var outPath:String;
		private function work():void
		{
			var myPath:String;
			myPath = NodeJSTools.getMyPath();
			outPath = FileManager.getPath(myPath, "out/");
			
			ProtocolClassCreater.init();
			
			ProtocolClassCreater.exportPath = NodeJSTools.getPathByRelatviePath("out/debugprotocol");
			
			var configPath:String;
			configPath = FileManager.getPath(myPath, "data/protocol.json");
			var configData:Object;
			configData = FileManager.readJSONFile(configPath);
			
			createDomainList(configData.domains);
			createAllRefer(configData.domains);
			
		}
		
		private function createAllRefer(clsList:Array):void
		{
			var tpl:String = FileManager.readTxtFile(NodeJSTools.getPathByRelatviePath("data/protocoltpl/all.tpl"));
			var exportPath:String = NodeJSTools.getPathByRelatviePath("out/debugprotocol/All.as");
			var i:int, len:int;
			len = clsList.length;
			var names:Array;
			names = [];
			for (i = 0; i < len; i++)
			{
				names.push(clsList[i].domain);
			}
			var dataO:Object;
			dataO = { };
			dataO.refers = names.join(",");
			var codeStr:String;
			codeStr = CodeCreateTool.createExportCode(tpl, dataO);
			FileManager.createTxtFile(exportPath, codeStr);
		}
		
		private function createDomainList(clsList:Array):void
		{
			var i:int, len:int;
			len = clsList.length;
			for (i = 0; i < len; i++)
			{
				ProtocolClassCreater.create(clsList[i]);
			}
		}
		
	}

}