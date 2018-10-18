/**Created by the LayaAirIDE,do not modify.*/
package ui.simulator {
	import laya.ui.*;
	import laya.display.*; 
	import view.itemlist.ItemListItem;

	public class ItemListUI extends View {
		public var list:List;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":104,"height":268},"child":[{"type":"List","props":{"y":-1,"x":2,"width":102,"var":"list","height":269},"child":[{"type":"ItemListItem","props":{"runtime":"view.itemlist.ItemListItem","name":"render"}}]}]};
		override protected function createChildren():void {
			View.regComponent("view.itemlist.ItemListItem",ItemListItem);
			super.createChildren();
			createView(uiView);

		}

	}
}