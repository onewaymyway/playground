/**Created by the LayaAirIDE,do not modify.*/
package ui.actorgame {
	import laya.ui.*;
	import laya.display.*; 

	public class StarItemUI extends View {
		public var icon:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":28,"height":28},"child":[{"type":"Image","props":{"var":"icon","skin":"comp/prop.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}