/**Created by the LayaAirIDE,do not modify.*/
package ui.answerflow {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;
	import ui.answerflow.ActionUI;

	public class AnswerFlowEditorUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":600,"height":600},"child":[{"type":"Label","props":{"y":6,"x":20,"width":53,"text":"操作","styleSkin":"comp/label.png","height":15,"color":"#ef3431"}},{"type":"List","props":{"x":19,"width":67,"top":30,"bottom":5},"child":[{"type":"Box","props":{"name":"render"},"child":[{"type":"Label","props":{"width":53,"text":"label","styleSkin":"comp/label.png","height":15,"color":"#ef3431"}}]}]},{"type":"Action","props":{"y":1,"x":83,"runtime":"ui.answerflow.ActionUI"}},{"type":"Button","props":{"top":5,"skin":"comp/button.png","right":5,"label":"label"}}]};
		override protected function createChildren():void {
			View.regComponent("ui.answerflow.ActionUI",ActionUI);
			super.createChildren();
			createView(uiView);

		}

	}
}