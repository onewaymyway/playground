/**Created by the LayaAirIDE,do not modify.*/
package ui.answerflow {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;

	public class DataOperateUI extends MindMapTreeBase {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"MindMapTreeBase","props":{"width":240,"height":30},"child":[{"type":"TextInput","props":{"y":4,"x":10,"width":95,"text":"TextInput","skin":"comp/input_22.png","promptColor":"#f31713","height":22,"color":"#e80d09"}},{"type":"ComboBox","props":{"y":5,"x":114,"width":53,"skin":"comp/combobox.png","sizeGrid":"0,31,0,0","selectedIndex":0,"labels":"+,-","height":22}},{"type":"TextInput","props":{"y":5,"x":174,"width":60,"text":"TextInput","skin":"comp/input_22.png","height":22,"color":"#ec130f"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}