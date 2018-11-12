///////////////////////////////////////////////////////////
//  WebViewContainer.as
//  Macromedia ActionScript Implementation of the Class WebViewContainer
//  Created on:      2018-10-10 下午2:45:38
//  Original author: ww
///////////////////////////////////////////////////////////

package platform.viewers
{

	import laya.utils.Browser;
	import laya.utils.Utils;
	import nodetools.devices.FileManager;
	import platform.extenddisplay.HtmlSprite;
	import platform.interfaces.PlatformEvents;
	import platform.tools.Notice;
	
	/**
	 * 
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2018-10-10 下午2:45:38
	 */
	public class WebViewContainer extends HtmlSprite
	{
		public function WebViewContainer()
		{
			super();
		}
		
		public var webView:*;
		public var webContents:*;
		public var debugerObj:*;
		override public function createHtml():void
		{
			webView=Browser.document.createElement("webview");
			div=webView;
			this.webView.nodeintegration=true;
			webView.addEventListener('dom-ready', Utils.bind(onWebViewReady,this));
			webView.addEventListener('ipc-message', Utils.bind(onMessage,this));
			
			//test code
			
//			setUrl("D:/idenewtest/2.0/test/TestDebugTool/bin/index.html");
		}
		
		
		public function sendMessage(type:String,dataO:Object):void
		{
			var paramO:Object;
			paramO = { };
			paramO.type = type;
			paramO.data = dataO;
			webView.send("message", paramO);
			//ipcRenderer.sendToHost();
		}
		private function onMessage(e:*):void
		{
			trace("message:", e);
			if(e.channel!="message") return;
			
			var dataO:Object;
			dataO=e.args[0];
			if(!dataO) return;
//			debugger;
			trace("obj data:",dataO.type,dataO.data);
			switch(dataO.type)
			{

			}
		}
		private function onWebViewReady():void
		{
			trace("onWebViewReady");
			webContents=webView.getWebContents();
			debugerObj=webContents.debugger;
//			debugger;
			Notice.notify(PlatformEvents.WebViewReady,[webView]);
			Laya.timer.once(100,this,insertScripts);
		}
		
		private function insertScripts():void
		{
			//excuteScriptFile(FileManager.getAppPath("renders/debugtoolkit/laya.debugviewkit.js"));
			webView.openDevTools();
			
		}
		
		public function sendMessage(dataO:*):void
		{
			if(webView)
			{
				webView.send("message",dataO);
			}
		}
		
		public function setUrl(url:String):void
		{
			webView.src=url;
		}
		
		public function excuteScript(script:String):void
		{
			this.webView.executeJavaScript(script);
		}
		
		public function excuteScriptFile(file:String):void
		{
			if(!FileManager.exists(file)) return;
			var script:String;
			script=FileManager.readTxtFile(file);
			excuteScript(script);
		}
		
		
		
	}
}