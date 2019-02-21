/**Created by the LayaAirIDE,do not modify.*/
package ui.wordparser {
	import laya.ui.*;
	import laya.display.*; 

	public class MainUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":720,"height":1280},"child":[{"type":"Button","props":{"y":535,"x":336,"skin":"comp/button.png","label":"label","labelColors":"#fffff"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}