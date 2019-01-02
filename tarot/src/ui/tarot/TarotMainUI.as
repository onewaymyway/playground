/**Created by the LayaAirIDE,do not modify.*/
package ui.tarot {
	import laya.ui.*;
	import laya.display.*; 
	import view.tarot.TarotCard;

	public class TarotMainUI extends View {
		public var past:TarotCard;
		public var now:TarotCard;
		public var feature:TarotCard;
		public var detailTxt:Label;
		public var workBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":800,"height":600},"child":[{"type":"TarotCard","props":{"y":40,"x":71,"var":"past","runtime":"view.tarot.TarotCard"}},{"type":"TarotCard","props":{"y":40,"x":327,"var":"now","runtime":"view.tarot.TarotCard"}},{"type":"TarotCard","props":{"y":40,"x":583,"var":"feature","runtime":"view.tarot.TarotCard"}},{"type":"Label","props":{"y":367,"x":66,"wordWrap":true,"width":649,"var":"detailTxt","text":"label","styleSkin":"comp/label.png","height":168,"fontSize":18,"color":"#f4e6e6"}},{"type":"Button","props":{"y":1,"x":1,"width":96,"var":"workBtn","skin":"comp/button.png","label":"预测","height":41}}]};
		override protected function createChildren():void {
			View.regComponent("view.tarot.TarotCard",TarotCard);
			super.createChildren();
			createView(uiView);

		}

	}
}