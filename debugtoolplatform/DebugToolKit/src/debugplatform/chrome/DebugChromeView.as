package debugplatform.chrome 
{
	import chromedebug.ChromeProtocolUtils;
	import chromedebug.ChromeSocket;
	import laya.events.Event;
	import laya.net.Loader;
	import laya.utils.Handler;
	import nodetools.devices.CMDShell;
	import ui.debugplatform.chrome.DebugChromeViewUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class DebugChromeView extends DebugChromeViewUI 
	{
		private var _chromeSocket:ChromeSocket;
		public function DebugChromeView() 
		{
			startBtn.on(Event.CLICK, this, onStartBtn);
			domainList.array = [];
			domainList.renderHandler = new Handler(this, listRenderHandler);
			domainList.array = ChromeProtocolUtils.getEnableableDomains();
		}
		
		private var _isDebugViewDic:Object = { };
		private function listRenderHandler(cell:DomainListItem, index:int ):void
		{
			var dataO:Object;
			dataO = cell.dataSource;
			cell.isDebugDic=_isDebugViewDic;
			cell.initByData(dataO);
		}
		
		private function onStartBtn():void
		{
			if (_chromeSocket) _chromeSocket.closeLater();
			
			var cmdStr:String;
			cmdStr = '"C:/Program Files (x86)/Google/Chrome/Application/chrome.exe" --remote-debugging-port=9222 --user-data-dir=D:/chrome/datatemp';
			CMDShell.execute(cmdStr);
			Laya.timer.once(2000,this, checkingDebugTarget);
		}
		
		private function checkingDebugTarget():void
		{
			Laya.loader.load("http://127.0.0.1:9222/json?v="+Math.random(), new Handler(this, onLoaded),null,Loader.JSON);
		}
		
		private function onLoaded(dataO:Object):void
		{
			if (!dataO)
			{
				Laya.timer.once(1000,this, checkingDebugTarget);
			}else
			{
				onTargetFind(dataO);
			}
		}
		private function onTargetFind(targets:Array):void
		{
			_chromeSocket = new ChromeSocket();
			_chromeSocket.connectByTargetO(targets[0]);
		}
	
	}

}