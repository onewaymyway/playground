/**Created by the LayaAirIDE,do not modify.*/
package ui.tarot {
	import laya.ui.*;
	import laya.display.*; 

	public class TarotCardUI extends View {
		public var titleTxt:Label;
		public var contentBox:Box;
		public var img:Image;
		public var nameTxt:Label;
		public var detailBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":130,"height":300},"child":[{"type":"Label","props":{"y":4,"x":0,"width":128,"var":"titleTxt","text":"过去","styleSkin":"comp/label.png","height":26,"fontSize":20,"color":"#f6e3e2","align":"center"}},{"type":"Box","props":{"y":29,"x":0,"width":130,"var":"contentBox","height":250},"child":[{"type":"Image","props":{"y":91,"x":65,"width":130,"var":"img","skin":"cards/death.jpg","height":180,"anchorY":0.5,"anchorX":0.5}},{"type":"Label","props":{"y":191,"x":1,"width":128,"var":"nameTxt","text":"Death\\n死亡","styleSkin":"comp/label.png","height":26,"fontSize":20,"color":"#f6e3e2","align":"center"}},{"type":"Button","props":{"y":237,"x":3,"width":125,"var":"detailBtn","skin":"comp/button.png","label":"牌解","height":28,"labelColors":"#fffff"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}