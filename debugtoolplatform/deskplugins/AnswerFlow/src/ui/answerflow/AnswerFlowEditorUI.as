/**Created by the LayaAirIDE,do not modify.*/
package ui.answerflow {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;
	import answerflow.Action;

	public class AnswerFlowEditorUI extends View {
		public var actionList:List;
		public var actionEditor:Action;
		public var saveBtn:Button;
		public var itemList:List;
		public var addItemBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":600,"height":600},"child":[{"type":"Label","props":{"y":6,"x":20,"width":53,"text":"操作","styleSkin":"comp/label.png","height":15,"color":"#ef3431"}},{"type":"List","props":{"x":19,"width":67,"var":"actionList","vScrollBarSkin":"comp/vscroll.png","top":30,"bottom":5},"child":[{"type":"Box","props":{"name":"render"},"child":[{"type":"Label","props":{"width":53,"text":"label","styleSkin":"comp/label.png","name":"label","height":15,"color":"#ef3431"}}]}]},{"type":"Action","props":{"var":"actionEditor","top":30,"runtime":"answerflow.Action","right":20,"left":80,"bottom":20}},{"type":"Button","props":{"var":"saveBtn","top":5,"skin":"comp/button.png","right":5,"label":"save"}},{"type":"List","props":{"var":"itemList","vScrollBarSkin":"comp/vscroll.png","top":5,"spaceY":5,"spaceX":5,"right":200,"left":110,"height":39},"child":[{"type":"Box","props":{"name":"render"},"child":[{"type":"TextInput","props":{"width":53,"text":"label","skin":"comp/input_22.png","name":"label","height":15,"color":"#ef3431"}}]}]},{"type":"Button","props":{"width":28,"var":"addItemBtn","top":11,"skin":"comp/button.png","right":151,"label":"+","height":24}}]};
		override protected function createChildren():void {
			View.regComponent("answerflow.Action",Action);
			super.createChildren();
			createView(uiView);

		}

	}
}