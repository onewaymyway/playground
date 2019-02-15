/**Created by the LayaAirIDE,do not modify.*/
package ui.answerflow {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;
	import commoncomponent.InputSelect;

	public class ItemDataUI extends MindMapTreeBase {
		public var item:InputSelect;
		public var count:TextInput;
		public var removeBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"MindMapTreeBase","props":{"width":200,"height":30},"child":[{"type":"TextInput","props":{"y":4,"x":5,"width":95,"var":"item","text":"物品","skin":"comp/input_22.png","runtime":"commoncomponent.InputSelect","promptColor":"#f31713","height":22,"color":"#e80d09"}},{"type":"TextInput","props":{"y":4,"x":108,"width":60,"var":"count","text":"数量","skin":"comp/input_22.png","height":22,"color":"#ec130f"}},{"type":"Button","props":{"y":3,"x":173,"width":26,"var":"removeBtn","skin":"comp/button.png","label":"-","height":24}}]};
		override protected function createChildren():void {
			View.regComponent("commoncomponent.InputSelect",InputSelect);
			super.createChildren();
			createView(uiView);

		}

	}
}