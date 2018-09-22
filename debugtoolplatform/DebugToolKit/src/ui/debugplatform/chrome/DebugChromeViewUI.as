/**Created by the LayaAirIDE,do not modify.*/
package ui.debugplatform.chrome {
	import laya.ui.*;
	import laya.display.*; 
	import debugplatform.chrome.DomainListItem;

	public class DebugChromeViewUI extends View {
		public var startBtn:Button;
		public var domainList:List;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":400,"height":300},"child":[{"type":"Button","props":{"y":7,"x":320,"var":"startBtn","skin":"comp/button.png","label":"启动"}},{"type":"List","props":{"x":17,"width":126,"var":"domainList","vScrollBarSkin":"comp/vscroll.png","top":20,"scrollBarSkin":"comp/vscroll.png","repeatX":1,"bottom":20},"child":[{"type":"DomainListItem","props":{"y":0,"x":0,"runtime":"debugplatform.chrome.DomainListItem","renderType":"render","name":"render"}}]}]};
		override protected function createChildren():void {
			View.regComponent("debugplatform.chrome.DomainListItem",DomainListItem);
			super.createChildren();
			createView(uiView);

		}

	}
}