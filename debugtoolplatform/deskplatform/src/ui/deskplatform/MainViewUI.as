/**Created by the LayaAirIDE,do not modify.*/
package ui.deskplatform {
	import laya.ui.*;
	import laya.display.*; 
	import view.MainViewItem;

	public class MainViewUI extends View {
		public var itemList:List;
		public var contentBox:Box;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":400,"height":300},"child":[{"type":"List","props":{"x":5,"width":126,"var":"itemList","vScrollBarSkin":"comp/vscroll.png","top":5,"scrollBarSkin":"comp/vscroll.png","repeatX":1,"bottom":5},"child":[{"type":"MainViewItem","props":{"y":0,"x":0,"runtime":"view.MainViewItem","name":"render"}}]},{"type":"Box","props":{"var":"contentBox","top":5,"skin":"comp/blank.png","right":5,"left":150,"bottom":5}}]};
		override protected function createChildren():void {
			View.regComponent("view.MainViewItem",MainViewItem);
			super.createChildren();
			createView(uiView);

		}

	}
}