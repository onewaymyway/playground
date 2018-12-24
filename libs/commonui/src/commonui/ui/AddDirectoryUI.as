/**Created by the LayaAirIDE,do not modify.*/
package commonui.ui {
	import laya.ui.*;
	import laya.display.*; 
	import commonui.view.prop.PropsInputBase;

	public class AddDirectoryUI extends Dialog {
		public var titleTxt:Label;
		public var nameTip:Label;
		public var nameTxt:TextInput;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":500,"scenecolor":"#dddddd","height":250},"child":[{"type":"Image","props":{"y":0,"x":0,"width":500,"skin":"view/bg_dialog.png","height":250,"sizeGrid":"47,20,22,37"}},{"type":"Button","props":{"skin":"view/btn_close.png","name":"close","scaleX":0.5,"scaleY":0.5,"right":11,"y":7}},{"type":"Image","props":{"y":7,"x":9,"width":438,"skin":"comp/blank_title_dragrec.png","name":"drag","height":36}},{"type":"Label","props":{"x":28,"width":140,"var":"titleTxt","text":"新增目录","styleSkin":"comp/label_panel_title.png","height":18,"fontSize":14,"align":"center","color":"#ffffff","centerX":0,"y":16}},{"type":"Label","props":{"y":86,"x":51,"width":92,"var":"nameTip","text":"目录名称：","styleSkin":"comp/label_intro.png","height":18,"fontSize":14,"color":"#C8C8C8"}},{"type":"TextInput","props":{"y":117,"x":51,"width":400,"var":"nameTxt","skin":"comp/input_32.png","color":"#dddddd","sizeGrid":"0,3,0,3","fontSize":14,"padding":"0,4,0,4","height":32}},{"type":"Button","props":{"y":175,"x":190,"skin":"comp/button.png","name":"sure","label":"新增","labelColors":"#FFFFFF,#FFFFFF,#FFFFFF,#c5c5c5","labelSize":16,"sizeGrid":"0,4,0,4"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}