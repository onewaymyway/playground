/**Created by the LayaAirIDE,do not modify.*/
package ui.layout {
	import laya.ui.*;
	import laya.display.*; 
	import platform.layout.*;

	public class LayoutTabUI extends View {
		public var btn:Button;
		public var close:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"scenecolor":"#dddddd"},"child":[{"type":"Button","props":{"y":0,"x":0,"width":75,"var":"btn","skin":"view/tab_panel.png","labelColors":"#dddddd,#888888,#e0e0e0","label":"label","height":25}},{"type":"Button","props":{"y":10,"x":60,"var":"close","skin":"view/btn_close1.png","scaleX":0.5,"scaleY":0.5,"stateNum":2}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}