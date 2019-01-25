/**Created by the LayaAirIDE,do not modify.*/
package ui.relationmap {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;
	import commonlayout.relationmap.RelationMapItemBase;
	import commoncomponent.CommonInput;

	public class RelationLineUI extends RelationMapItemBase {
		public var input:CommonInput;
		public var startPoint:Radio;
		public var endPoint:Radio;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"RelationMapItemBase","props":{"width":95,"height":22},"child":[{"type":"TextInput","props":{"width":95,"var":"input","text":"物品","skin":"comp/input_22.png","runtime":"commoncomponent.CommonInput","promptColor":"#f31713","height":22,"color":"#e80d09"}},{"type":"Radio","props":{"y":-29,"x":-35,"var":"startPoint","skin":"comp/radio.png"}},{"type":"Radio","props":{"y":-43,"x":120,"var":"endPoint","skin":"comp/radio.png"}}]};
		override protected function createChildren():void {
			View.regComponent("commoncomponent.CommonInput",CommonInput);
			super.createChildren();
			createView(uiView);

		}

	}
}