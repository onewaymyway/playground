/**Created by the LayaAirIDE,do not modify.*/
package ui.tarot {
	import laya.ui.*;
	import laya.display.*; 

	public class CardDetaiUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":400,"height":300}};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}