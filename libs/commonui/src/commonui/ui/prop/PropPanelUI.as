/**Created by the LayaAirIDE,do not modify.*/
package commonui.ui.prop {
	import laya.ui.*;
	import laya.display.*; 
	import commonui.view.prop.PropsInputBase;

	public class PropPanelUI extends View {
		public var typeLbl:Label;
		public var propFootBox:Box;
		public var propAddBtn:Button;
		public var cancelBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"title":"属性","scenecolor":"#dddddd","recTabSkin":"view/tab_proppanel.png","recBarSkin":"view/bg_proppanel_bar.png","recActionType":"toRight","recActionPos":"right","mouseEnabled":true,"minWidth":220,"hitTestPrior":true},"child":[{"type":"Image","props":{"y":0,"x":0,"width":200,"top":0,"skin":"view/backmain.png","sizeGrid":"7,8,5,9","right":0,"left":0,"height":300,"bottom":0}},{"type":"Label","props":{"y":12,"x":16,"var":"typeLbl","text":"label","styleSkin":"comp/label_highlight.png","fontSize":20,"bold":true,"color":"#cccc00"}},{"type":"Box","props":{"y":304,"x":10,"width":180,"var":"propFootBox","right":10,"left":10,"height":38},"child":[{"type":"Button","props":{"y":7,"x":20,"width":126,"var":"propAddBtn","stateNum":2,"skin":"comp/btn_addcomp.png","sizeGrid":"2,2,2,30","right":5,"left":5,"label":"添加组件","height":21,"labelColors":"#FFFFFF,#FFFFFF,#FFFFFF"}}]},{"type":"Button","props":{"var":"cancelBtn","top":5,"skin":"view/btn_close.png","right":5,"scaleX":0.5,"scaleY":0.5,"y":7}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}