/**Created by the LayaAirIDE,do not modify.*/
package remotedebugtool.ui.test {
	import laya.ui.*;
	import laya.display.*; 

	public class TestOrzUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":374,"height":353,"compId":1,"__$fileRefer":"D:/codes/playground.git/trunk/remotedebugtool/client/Demo/laya/pages/test/TestOrz.scene"},"compId":1,"child":[{"type":"Clip","props":{"y":98,"x":134,"skin":"comp/clip_num.png","compId":2},"compId":2},{"type":"Clip","props":{"y":-3,"x":69,"skin":"comp/clip_selectBox.png","compId":3},"compId":3},{"type":"Button","props":{"y":169,"x":131,"skin":"comp/button.png","label":"label","compId":4},"compId":4},{"type":"Button","props":{"y":35,"x":270,"skin":"comp/btn_close.png","label":"label","compId":5},"compId":5},{"type":"Image","props":{"y":103,"x":35,"skin":"comp/image.png","compId":6},"compId":6}],"loadList":["comp/clip_num.png","comp/clip_selectBox.png","comp/button.png","comp/btn_close.png","comp/image.png"],"loadList3D":[],"components":[]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}