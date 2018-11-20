/**Created by the LayaAirIDE,do not modify.*/
package ui.mindmap {
	import laya.ui.*;
	import laya.display.*; 

	public class MapItemUI extends View {
		public var text:TextInput;
		public var downBtn:Button;
		public var upBtn:Button;
		public var selectBtn:Radio;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":162,"height":22},"child":[{"type":"TextInput","props":{"var":"text","text":"TextInput","skin":"comp/textinput.png","color":"#93eedf","align":"center"}},{"type":"Button","props":{"y":11,"x":131,"var":"downBtn","skin":"comp/down.png"}},{"type":"Button","props":{"y":-1,"x":131,"var":"upBtn","skin":"comp/up.png"}},{"type":"Radio","props":{"y":4,"x":147,"var":"selectBtn","skin":"comp/selectbtn.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}