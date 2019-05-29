/**Created by the LayaAirIDE,do not modify.*/
package ui.nlpplatform {
	import laya.ui.*;
	import laya.display.*; 
	import commoncomponent.InputSelect;

	public class WordPropUI extends Dialog {
		public var wordTxt:Label;
		public var meaningInput:TextInput;
		public var wordType:InputSelect;
		public var sureBtn:Button;
		public var selectMeaningBtn:Button;
		public var closeBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":256,"height":337},"child":[{"type":"Image","props":{"y":0,"x":0,"top":0,"skin":"comp/blank2.png","right":0,"left":0,"bottom":0}},{"type":"Label","props":{"y":15,"x":11,"width":120,"var":"wordTxt","text":"word","styleSkin":"comp/label.png","height":31,"fontSize":20,"color":"#ffffff"}},{"type":"Label","props":{"y":71,"x":9,"width":120,"text":"词性","styleSkin":"comp/label.png","height":31,"fontSize":20,"color":"#ffffff"}},{"type":"Label","props":{"y":121,"x":9,"width":120,"text":"词义","styleSkin":"comp/label.png","height":31,"fontSize":20,"color":"#ffffff"}},{"type":"TextInput","props":{"y":161,"x":9,"width":232,"var":"meaningInput","valign":"top","text":"TextInput","skin":"comp/input_22.png","sizeGrid":"4,8,6,10","height":134,"color":"#ffffff"}},{"type":"ComboBox","props":{"y":71,"x":85,"var":"wordType","skin":"comp/combo_22.png","runtime":"commoncomponent.InputSelect","labels":"label1,label2"}},{"type":"Button","props":{"y":313,"x":164,"width":82,"var":"sureBtn","skin":"comp/button.png","label":"保存","height":24}},{"type":"Button","props":{"y":123,"x":160,"width":82,"var":"selectMeaningBtn","skin":"comp/button.png","label":"选择","height":24}},{"type":"Button","props":{"y":9,"x":164,"width":82,"var":"closeBtn","skin":"comp/button.png","label":"关闭","height":24}}]};
		override protected function createChildren():void {
			View.regComponent("commoncomponent.InputSelect",InputSelect);
			super.createChildren();
			createView(uiView);

		}

	}
}