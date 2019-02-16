/**Created by the LayaAirIDE,do not modify.*/
package ui.objecteditor {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;

	public class ObjectItemUI extends MindMapTreeBase {
		public var addBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"MindMapTreeBase","props":{"width":75,"height":24},"child":[{"type":"TextInput","props":{"y":1,"x":0,"width":45,"text":"Object","skin":"comp/input_22.png","height":21,"editable":false,"color":"#e72320"}},{"type":"Button","props":{"y":0,"x":49,"width":26,"var":"addBtn","skin":"comp/button.png","label":"+","height":24}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}