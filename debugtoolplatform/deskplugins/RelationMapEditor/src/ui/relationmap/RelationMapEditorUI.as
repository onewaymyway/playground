/**Created by the LayaAirIDE,do not modify.*/
package ui.relationmap {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;

	public class RelationMapEditorUI extends View {
		public var saveBtn:Button;
		public var optionTab:Tab;
		public var container:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":600,"height":600},"child":[{"type":"Button","props":{"var":"saveBtn","top":12,"skin":"comp/button.png","right":5,"label":"save"}},{"type":"Tab","props":{"y":10,"x":15,"width":242,"var":"optionTab","skin":"comp/tab.png","labels":"操作,节点,线","labelColors":"#ffffff","height":24}},{"type":"Image","props":{"width":600,"var":"container","top":50,"skin":"comp/blank2.png","sizeGrid":"7,13,9,9","right":0,"left":0,"height":540,"bottom":0}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}