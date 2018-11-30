/**Created by the LayaAirIDE,do not modify.*/
package ui.deskplatform {
	import laya.ui.*;
	import laya.display.*; 
	import filetoolkit.*;

	public class LoginViewUI extends Dialog {
		public var nameTxt:TextInput;
		public var loginBtn:Button;
		public var pwdTxt:TextInput;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":500,"scenecolor":"#dddddd","height":250},"child":[{"type":"Image","props":{"y":0,"x":0,"width":500,"skin":"view/bg_dialog.png","height":250,"sizeGrid":"47,20,22,37"}},{"type":"Button","props":{"skin":"view/btn_close.png","name":"close","scaleX":0.5,"scaleY":0.5,"right":11,"y":7}},{"type":"Image","props":{"y":7,"x":9,"width":439,"skin":"comp/blank_title_dragrec.png","name":"drag","height":36}},{"type":"Label","props":{"x":28,"text":"登录","styleSkin":"comp/label_panel_title.png","fontSize":14,"align":"center","color":"#ffffff","centerX":0,"y":16}},{"type":"Label","props":{"y":80,"x":13,"width":114,"text":"用户名：","styleSkin":"comp/label_intro.png","height":18,"align":"right","fontSize":14,"color":"#C8C8C8"}},{"type":"TextInput","props":{"y":74,"x":128,"width":304,"var":"nameTxt","text":5,"skin":"comp/input_32.png","height":32,"sizeGrid":"0,3,0,3","color":"#CCCCCC","fontSize":14,"padding":"0,4,0,4"}},{"type":"Button","props":{"y":176,"x":190,"width":146,"var":"loginBtn","skin":"comp/button.png","label":"登录","height":24,"labelColors":"#FFFFFF,#FFFFFF,#FFFFFF,#c5c5c5","labelSize":16,"sizeGrid":"0,4,0,4"}},{"type":"Label","props":{"y":131,"x":2,"width":125,"text":"密码：","styleSkin":"comp/label_intro.png","height":18,"align":"right","fontSize":14,"color":"#C8C8C8"}},{"type":"TextInput","props":{"y":124,"x":128,"width":302,"var":"pwdTxt","type":"password","text":8,"skin":"comp/input_32.png","height":32,"sizeGrid":"0,3,0,3","color":"#CCCCCC","fontSize":14,"padding":"0,4,0,4"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}