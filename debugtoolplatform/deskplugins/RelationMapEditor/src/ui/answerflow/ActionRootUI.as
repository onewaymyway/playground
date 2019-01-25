/**Created by the LayaAirIDE,do not modify.*/
package ui.answerflow {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;
	import commonlayout.relationmap.RelationMapItemBase;
	import commoncomponent.AutoSizeTextInput;

	public class ActionRootUI extends MindMapTreeBase {
		public var actionTxt:AutoSizeTextInput;
		public var desTxt:TextInput;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"MindMapTreeBase","props":{"width":63,"height":55},"child":[{"type":"TextInput","props":{"x":0,"width":63,"var":"actionTxt","text":"操作","styleSkin":"comp/label.png","skin":"comp/input_22.png","runtime":"commoncomponent.AutoSizeTextInput","height":21,"color":"#e72320"}},{"type":"TextInput","props":{"y":27,"x":0,"width":67,"var":"desTxt","text":"描述","styleSkin":"comp/label.png","skin":"comp/input_22.png","height":27,"color":"#e72320"}}]};
		override protected function createChildren():void {
			View.regComponent("commoncomponent.AutoSizeTextInput",AutoSizeTextInput);
			super.createChildren();
			createView(uiView);

		}

	}
}