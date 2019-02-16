/**Created by the LayaAirIDE,do not modify.*/
package ui.objecteditor {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;

	public class ObjectEditorUI extends View {
		public var content:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":720,"height":1280},"child":[{"type":"Image","props":{"top":0,"text":"TextInput","skin":"comp/input_22.png","sizeGrid":"8,11,8,8","right":0,"left":0,"bottom":0}},{"type":"Image","props":{"var":"content","top":100,"text":"TextInput","skin":"comp/input_22_selected.png","sizeGrid":"8,9,6,8","right":5,"left":5,"bottom":5}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}