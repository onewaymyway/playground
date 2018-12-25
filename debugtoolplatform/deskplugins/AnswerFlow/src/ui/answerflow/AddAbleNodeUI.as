/**Created by the LayaAirIDE,do not modify.*/
package ui.answerflow {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;

	public class AddAbleNodeUI extends MindMapTreeBase {
		public var txt:Label;
		public var addBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"MindMapTreeBase","props":{"width":105,"height":23},"child":[{"type":"Label","props":{"y":2,"x":0,"width":63,"var":"txt","text":"触发方式","styleSkin":"comp/label.png","height":21,"color":"#e72320"}},{"type":"Button","props":{"y":0,"x":79,"width":26,"var":"addBtn","skin":"comp/button.png","label":"+","height":24}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}