/**Created by the LayaAirIDE,do not modify.*/
package ui.nlpplatform {
	import laya.ui.*;
	import laya.display.*; 

	public class WordListViewerUI extends View {
		public var container:Panel;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":600,"height":400},"child":[{"type":"Panel","props":{"var":"container","vScrollBarSkin":"comp/vscroll.png","top":5,"right":5,"left":5,"bottom":5}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}