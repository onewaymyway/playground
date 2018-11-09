/**Created by the LayaAirIDE,do not modify.*/
package ui.deskplatform {
	import laya.ui.*;
	import laya.display.*; 

    import laya.utils.ClassUtils;
	public class ResPanelUI extends DragView {
		public var resTree:TreeEx;
		public var resViewer:Image;
		public var opBox:Box;
		public var fliterTxt:TextInput;
		public var clearSearchBtn:Button;
		public var sizeTxt:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"DragView","props":{"width":200,"title":"资源","scenecolor":"#dddddd","hitTestPrior":true,"height":300},"child":[{"type":"Image","props":{"y":48,"x":415,"width":200,"top":0,"skin":"view/bg_panel.png","right":0,"left":0,"height":300,"bottom":0}},{"type":"TreeEx","props":{"y":552,"x":173,"width":196,"var":"resTree","top":112,"scrollBarSkin":"comp/vscroll.png","right":2,"left":2,"hitTestPrior":true,"height":136,"bottom":29},"child":[{"type":"Box","props":{"right":0,"name":"render","left":0},"child":[{"type":"Clip","props":{"y":0,"x":13,"skin":"comp/clip_selectBox.png","right":0,"name":"selectBox","left":9,"height":25,"clipY":2}},{"type":"Image","props":{"y":4,"x":14,"skin":"comp/folder.png","name":"icon","width":16,"height":16}},{"type":"Label","props":{"y":1,"width":150,"text":"label","right":0,"padding":"4,0,0,0","name":"label","left":38,"height":22,"color":"#d8d8d8"}},{"type":"Clip","props":{"y":6,"x":0,"skin":"comp/clip_tree.png","name":"arrow","clipY":2,"width":11,"height":12}}]}]},{"type":"Image","props":{"y":3,"x":222,"width":198,"var":"resViewer","right":1,"left":1,"height":100}},{"type":"Image","props":{"y":106,"x":2,"skin":"comp/line.png","right":0,"left":0,"height":1}},{"type":"Box","props":{"y":271,"x":1,"width":198,"var":"opBox","right":0,"left":0,"height":28,"bottom":0},"child":[{"type":"Image","props":{"width":191,"top":0,"skin":"view/bg_panel_bar.png","right":0,"left":0,"bottom":0}},{"type":"TextInput","props":{"y":4,"x":80,"width":148,"var":"fliterTxt","toolTip":"输入关键词过滤","skin":"comp/input_filter.png","right":5,"padding":"0,10,0,20","left":80,"color":"#dddddd","sizeGrid":"0,3,0,3"}},{"type":"Button","props":{"y":3,"x":3,"toolTip":"打开所在目录","stateNum":3,"skin":"view/login2.png","name":"openDirBtn","scaleX":0.5,"scaleY":0.5}},{"type":"Button","props":{"y":3,"x":29,"toolTip":"设置默认属性","stateNum":3,"skin":"view/settings2.png","name":"setPropBtn","scaleX":0.5,"scaleY":0.5}},{"type":"Button","props":{"y":4,"x":55,"toolTip":"刷新资源树","stateNum":3,"skin":"view/refresh2.png","name":"refreshBtn","scaleX":0.5,"scaleY":0.5}},{"type":"Clip","props":{"y":7,"x":82,"skin":"view/search.png","clipY":1,"index":0,"scaleX":0.5,"scaleY":0.5}},{"type":"Button","props":{"y":12,"var":"clearSearchBtn","skin":"view/btn_close1.png","right":9,"scaleX":0.5,"scaleY":0.5,"stateNum":2}}]},{"type":"Label","props":{"y":82,"x":6,"width":162,"var":"sizeTxt","text":"512*512","padding":"4,0,0,0","name":"label","height":19,"color":"#d8d8d8","align":"left"}}]};
		public function ResPanelUI(){
		createUI(uiView);
		}
		private function createUI(uiData:Object):void
		{

			ClassUtils.createByJson(uiData, this, this);

		}

	}
}