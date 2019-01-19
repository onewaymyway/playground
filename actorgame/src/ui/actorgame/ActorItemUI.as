/**Created by the LayaAirIDE,do not modify.*/
package ui.actorgame {
	import laya.ui.*;
	import laya.display.*; 

	public class ActorItemUI extends View {
		public var icon:Image;
		public var nameTxt:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":177,"height":275},"child":[{"type":"Image","props":{"y":0,"x":0,"width":177,"var":"icon","skin":"comp/image.png","height":177}},{"type":"Label","props":{"y":230,"x":1,"width":167,"var":"nameTxt","text":"名字","styleSkin":"comp/label.png","height":45,"fontSize":30,"color":"#ffffff","align":"center"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}