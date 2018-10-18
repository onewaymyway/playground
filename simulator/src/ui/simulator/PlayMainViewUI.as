/**Created by the LayaAirIDE,do not modify.*/
package ui.simulator {
	import laya.ui.*;
	import laya.display.*; 
	import view.itemlist.ItemList;
	import view.actionlist.ActionList;

	public class PlayMainViewUI extends View {
		public var itemList:ItemList;
		public var actionList:ActionList;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":400,"height":300},"child":[{"type":"ItemList","props":{"y":12,"x":289,"var":"itemList","runtime":"view.itemlist.ItemList"}},{"type":"ActionList","props":{"y":-1,"x":-1,"var":"actionList","runtime":"view.actionlist.ActionList"}}]};
		override protected function createChildren():void {
			View.regComponent("view.itemlist.ItemList",ItemList);
			View.regComponent("view.actionlist.ActionList",ActionList);
			super.createChildren();
			createView(uiView);

		}

	}
}