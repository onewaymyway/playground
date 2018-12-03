/**Created by the LayaAirIDE,do not modify.*/
package commonui.ui {
	import laya.ui.*;
	import laya.display.*; 

	public class RenameResUI extends Dialog {
		public var nameTxt:TextInput;
		public var resLbl:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":500,"scenecolor":"#dddddd","height":250},"child":[{"type":"Image","props":{"y":0,"x":0,"width":500,"skin":"view/bg_dialog.png","height":250,"sizeGrid":"47,20,22,37"}},{"type":"Button","props":{"skin":"view/btn_close.png","name":"close","scaleX":0.5,"scaleY":0.5,"right":11,"y":7}},{"type":"Image","props":{"y":7,"x":9,"width":446,"skin":"comp/blank_title_dragrec.png","name":"drag","height":36}},{"type":"Label","props":{"x":28,"text":"重命名资源","styleSkin":"comp/label_panel_title.png","fontSize":14,"align":"center","color":"#ffffff","centerX":0,"y":16}},{"type":"Label","props":{"y":104,"x":4,"width":127,"text":"新名称：","styleSkin":"comp/label_intro.png","height":18,"align":"right","fontSize":14,"color":"#C8C8C8"}},{"type":"TextInput","props":{"y":99,"x":135,"width":300,"var":"nameTxt","skin":"comp/input_32.png","sizeGrid":"0,3,0,3","color":"#CCCCCC","fontSize":14,"padding":"0,4,0,4","height":32}},{"type":"Label","props":{"y":65,"x":8,"width":123,"text":"原名称：","styleSkin":"comp/label_intro.png","height":18,"align":"right","fontSize":14,"color":"#C8C8C8"}},{"type":"Label","props":{"y":65,"x":135,"width":214,"var":"resLbl","text":"资源内容","styleSkin":"comp/label_highlight.png","height":20,"color":"#cccc00","fontSize":14}},{"type":"Button","props":{"y":178,"x":85,"skin":"comp/button.png","name":"sure","label":"确定","labelColors":"#FFFFFF,#FFFFFF,#FFFFFF,#c5c5c5","labelSize":16,"sizeGrid":"0,4,0,4"}},{"type":"Button","props":{"y":178,"x":295,"skin":"comp/button.png","name":"cancel","label":"取消","labelColors":"#FFFFFF,#FFFFFF,#FFFFFF,#c5c5c5","labelSize":16,"sizeGrid":"0,4,0,4"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}