/**Created by the LayaAirIDE,do not modify.*/
package ui.mindmap {
	import laya.ui.*;
	import laya.display.*; 

	public class MapItemUI extends View {
		public var text:TextInput;
		public var downBtn:Button;
		public var upBtn:Button;
		public var selectBtn:Radio;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":162,"height":22},"child":[{"type":"TextInput","props":{"var":"text","text":"TextInput","skin":"comp/textinput.png","sizeGrid":"7,10,5,5","right":33,"left":0,"color":"#93eedf","align":"center"}},{"type":"Button","props":{"y":11,"var":"downBtn","skin":"comp/down.png","right":19}},{"type":"Button","props":{"y":-1,"var":"upBtn","skin":"comp/up.png","right":19}},{"type":"Radio","props":{"y":4,"var":"selectBtn","skin":"comp/selectbtn.png","right":1}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}