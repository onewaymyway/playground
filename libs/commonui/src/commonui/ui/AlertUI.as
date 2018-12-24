/**Created by the LayaAirIDE,do not modify.*/
package commonui.ui {
	import laya.ui.*;
	import laya.display.*; 
	import commonui.view.prop.PropsInputBase;

	public class AlertUI extends Dialog {
		public var titleLbl:Label;
		public var msgLbl:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":500,"scenecolor":"#dddddd","height":250},"child":[{"type":"Image","props":{"y":0,"x":0,"width":500,"skin":"view/bg_dialog.png","height":250,"sizeGrid":"47,20,22,37"}},{"type":"Button","props":{"x":404,"skin":"view/btn_close.png","name":"close","scaleX":0.5,"scaleY":0.5,"right":11,"y":7}},{"type":"Image","props":{"y":7,"x":9,"width":442,"skin":"comp/blank_title_dragrec.png","name":"drag","height":36}},{"type":"Label","props":{"x":28,"var":"titleLbl","text":"提示","styleSkin":"comp/label_panel_title.png","fontSize":14,"align":"center","color":"#ffffff","centerX":0,"y":16}},{"type":"Label","props":{"y":80,"x":39,"wordWrap":true,"width":422,"var":"msgLbl","valign":"middle","text":"确认内容","styleSkin":"comp/label_intro.png","multiline":true,"mouseEnabled":false,"mouseChildren":false,"isHtml":true,"height":65,"align":"center","fontSize":14,"color":"#C8C8C8"}},{"type":"Button","props":{"y":173,"x":190,"skin":"comp/button.png","name":"sure","label":"确定","labelColors":"#FFFFFF,#FFFFFF,#FFFFFF,#c5c5c5","labelSize":16,"sizeGrid":"0,4,0,4"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}