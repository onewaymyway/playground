/**Created by the LayaAirIDE,do not modify.*/
package ui.edit {
	import laya.ui.*;
	import laya.display.*; 
	import platform.layout.*;

	public class EditTabUI extends View {
		public var btn:Button;
		public var close:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"scenecolor":"#dddddd"},"child":[{"type":"Button","props":{"y":0,"x":0,"width":75,"var":"btn","skin":"view/tab_uipanel.png","labelMargin":"0,0,15,0","labelColors":"#dddddd,#888888,#e0e0e0","label":"label","height":25}},{"type":"Button","props":{"y":9,"x":59,"var":"close","skin":"view/btn_close1.png","scaleX":0.5,"scaleY":0.5,"stateNum":2}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}