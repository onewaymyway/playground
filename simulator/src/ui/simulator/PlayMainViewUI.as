/**Created by the LayaAirIDE,do not modify.*/
package ui.simulator {
	import laya.ui.*;
	import laya.display.*; 
	import view.itemlist.ItemList;
	import view.actionlist.ActionList;

	public class PlayMainViewUI extends View {
		public var itemList:ItemList;
		public var actionList:ActionList;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":577,"height":295},"child":[{"type":"ItemList","props":{"y":17,"x":473,"var":"itemList","runtime":"view.itemlist.ItemList"}},{"type":"ActionList","props":{"x":-1,"width":400,"var":"actionList","top":5,"runtime":"view.actionlist.ActionList","bottom":5}}]};
		override protected function createChildren():void {
			View.regComponent("view.itemlist.ItemList",ItemList);
			View.regComponent("view.actionlist.ActionList",ActionList);
			super.createChildren();
			createView(uiView);

		}

	}
}