/**Created by the LayaAirIDE,do not modify.*/
package ui.actorgame {
	import laya.ui.*;
	import laya.display.*; 
	import view.actorgame.StarItem;

	public class ReportItemUI extends View {
		public var icon:Image;
		public var changeTxt:Label;
		public var starList:List;
		public var nameTxt:Label;
		public var moneyChangeTxt:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":539,"height":80},"child":[{"type":"Image","props":{"y":0,"x":0,"width":80,"var":"icon","skin":"comp/image.png","height":80}},{"type":"Label","props":{"y":21,"x":416,"width":57,"var":"changeTxt","text":"+1","styleSkin":"comp/label.png","height":45,"fontSize":30,"color":"#ffffff","align":"center"}},{"type":"List","props":{"y":11,"x":108,"width":301,"var":"starList","spaceY":2,"spaceX":2,"repeatY":2,"repeatX":10,"height":65},"child":[{"type":"StarItem","props":{"runtime":"view.actorgame.StarItem","name":"render"}}]},{"type":"Label","props":{"y":53,"x":1,"width":79,"var":"nameTxt","text":"名字","styleSkin":"comp/label.png","height":28,"fontSize":22,"color":"#ffffff","align":"center"}},{"type":"Label","props":{"y":23,"x":485,"width":57,"var":"moneyChangeTxt","text":"+5000","styleSkin":"comp/label.png","height":45,"fontSize":30,"color":"#e33c39","align":"center"}}]};
		override protected function createChildren():void {
			View.regComponent("view.actorgame.StarItem",StarItem);
			super.createChildren();
			createView(uiView);

		}

	}
}