/**Created by the LayaAirIDE,do not modify.*/
package ui.actorgame {
	import laya.ui.*;
	import laya.display.*; 

	public class QuestionSelectItemUI extends View {
		public var actionBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":275,"height":67},"child":[{"type":"Button","props":{"var":"actionBtn","skin":"comp/button.png","right":0,"left":0,"labelSize":30,"labelColors":"#ffffff","label":"选项1","height":67}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}