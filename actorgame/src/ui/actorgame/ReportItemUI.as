/**Created by the LayaAirIDE,do not modify.*/
package ui.actorgame {
	import laya.ui.*;
	import laya.display.*; 

	public class ReportItemUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":539,"height":80},"child":[{"type":"Image","props":{"y":0,"x":0,"width":80,"skin":"comp/image.png","height":80}},{"type":"Image","props":{"y":3,"x":128,"skin":"comp/prop.png"}},{"type":"Image","props":{"y":3,"x":167,"skin":"comp/prop.png"}},{"type":"Image","props":{"y":3,"x":205,"skin":"comp/prop.png"}},{"type":"Image","props":{"y":3,"x":244,"skin":"comp/prop.png"}},{"type":"Label","props":{"y":14,"x":372,"width":167,"text":"+1","styleSkin":"comp/label.png","height":45,"fontSize":30,"color":"#ffffff","align":"center"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}