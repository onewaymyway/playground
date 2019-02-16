/**Created by the LayaAirIDE,do not modify.*/
package ui.objecteditor {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;
	import commoncomponent.AutoSizeTextInput;

	public class ValueItemUI extends MindMapTreeBase {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"MindMapTreeBase","props":{"width":89,"height":22},"child":[{"type":"TextInput","props":{"y":1,"x":1,"width":88,"text":"Value","skin":"comp/input_22.png","runtime":"commoncomponent.AutoSizeTextInput","height":21,"color":"#e72320"}}]};
		override protected function createChildren():void {
			View.regComponent("commoncomponent.AutoSizeTextInput",AutoSizeTextInput);
			super.createChildren();
			createView(uiView);

		}

	}
}