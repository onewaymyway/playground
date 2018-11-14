/**Created by the LayaAirIDE,do not modify.*/
package ui.mindmap {
	import laya.ui.*;
	import laya.display.*; 

	public class MapItemUI extends View {
		public var text:TextInput;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":129,"height":23},"child":[{"type":"TextInput","props":{"var":"text","text":"TextInput","skin":"comp/textinput.png","color":"#93eedf","align":"center"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}