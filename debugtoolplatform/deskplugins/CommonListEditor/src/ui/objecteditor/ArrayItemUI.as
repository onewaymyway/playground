/**Created by the LayaAirIDE,do not modify.*/
package ui.objecteditor {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;
	import commoncomponent.AutoSizeTextInput;

	public class ArrayItemUI extends MindMapTreeBase {
		public var addBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"MindMapTreeBase","props":{"width":68,"height":24},"child":[{"type":"TextInput","props":{"y":1,"x":2,"width":37,"text":"Array","skin":"comp/input_22.png","runtime":"commoncomponent.AutoSizeTextInput","height":21,"color":"#e72320"}},{"type":"Button","props":{"y":0,"x":42,"width":26,"var":"addBtn","skin":"comp/button.png","label":"+","height":24}}]};
		override protected function createChildren():void {
			View.regComponent("commoncomponent.AutoSizeTextInput",AutoSizeTextInput);
			super.createChildren();
			createView(uiView);

		}

	}
}