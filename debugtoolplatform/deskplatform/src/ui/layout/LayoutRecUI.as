/**Created by the LayaAirIDE,do not modify.*/
package ui.layout {
	import laya.ui.*;
	import laya.display.*; 
	import platform.layout.*;

	public class LayoutRecUI extends View {
		public var back:Image;
		public var tab:Tab;
		public var tipIcon:Image;
		public var actionIcon:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"hitTestPrior":true},"child":[{"type":"Image","props":{"y":0,"x":0,"width":600,"var":"back","top":0,"skin":"view/bg_panel_layoutrec.png","right":0,"left":0,"height":25}},{"type":"Tab","props":{"y":0,"x":0,"var":"tab","skin":"view/tab_panel.png","labelColors":"#61737C,#c5c5c5,#c5c5c5,#c5c5c5"}},{"type":"Image","props":{"y":6,"x":581,"visible":false,"var":"tipIcon","skin":"comp/iconhelp.png","scaleX":0.5,"scaleY":0.5}},{"type":"Image","props":{"y":9,"x":5,"visible":false,"var":"actionIcon","skin":"view/arrow_down.png","scaleY":0.5,"scaleX":0.5}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}