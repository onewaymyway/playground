/**Created by the LayaAirIDE,do not modify.*/
package ui.actorgame {
	import laya.ui.*;
	import laya.display.*; 
	import view.actorgame.StarItem;

	public class ReportItemUI extends View {
		public var icon:Image;
		public var changeTxt:Label;
		public var starList:List;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":539,"height":80},"child":[{"type":"Image","props":{"y":0,"x":0,"width":80,"var":"icon","skin":"comp/image.png","height":80}},{"type":"Label","props":{"y":21,"x":426,"width":99,"var":"changeTxt","text":"+1","styleSkin":"comp/label.png","height":45,"fontSize":30,"color":"#ffffff","align":"center"}},{"type":"List","props":{"y":11,"x":108,"width":301,"var":"starList","spaceY":2,"spaceX":2,"repeatY":2,"repeatX":10,"height":65},"child":[{"type":"StarItem","props":{"runtime":"view.actorgame.StarItem","name":"render"}}]}]};
		override protected function createChildren():void {
			View.regComponent("view.actorgame.StarItem",StarItem);
			super.createChildren();
			createView(uiView);

		}

	}
}