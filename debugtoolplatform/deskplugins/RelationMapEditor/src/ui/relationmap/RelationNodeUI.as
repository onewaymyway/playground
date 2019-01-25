/**Created by the LayaAirIDE,do not modify.*/
package ui.relationmap {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;
	import commonlayout.relationmap.RelationMapItemBase;
	import commoncomponent.CommonInput;

	public class RelationNodeUI extends RelationMapItemBase {
		public var input:CommonInput;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"RelationMapItemBase","props":{"width":95,"height":22},"child":[{"type":"TextInput","props":{"width":95,"var":"input","text":"物品","skin":"comp/input_22.png","runtime":"commoncomponent.CommonInput","promptColor":"#f31713","height":22,"color":"#e80d09"}}]};
		override protected function createChildren():void {
			View.regComponent("commoncomponent.CommonInput",CommonInput);
			super.createChildren();
			createView(uiView);

		}

	}
}