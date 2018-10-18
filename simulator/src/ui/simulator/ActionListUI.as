/**Created by the LayaAirIDE,do not modify.*/
package ui.simulator {
	import laya.ui.*;
	import laya.display.*; 
	import view.actionlist.ActionItem;

	public class ActionListUI extends View {
		public var list:List;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":133,"height":291},"child":[{"type":"List","props":{"y":2,"x":3,"width":130,"var":"list","height":289},"child":[{"type":"ActionItem","props":{"y":0,"x":-1,"runtime":"view.actionlist.ActionItem","name":"render"}}]}]};
		override protected function createChildren():void {
			View.regComponent("view.actionlist.ActionItem",ActionItem);
			super.createChildren();
			createView(uiView);

		}

	}
}