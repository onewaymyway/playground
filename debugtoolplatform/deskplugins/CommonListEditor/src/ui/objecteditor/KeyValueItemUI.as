/**Created by the LayaAirIDE,do not modify.*/
package ui.objecteditor {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;
	import commoncomponent.AutoSizeTextInput;

	public class KeyValueItemUI extends MindMapTreeBase {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"MindMapTreeBase","props":{"width":143,"height":23},"child":[{"type":"TextInput","props":{"y":-1,"x":0,"width":45,"text":"key","skin":"comp/input_22.png","runtime":"commoncomponent.AutoSizeTextInput","height":21,"color":"#e72320"}},{"type":"TextInput","props":{"y":0,"x":59,"width":45,"text":"value","skin":"comp/input_22.png","runtime":"commoncomponent.AutoSizeTextInput","height":21,"color":"#e72320"}},{"type":"Button","props":{"y":-1,"x":117,"width":26,"skin":"comp/button.png","label":"-","height":24}}]};
		override protected function createChildren():void {
			View.regComponent("commoncomponent.AutoSizeTextInput",AutoSizeTextInput);
			super.createChildren();
			createView(uiView);

		}

	}
}