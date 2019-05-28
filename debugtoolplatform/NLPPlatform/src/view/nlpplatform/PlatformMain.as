package view.nlpplatform 
{
	import laya.events.Event;
	import laya.utils.Utils;
	import nodetools.devices.DialogTools;
	import nodetools.devices.FileManager;
	import nodetools.devices.FileTools;
	import ui.nlpplatform.PlatformMainUI;
	
	/**
	 * ...
	 * @ww
	 */
	public class PlatformMain extends PlatformMainUI 
	{
		private var tFile:String;
		public function PlatformMain() 
		{
			openBtn.on(Event.CLICK, this, onOpenBtn);
			saveBtn.on(Event.CLICK, this, onSaveBtn);
			
		}
		
		private function onSaveBtn():void
		{
			var savePath:String;
			savePath = tFile;
			var tExtension:String;
			tExtension = FileTools.getExtensionName(tFile);
			if (tExtension != NLPPlatFormConst.TaggingExtension)
			{
				savePath = tFile.replace("." + tExtension, "." + NLPPlatFormConst.TaggingExtension);
			}
			var saveDataO:Object;
			saveDataO = bookReader.book.toData();
			trace("save:", savePath,saveDataO);
			FileManager.createJSONFile(savePath, saveDataO);
		}
		
		private function onOpenBtn():void
		{
			DialogTools.showOpenFile("打开文件", Utils.bind(onOpenFileBack, this),NLPPlatFormConst.taggingFilterO);
		}
		
		private function onOpenFileBack(dataO:Array):void
		{
			debugger;
			if (!dataO || !dataO.length) return;
			var filePath:String;
			filePath = dataO[0];
			tFile = filePath;
			bookReader.loadFile(filePath);
			
		}
		
	}

}