package  
{
	import laya.events.Event;
	import laya.net.Loader;
	import laya.utils.Handler;
	/**
	 * ...
	 * @author ww
	 */
	public class TestChromeSocket 
	{
		
		public function TestChromeSocket() 
		{
			Laya.init(1000, 900);
			test();
		}
		
		private function test():void
		{
			Laya.stage.on(Event.CLICK, this, checkingDebugTarget);
		}
		
		private function checkingDebugTarget():void
		{
			Laya.loader.load("http://127.0.0.1:9222/json?v="+Math.random(), new Handler(this, onLoaded),null,Loader.JSON);
		}
		
		private function onLoaded(dataO:Object):void
		{
			if (!dataO)
			{
			}else
			{
				
			}
		}
		private function onTargetFind(dataO:Object):void
		{
			
		}
	}

}