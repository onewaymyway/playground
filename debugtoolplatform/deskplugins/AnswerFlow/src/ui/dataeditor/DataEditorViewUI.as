/**Created by the LayaAirIDE,do not modify.*/
package ui.dataeditor {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;
	import ui.dataeditor.DataListUI;

	public class DataEditorViewUI extends View {
		public var saveBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":600,"height":600},"child":[{"type":"Button","props":{"var":"saveBtn","top":5,"skin":"comp/button.png","right":5,"label":"save"}},{"type":"DataList","props":{"y":436,"x":34,"runtime":"ui.dataeditor.DataListUI"}}]};
		override protected function createChildren():void {
			View.regComponent("ui.dataeditor.DataListUI",DataListUI);
			super.createChildren();
			createView(uiView);

		}

	}
}