/**Created by the LayaAirIDE,do not modify.*/
package ui.debugplatform.chrome {
	import laya.ui.*;
	import laya.display.*; 

	public class DomainListItemUI extends View {
		public var label:Label;
		public var debugCheck:CheckBox;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":134,"height":25},"child":[{"type":"Box","props":{"y":1,"right":0,"left":0,"height":24},"child":[{"type":"Clip","props":{"y":0,"x":0,"width":196,"skin":"comp/clip_selectBox.png","right":0,"name":"selectBox","left":0,"height":24,"clipY":2}},{"type":"Label","props":{"y":1,"var":"label","text":"label","right":0,"padding":"4,0,0,0","left":0,"height":22,"color":"#d8d8d8"}},{"type":"CheckBox","props":{"y":5,"width":51,"var":"debugCheck","skin":"comp/checkbox.png","right":0,"label":"调试","height":15}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}