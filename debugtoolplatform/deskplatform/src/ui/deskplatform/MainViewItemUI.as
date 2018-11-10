/**Created by the LayaAirIDE,do not modify.*/
package ui.deskplatform {
	import laya.ui.*;
	import laya.display.*; 
	import platform.layout.*;

	public class MainViewItemUI extends View {
		public var label:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":98,"height":21},"child":[{"type":"Label","props":{"y":0,"x":0,"width":98,"var":"label","text":"label","styleSkin":"comp/label.png","height":21,"color":"#d2201d"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}