/**Created by the LayaAirIDE,do not modify.*/
package ui.simulator {
	import laya.ui.*;
	import laya.display.*; 

	public class ActionItemUI extends View {
		public var actionText:Label;
		public var actionBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":247,"height":25},"child":[{"type":"Label","props":{"y":5,"x":5,"width":80,"var":"actionText","text":"actionTip","styleSkin":"comp/label.png","height":16,"color":"#ea302d"}},{"type":"Button","props":{"y":1,"x":207,"width":40,"var":"actionBtn","skin":"comp/button.png","label":"do","height":24}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}