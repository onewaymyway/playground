/**Created by the LayaAirIDE,do not modify.*/
package ui.simulator {
	import laya.ui.*;
	import laya.display.*; 
	import view.itemlist.ItemList;
	import view.actionlist.ActionList;

	public class PlayMainViewUI extends View {
		public var itemList:ItemList;
		public var actionList:ActionList;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":577,"height":295},"child":[{"type":"ItemList","props":{"x":473,"var":"itemList","top":50,"runtime":"view.itemlist.ItemList","bottom":0}},{"type":"ActionList","props":{"x":-1,"width":400,"var":"actionList","top":50,"runtime":"view.actionlist.ActionList","bottom":5}},{"type":"Label","props":{"y":9,"x":456,"width":92,"text":"you have:","styleSkin":"comp/label.png","height":18,"color":"#2defc0"}}]};
		override protected function createChildren():void {
			View.regComponent("view.itemlist.ItemList",ItemList);
			View.regComponent("view.actionlist.ActionList",ActionList);
			super.createChildren();
			createView(uiView);

		}

	}
}