/**Created by the LayaAirIDE,do not modify.*/
package ui.nlpplatform {
	import laya.ui.*;
	import laya.display.*; 

	public class RelationPropUI extends View {
		public var relationSelect:ComboBox;
		public var saveBtn:Button;
		public var revertBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":250,"height":73},"child":[{"type":"Label","props":{"y":0,"x":41,"width":57,"text":"关系","styleSkin":"comp/label.png","height":31,"fontSize":20,"color":"#ffffff"}},{"type":"ComboBox","props":{"y":3,"x":109,"width":141,"var":"relationSelect","skin":"comp/combo_22.png","labels":"label1,label2","height":22}},{"type":"Button","props":{"y":49,"x":146,"width":82,"var":"saveBtn","skin":"comp/button.png","label":"保存","height":24}},{"type":"Button","props":{"y":48,"x":14,"width":82,"var":"revertBtn","skin":"comp/button.png","label":"反向","height":24}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}