/**Created by the LayaAirIDE,do not modify.*/
package ui.answerflow {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;

	public class SimpleJsonEditorUI extends Dialog {
		public var editTxt:TextArea;
		public var saveBtn:Button;
		public var cancelBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":371,"height":287},"child":[{"type":"Image","props":{"y":0,"x":0,"top":0,"text":"TextInput","skin":"comp/textinput.png","sizeGrid":"5,5,5,7","right":0,"left":0,"bottom":0}},{"type":"TextArea","props":{"y":10,"x":8,"width":356,"var":"editTxt","text":"TextArea","skin":"comp/textarea.png","sizeGrid":"6,18,8,27","height":240,"color":"#f4eeee"}},{"type":"Button","props":{"y":259,"x":296,"var":"saveBtn","skin":"comp/button.png","label":"save"}},{"type":"Button","props":{"y":257,"x":8,"var":"cancelBtn","skin":"comp/button.png","label":"cancel"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}