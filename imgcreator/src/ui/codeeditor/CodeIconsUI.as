/**Created by the LayaAirIDE,do not modify.*/
package ui.codeeditor {
	import laya.ui.*;
	import laya.display.*; 

	public class CodeIconsUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":720,"height":1280},"child":[{"type":"Sprite","props":{"y":13,"x":7,"width":103,"name":"bg01.png","height":50},"child":[{"type":"Poly","props":{"y":1,"x":1,"points":"0,0,20,0,30,9,40,0,100,0,100,40,40,40,30,47,20,40,0,40","lineWidth":1,"lineColor":"#ff0000","fillColor":"#00ffff"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}