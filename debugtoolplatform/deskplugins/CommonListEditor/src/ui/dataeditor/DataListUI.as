/**Created by the LayaAirIDE,do not modify.*/
package ui.dataeditor {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;
	import ui.dataeditor.DataItemUI;

	public class DataListUI extends View {
		public var itemList:List;
		public var addBtn:Button;
		public var titleTxt:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":542,"height":149},"child":[{"type":"List","props":{"var":"itemList","vScrollBarSkin":"comp/vscroll.png","top":35,"spaceY":5,"spaceX":5,"right":0,"left":0,"bottom":2},"child":[{"type":"DataItem","props":{"name":"render","runtime":"ui.dataeditor.DataItemUI"}}]},{"type":"Button","props":{"width":28,"var":"addBtn","top":1,"skin":"comp/button.png","right":2,"label":"+","height":24}},{"type":"Label","props":{"y":5,"x":7,"width":53,"var":"titleTxt","text":"标题","styleSkin":"comp/label.png","height":15,"color":"#ef3431"}}]};
		override protected function createChildren():void {
			View.regComponent("ui.dataeditor.DataItemUI",DataItemUI);
			super.createChildren();
			createView(uiView);

		}

	}
}