package view.nlpplatform 
{
	import laya.events.Event;
	import laya.utils.Utils;
	import nodetools.devices.DialogTools;
	import nodetools.devices.FileTools;
	import ui.nlpplatform.PlatformMainUI;
	
	/**
	 * ...
	 * @ww
	 */
	public class PlatformMain extends PlatformMainUI 
	{
		
		public function PlatformMain() 
		{
			openBtn.on(Event.CLICK, this, onOpenBtn);
		}
		
		private function onOpenBtn():void
		{
			DialogTools.showOpenFile("打开文件", Utils.bind(onOpenFileBack, this),DialogTools.txtFilterO);
		}
		
		private function onOpenFileBack(dataO:Array):void
		{
			debugger;
			if (!dataO || !dataO.length) return;
			var filePath:String;
			filePath = dataO[0];
			bookReader.loadFile(filePath);
			
		}
		
	}

}