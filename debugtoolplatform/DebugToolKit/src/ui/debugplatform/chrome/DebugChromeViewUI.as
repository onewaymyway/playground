/**Created by the LayaAirIDE,do not modify.*/
package ui.debugplatform.chrome {
	import laya.ui.*;
	import laya.display.*; 

	public class DebugChromeViewUI extends View {
		public var startBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":400,"height":300},"child":[{"type":"Button","props":{"y":7,"x":320,"var":"startBtn","skin":"comp/button.png","label":"启动"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}