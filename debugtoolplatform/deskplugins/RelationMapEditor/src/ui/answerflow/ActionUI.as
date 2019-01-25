/**Created by the LayaAirIDE,do not modify.*/
package ui.answerflow {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;
	import commonlayout.relationmap.RelationMapItemBase;
	import ui.answerflow.ItemDataUI;
	import ui.answerflow.ActionRootUI;
	import ui.answerflow.SimpleNodeUI;
	import ui.answerflow.AddAbleNodeUI;

	public class ActionUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":400,"height":500},"child":[{"type":"ItemData","props":{"y":234,"x":279,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ItemData","props":{"y":280,"x":279,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ItemData","props":{"y":335,"x":279,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ItemData","props":{"y":375,"x":279,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ItemData","props":{"y":417,"x":279,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ItemData","props":{"y":41,"x":188,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ItemData","props":{"y":93,"x":187,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ItemData","props":{"y":141,"x":190,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ActionRoot","props":{"y":184,"x":11,"runtime":"ui.answerflow.ActionRootUI"}},{"type":"SimpleNode","props":{"y":302,"x":88,"runtime":"ui.answerflow.SimpleNodeUI"}},{"type":"AddAbleNode","props":{"y":98,"x":80,"runtime":"ui.answerflow.AddAbleNodeUI"}},{"type":"AddAbleNode","props":{"y":264,"x":160,"runtime":"ui.answerflow.AddAbleNodeUI"}},{"type":"AddAbleNode","props":{"y":378,"x":155,"runtime":"ui.answerflow.AddAbleNodeUI"}}]};
		override protected function createChildren():void {
			View.regComponent("ui.answerflow.ItemDataUI",ItemDataUI);
			View.regComponent("ui.answerflow.ActionRootUI",ActionRootUI);
			View.regComponent("ui.answerflow.SimpleNodeUI",SimpleNodeUI);
			View.regComponent("ui.answerflow.AddAbleNodeUI",AddAbleNodeUI);
			super.createChildren();
			createView(uiView);

		}

	}
}