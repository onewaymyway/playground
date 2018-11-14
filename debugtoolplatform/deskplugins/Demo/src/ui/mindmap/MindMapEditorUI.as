/**Created by the LayaAirIDE,do not modify.*/
package ui.mindmap {
	import laya.ui.*;
	import laya.display.*; 

	public class MindMapEditorUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":400,"height":300},"child":[{"type":"Button","props":{"top":5,"skin":"comp/button.png","right":5,"label":"保存"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}