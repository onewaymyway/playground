/**Created by the LayaAirIDE,do not modify.*/
package ui.simulator {
	import laya.ui.*;
	import laya.display.*; 

	public class ItemListItemUI extends View {
		public var itemText:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":102,"height":18},"child":[{"type":"Label","props":{"y":0,"x":0,"width":102,"var":"itemText","text":"label","styleSkin":"comp/label.png","height":18,"color":"#2e92ef"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}