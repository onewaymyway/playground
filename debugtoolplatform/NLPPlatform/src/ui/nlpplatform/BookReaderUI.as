/**Created by the LayaAirIDE,do not modify.*/
package ui.nlpplatform {
	import laya.ui.*;
	import laya.display.*; 
	import view.nlpplatform.BookReader;
	import view.nlpplatform.WordListViewer;

	public class BookReaderUI extends View {
		public var wordView:WordListViewer;
		public var bookInfo:Label;
		public var buttonBox:Box;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":600,"runtime":"view.nlpplatform.BookReader","height":400},"child":[{"type":"WordListViewer","props":{"var":"wordView","top":0,"runtime":"view.nlpplatform.WordListViewer","right":0,"left":150,"bottom":0}},{"type":"Label","props":{"y":16,"x":16,"width":120,"var":"bookInfo","text":"书籍信息","styleSkin":"comp/label.png","height":53,"fontSize":20,"color":"#ffffff"}},{"type":"Box","props":{"y":93,"x":16,"width":128,"var":"buttonBox","height":287},"child":[{"type":"Button","props":{"skin":"comp/button.png","name":"清空选择","label":"清空选择"}},{"type":"Button","props":{"y":34,"x":1,"skin":"comp/button.png","name":"创建关系","label":"创建关系"}},{"type":"Button","props":{"y":67,"x":1,"skin":"comp/button.png","name":"重建关系","label":"重建关系"}},{"type":"Button","props":{"y":101,"x":2,"skin":"comp/button.png","name":"打散","label":"打散"}},{"type":"Button","props":{"y":138,"x":2,"skin":"comp/button.png","name":"合词","label":"合词"}},{"type":"Button","props":{"y":170,"x":1,"skin":"comp/button.png","name":"全文合词","label":"全文合词"}},{"type":"Button","props":{"y":203,"x":2,"skin":"comp/button.png","name":"重新分词","label":"重新分词"}}]}]};
		override protected function createChildren():void {
			View.regComponent("view.nlpplatform.BookReader",BookReader);
			View.regComponent("view.nlpplatform.WordListViewer",WordListViewer);
			super.createChildren();
			createView(uiView);

		}

	}
}