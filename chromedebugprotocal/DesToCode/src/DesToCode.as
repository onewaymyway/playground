package  
{
	import code.ClassCreater;
	import code.ClassManager;
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