/**Created by the LayaAirIDE,do not modify.*/
package ui.objecteditor {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;
	import ui.objecteditor.ObjectItemUI;
	import ui.objecteditor.KeyItemUI;
	import ui.objecteditor.ValueItemUI;
	import ui.objecteditor.ArrayItemUI;

	public class ObjectEditorTestUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":720,"height":1280},"child":[{"type":"ObjectItem","props":{"y":542,"x":156,"runtime":"ui.objecteditor.ObjectItemUI"}},{"type":"KeyItem","props":{"y":517,"x":242,"runtime":"ui.objecteditor.KeyItemUI"}},{"type":"ValueItem","props":{"y":518,"x":353,"runtime":"ui.objecteditor.ValueItemUI"}},{"type":"KeyItem","props":{"y":557,"x":243,"runtime":"ui.objecteditor.KeyItemUI"}},{"type":"ValueItem","props":{"y":557,"x":350,"runtime":"ui.objecteditor.ValueItemUI"}},{"type":"KeyItem","props":{"y":605,"x":245,"runtime":"ui.objecteditor.KeyItemUI"}},{"type":"ArrayItem","props":{"y":603,"x":352,"runtime":"ui.objecteditor.ArrayItemUI"}},{"type":"ValueItem","props":{"y":599,"x":444,"runtime":"ui.objecteditor.ValueItemUI"}},{"type":"ValueItem","props":{"y":636,"x":445,"runtime":"ui.objecteditor.ValueItemUI"}},{"type":"ValueItem","props":{"y":671,"x":441,"runtime":"ui.objecteditor.ValueItemUI"}},{"type":"KeyItem","props":{"y":723,"x":248,"runtime":"ui.objecteditor.KeyItemUI"}},{"type":"ObjectItem","props":{"y":722,"x":348,"runtime":"ui.objecteditor.ObjectItemUI"}}]};
		override protected function createChildren():void {
			View.regComponent("ui.objecteditor.ObjectItemUI",ObjectItemUI);
			View.regComponent("ui.objecteditor.KeyItemUI",KeyItemUI);
			View.regComponent("ui.objecteditor.ValueItemUI",ValueItemUI);
			View.regComponent("ui.objecteditor.ArrayItemUI",ArrayItemUI);
			super.createChildren();
			createView(uiView);

		}

	}
}