/**Created by the LayaAirIDE,do not modify.*/
package remotedebugtool.ui.remotedebugtool {
	import laya.ui.*;
	import laya.display.*; 
	import remotedebugtool.view.EditorViewItem;

	public class EditorViewListUI extends View {
		public var viewList:List;
		public var freshBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":213,"height":299},"compId":1,"child":[{"type":"List","props":{"y":0,"x":0,"width":128,"var":"viewList","vScrollBarSkin":"comp/vscroll.png","repeatX":1,"height":299},"compId":2,"child":[{"type":"EditorViewItem","props":{"y":0,"x":0,"runtime":"remotedebugtool.view.EditorViewItem","name":"render"},"compId":6}],"components":[]},{"type":"Button","props":{"y":0,"x":144,"width":66,"var":"freshBtn","skin":"comp/button.png","label":"fresh","height":23},"compId":5}],"loadList":["comp/vscroll.png","remotedebugtool/EditorViewItem.scene","comp/button.png"],"loadList3D":[],"components":[]};
		override protected function createChildren():void {
			View.regComponent("remotedebugtool.view.EditorViewItem",EditorViewItem);
			super.createChildren();
			createView(uiView);

		}

	}
}