/**Created by the LayaAirIDE,do not modify.*/
package ui.deskplatform {
	import laya.ui.*;
	import laya.display.*; 

	public class ConfirmUI extends Dialog {
		public var titleLbl:Label;
		public var msgLbl:Label;
		public var cancelBtn:Button;
		public var okBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":500,"scenecolor":"#dddddd","height":250},"child":[{"type":"Image","props":{"y":0,"x":0,"width":500,"skin":"view/bg_dialog.png","height":250,"sizeGrid":"47,20,22,37"}},{"type":"Button","props":{"x":404,"skin":"view/btn_close.png","name":"close","scaleX":0.5,"scaleY":0.5,"right":11,"y":7}},{"type":"Image","props":{"y":7,"x":9,"width":441,"skin":"comp/blank_title_dragrec.png","name":"drag","height":36}},{"type":"Label","props":{"x":21,"var":"titleLbl","text":"确认框","styleSkin":"comp/label_panel_title.png","fontSize":14,"align":"center","color":"#ffffff","centerX":0,"y":16}},{"type":"Label","props":{"y":68,"x":36,"wordWrap":true,"width":427,"var":"msgLbl","valign":"middle","text":"确认内容","styleSkin":"comp/label_intro.png","multiline":true,"mouseEnabled":false,"mouseChildren":false,"isHtml":true,"height":76,"align":"center","fontSize":14,"color":"#C8C8C8"}},{"type":"Button","props":{"y":165,"x":288,"var":"cancelBtn","skin":"comp/btn.png","name":"cancel","label":"取消","labelColors":"#FFFFFF,#FFFFFF,#FFFFFF,#c5c5c5","labelSize":16,"sizeGrid":"0,4,0,4"}},{"type":"Button","props":{"y":165,"x":98,"var":"okBtn","skin":"comp/button.png","name":"sure","label":"确定","labelColors":"#FFFFFF,#FFFFFF,#FFFFFF,#c5c5c5","labelSize":16,"sizeGrid":"0,4,0,4"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}