/**Created by the LayaAirIDE,do not modify.*/
package ui.nlpplatform {
	import laya.ui.*;
	import laya.display.*; 
	import view.nlpplatform.BookReader;
	import view.nlpplatform.WordListViewer;

	public class BookReaderUI extends View {
		public var wordView:WordListViewer;
		public var bookInfo:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":600,"runtime":"view.nlpplatform.BookReader","height":400},"child":[{"type":"WordListViewer","props":{"var":"wordView","top":0,"runtime":"view.nlpplatform.WordListViewer","right":0,"left":150,"bottom":0}},{"type":"Label","props":{"y":16,"x":16,"width":120,"var":"bookInfo","text":"label","styleSkin":"comp/label.png","height":53,"fontSize":20}}]};
		override protected function createChildren():void {
			View.regComponent("view.nlpplatform.BookReader",BookReader);
			View.regComponent("view.nlpplatform.WordListViewer",WordListViewer);
			super.createChildren();
			createView(uiView);

		}

	}
}