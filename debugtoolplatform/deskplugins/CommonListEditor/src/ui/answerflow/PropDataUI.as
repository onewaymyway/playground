/**Created by the LayaAirIDE,do not modify.*/
package ui.answerflow {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;

	public class PropDataUI extends MindMapTreeBase {
		public var keyInput:TextInput;
		public var valueInput:TextInput;
		public var removeBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"MindMapTreeBase","props":{"width":200,"height":30},"child":[{"type":"TextInput","props":{"y":4,"x":5,"width":63,"var":"keyInput","text":"key","skin":"comp/input_22.png","promptColor":"#f31713","height":22,"color":"#e80d09"}},{"type":"TextInput","props":{"y":4,"x":79,"width":89,"var":"valueInput","text":"value","skin":"comp/input_22.png","height":22,"color":"#ec130f"}},{"type":"Button","props":{"y":3,"x":173,"width":26,"var":"removeBtn","skin":"comp/button.png","label":"-","height":24}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}