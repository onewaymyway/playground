/**Created by the LayaAirIDE,do not modify.*/
package ui.answerflow {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;
	import ui.answerflow.ItemDataUI;
	import ui.answerflow.ActionRootUI;
	import ui.answerflow.AddAbleNodeUI;

	public class SelectActionUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":400,"height":300},"child":[{"type":"ItemData","props":{"y":109,"x":368,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ItemData","props":{"y":157,"x":368,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ItemData","props":{"y":210,"x":368,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ItemData","props":{"y":259,"x":368,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ItemData","props":{"y":307,"x":368,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ActionRoot","props":{"y":194,"x":21,"runtime":"ui.answerflow.ActionRootUI"}},{"type":"AddAbleNode","props":{"y":209,"x":108,"runtime":"ui.answerflow.AddAbleNodeUI"}},{"type":"AddAbleNode","props":{"y":156,"x":234,"runtime":"ui.answerflow.AddAbleNodeUI"}},{"type":"AddAbleNode","props":{"y":210,"x":233,"runtime":"ui.answerflow.AddAbleNodeUI"}},{"type":"AddAbleNode","props":{"y":277,"x":231,"runtime":"ui.answerflow.AddAbleNodeUI"}}]};
		override protected function createChildren():void {
			View.regComponent("ui.answerflow.ItemDataUI",ItemDataUI);
			View.regComponent("ui.answerflow.ActionRootUI",ActionRootUI);
			View.regComponent("ui.answerflow.AddAbleNodeUI",AddAbleNodeUI);
			super.createChildren();
			createView(uiView);

		}

	}
}