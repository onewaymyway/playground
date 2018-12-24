/**Created by the LayaAirIDE,do not modify.*/
package commonui.ui.prop {
	import laya.ui.*;
	import laya.display.*; 
	import commonui.view.prop.PropsInputBase;

	public class PropGroupUI extends View {
		public var groupBar:Image;
		public var groupLabl:Label;
		public var arrowClip:Clip;
		public var groupBox:VBox;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"scenecolor":"#dddddd","hitTestPrior":true},"child":[{"type":"Image","props":{"y":76,"width":100,"var":"groupBar","sizeGrid":"0,4,0,4","right":0,"mouseEnabled":true,"left":0,"height":30}},{"type":"Label","props":{"y":81,"x":36,"width":109,"var":"groupLabl","text":"label","mouseEnabled":false,"mouseChildren":false,"height":20,"fontSize":20,"color":"#006666"}},{"type":"Clip","props":{"y":79,"x":4,"width":26,"var":"arrowClip","skin":"comp/clip_tree_arrow.png","scaleY":1,"scaleX":1,"mouseEnabled":false,"mouseChildren":false,"height":26,"clipY":2}},{"type":"VBox","props":{"y":107,"var":"groupBox","right":0,"mouseEnabled":true,"left":0},"child":[{"type":"Button","props":{"y":17,"x":8,"skin":"comp/button.png","labelColors":"#dddddd,#dddddd,#dddddd","label":"label","labelSize":16,"sizeGrid":"0,4,0,4"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}