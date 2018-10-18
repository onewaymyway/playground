/**Created by the LayaAirIDE,do not modify.*/
package ui.simulator {
	import laya.ui.*;
	import laya.display.*; 
	import view.actionlist.ActionItem;

	public class ActionListUI extends View {
		public var list:List;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":258,"height":291},"child":[{"type":"List","props":{"var":"list","top":0,"right":0,"repeatX":1,"left":0,"bottom":0},"child":[{"type":"ActionItem","props":{"y":0,"runtime":"view.actionlist.ActionItem","right":2,"name":"render","left":2}}]}]};
		override protected function createChildren():void {
			View.regComponent("view.actionlist.ActionItem",ActionItem);
			super.createChildren();
			createView(uiView);

		}

	}
}