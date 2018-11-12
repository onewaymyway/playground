/**Created by the LayaAirIDE,do not modify.*/
package ui.edit {
	import laya.ui.*;
	import laya.display.*; 
	import platform.layout.*;

	public class EditZoneUI extends DragView {
		public var tab:Tab;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"DragView","props":{"title":"UI","scenecolor":"#dddddd","recTabSkin":"view/tab_uipanel.png","recBarSkin":"view/bg_uipanel_bar.png","hitTestPrior":true},"child":[{"type":"Image","props":{"y":0,"x":0,"top":0,"skin":"view/bg_uiviewer.png","right":0,"left":0,"bottom":0}},{"type":"Image","props":{"y":0,"x":0,"width":164,"skin":"view/bg_uipanel.png","sizeGrid":"0,3,0,3","right":0,"left":0,"height":25}},{"type":"Tab","props":{"y":0,"x":0,"var":"tab","skin":"view/tab_uipanel.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}