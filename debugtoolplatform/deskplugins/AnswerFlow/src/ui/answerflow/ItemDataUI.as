/**Created by the LayaAirIDE,do not modify.*/
package ui.answerflow {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;

	public class ItemDataUI extends MindMapTreeBase {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"MindMapTreeBase","props":{"width":168,"height":30},"child":[{"type":"TextInput","props":{"y":4,"x":5,"width":95,"text":"物品","skin":"comp/input_22.png","promptColor":"#f31713","height":22,"color":"#e80d09"}},{"type":"TextInput","props":{"y":4,"x":108,"width":60,"text":"数量","skin":"comp/input_22.png","height":22,"color":"#ec130f"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}