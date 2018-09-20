/**Created by the LayaAirIDE,do not modify.*/
package remotedebugtool.ui.remotedebugtool {
	import laya.ui.*;
	import laya.display.*; 

	public class EditorViewItemUI extends View {
		public var label:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":112,"height":30,"compId":1,"__$fileRefer":"D:/codes/playground.git/trunk/remotedebugtool/client/Demo/laya/pages/remotedebugtool/EditorViewItem.scene"},"compId":1,"child":[{"type":"Box","props":{"y":0,"x":0,"width":112,"height":30,"compId":2},"compId":2,"child":[{"type":"Label","props":{"y":5,"x":6,"width":97,"var":"label","text":"this is a list","skin":"comp/label.png","height":20,"fontSize":14,"color":"#e82623","compId":3},"compId":3}],"components":[]}],"loadList":["comp/label.png"],"loadList3D":[],"components":[]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}