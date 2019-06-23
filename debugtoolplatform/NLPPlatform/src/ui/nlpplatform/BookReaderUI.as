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
		public var pageNum:TextInput;
		public var go:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":600,"runtime":"view.nlpplatform.BookReader","height":400},"child":[{"type":"WordListViewer","props":{"var":"wordView","top":0,"runtime":"view.nlpplatform.WordListViewer","right":0,"left":150,"bottom":0}},{"type":"Label","props":{"y":16,"x":16,"width":136,"var":"bookInfo","text":"书籍信息","styleSkin":"comp/label.png","height":53,"fontSize":20,"color":"#ffffff"}},{"type":"Box","props":{"y":99,"x":16,"width":128,"var":"buttonBox","height":287},"child":[{"type":"Button","props":{"y":0,"x":0,"skin":"comp/button.png","name":"清空选择","label":"清空选择"}},{"type":"Button","props":{"y":34,"x":0,"skin":"comp/button.png","name":"创建关系","label":"创建关系"}},{"type":"Button","props":{"y":67,"x":0,"skin":"comp/button.png","name":"重建关系","label":"重建关系"}},{"type":"Button","props":{"y":101,"x":0,"skin":"comp/button.png","name":"打散","label":"打散"}},{"type":"Button","props":{"y":168,"x":0,"skin":"comp/button.png","name":"合词","label":"合词"}},{"type":"Button","props":{"y":200,"x":0,"skin":"comp/button.png","name":"全文合词","label":"全文合词"}},{"type":"Button","props":{"y":233,"x":0,"skin":"comp/button.png","name":"重新分词","label":"重新分词"}},{"type":"Button","props":{"y":133,"x":0,"skin":"comp/button.png","name":"全文打散","label":"全文打散"}}]},{"type":"TextInput","props":{"y":69,"x":16,"width":69,"var":"pageNum","text":"0","skin":"comp/input_22.png","height":22,"color":"#ffffff"}},{"type":"Button","props":{"y":67,"x":94,"width":34,"var":"go","skin":"comp/button.png","label":"go","height":24}}]};
		override protected function createChildren():void {
			View.regComponent("view.nlpplatform.BookReader",BookReader);
			View.regComponent("view.nlpplatform.WordListViewer",WordListViewer);
			super.createChildren();
			createView(uiView);

		}

	}
}