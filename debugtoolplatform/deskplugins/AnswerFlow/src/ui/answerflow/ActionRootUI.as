/**Created by the LayaAirIDE,do not modify.*/
package ui.answerflow {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;

	public class ActionRootUI extends MindMapTreeBase {
		public var actionTxt:Label;
		public var desTxt:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"MindMapTreeBase","props":{"width":63,"height":55},"child":[{"type":"Label","props":{"y":4,"x":0,"width":63,"var":"actionTxt","text":"操作","styleSkin":"comp/label.png","height":21,"color":"#e72320"}},{"type":"Label","props":{"y":34,"x":-2,"width":51,"var":"desTxt","text":"描述","styleSkin":"comp/label.png","height":21,"color":"#e72320"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}