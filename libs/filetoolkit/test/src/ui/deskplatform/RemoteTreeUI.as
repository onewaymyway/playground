/**Created by the LayaAirIDE,do not modify.*/
package ui.deskplatform {
	import laya.ui.*;
	import laya.display.*; 
	import filetoolkit.*;
	import filetoolkit.FileTree;

	public class RemoteTreeUI extends View {
		public var resTree:FileTree;
		public var opBox:Box;
		public var fliterTxt:TextInput;
		public var clearSearchBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":200,"title":"资源","scenecolor":"#dddddd","hitTestPrior":true,"height":300},"child":[{"type":"Image","props":{"y":48,"x":415,"width":200,"top":0,"skin":"view/bg_panel.png","right":0,"left":0,"height":300,"bottom":0}},{"type":"TreeEx","props":{"x":173,"width":196,"var":"resTree","top":2,"scrollBarSkin":"comp/vscroll.png","runtime":"filetoolkit.FileTree","right":2,"left":2,"hitTestPrior":true,"height":136,"bottom":29},"child":[{"type":"Box","props":{"right":0,"name":"render","left":0},"child":[{"type":"Clip","props":{"y":0,"x":13,"skin":"comp/clip_selectBox.png","right":0,"name":"selectBox","left":9,"height":25,"clipY":2}},{"type":"Image","props":{"y":4,"x":14,"skin":"comp/folder.png","name":"icon","width":16,"height":16}},{"type":"Label","props":{"y":1,"width":150,"text":"label","right":0,"padding":"4,0,0,0","name":"label","left":38,"height":22,"color":"#d8d8d8"}},{"type":"Clip","props":{"y":6,"x":0,"skin":"comp/clip_tree.png","name":"arrow","clipY":2,"width":11,"height":12}}]}]},{"type":"Box","props":{"y":271,"x":1,"width":198,"var":"opBox","right":0,"left":0,"height":28,"bottom":0},"child":[{"type":"Image","props":{"width":191,"top":0,"skin":"view/bg_panel_bar.png","right":0,"left":0,"bottom":0}},{"type":"TextInput","props":{"y":4,"var":"fliterTxt","toolTip":"输入关键词过滤","skin":"comp/input_22.png","right":5,"padding":"0,10,0,20","left":60,"height":22,"color":"#dddddd","sizeGrid":"0,3,0,3"}},{"type":"Button","props":{"y":3,"x":5,"toolTip":"设置默认属性","stateNum":3,"skin":"view/settings2.png","name":"setPropBtn","scaleX":0.5,"scaleY":0.5}},{"type":"Button","props":{"y":4,"x":31,"toolTip":"刷新资源树","stateNum":3,"skin":"view/refresh2.png","name":"refreshBtn","scaleX":0.5,"scaleY":0.5}},{"type":"Clip","props":{"y":7,"x":66,"skin":"view/search.png","clipY":1,"index":0,"scaleX":0.5,"scaleY":0.5}},{"type":"Button","props":{"y":12,"var":"clearSearchBtn","skin":"view/btn_close1.png","right":9,"scaleX":0.5,"scaleY":0.5,"stateNum":2}}]}]};
		override protected function createChildren():void {
			View.regComponent("filetoolkit.FileTree",FileTree);
			super.createChildren();
			createView(uiView);

		}

	}
}