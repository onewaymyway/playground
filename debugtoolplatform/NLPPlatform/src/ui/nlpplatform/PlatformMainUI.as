/**Created by the LayaAirIDE,do not modify.*/
package ui.nlpplatform {
	import laya.ui.*;
	import laya.display.*; 
	import view.nlpplatform.BookReader;

	public class PlatformMainUI extends View {
		public var openBtn:Button;
		public var bookReader:BookReader;
		public var saveBtn:Button;
		public var bookInfo:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":600,"height":400},"child":[{"type":"Button","props":{"y":9,"x":9,"var":"openBtn","skin":"comp/button.png","label":"打开"}},{"type":"BookReader","props":{"var":"bookReader","top":40,"runtime":"view.nlpplatform.BookReader","right":5,"left":5,"bottom":5}},{"type":"Button","props":{"y":9,"x":110,"var":"saveBtn","skin":"comp/button.png","label":"保存"}},{"type":"Label","props":{"y":12,"x":205,"width":383,"var":"bookInfo","text":"label","styleSkin":"comp/label.png","height":26,"fontSize":20,"color":"#ffffff"}}]};
		override protected function createChildren():void {
			View.regComponent("view.nlpplatform.BookReader",BookReader);
			super.createChildren();
			createView(uiView);

		}

	}
}