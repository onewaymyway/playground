package  
{
	import laya.debug.tools.XML2Object;
	import laya.net.Loader;
	import laya.utils.Handler;
	import mindmap.adpttool.MM2MindMapData;
	/**
	 * ...
	 * @author ww
	 */
	public class TestXml 
	{
		
		public function TestXml() 
		{
			Laya.init(1000, 900);
			test();
		}
		
		private function test():void
		{
			Laya.loader.load("mm/互联网地图.mm", Handler.create(this, onLoaded),null,Loader.XML);
		}
		
		private function onLoaded(dataO:Object):void
		{
			//debugger;
			var obj:Object;
			obj = MM2MindMapData.parse(dataO);
			debugger;
		}
		
	}

}