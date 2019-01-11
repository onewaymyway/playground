/**Created by the LayaAirIDE,do not modify.*/
package ui.answerflow {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;
	import commoncomponent.CommonInput;

	public class ItemListItemUI extends View {
		public var label:CommonInput;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":74,"height":14},"child":[{"type":"TextInput","props":{"y":-1,"x":1,"width":73,"var":"label","text":"label","skin":"comp/input_22.png","runtime":"commoncomponent.CommonInput","height":15,"color":"#ef3431"}}]};
		override protected function createChildren():void {
			View.regComponent("commoncomponent.CommonInput",CommonInput);
			super.createChildren();
			createView(uiView);

		}

	}
}