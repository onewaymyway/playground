/**Created by the LayaAirIDE,do not modify.*/
package ui.answerflow {
	import laya.ui.*;
	import laya.display.*; 
	import commonlayout.mindmaptree.MindMapTreeBase;
	import commonlayout.relationmap.RelationMapItemBase;

	public class SimpleNodeUI extends MindMapTreeBase {
		public var txt:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"MindMapTreeBase","props":{"width":63,"height":21},"child":[{"type":"Label","props":{"width":63,"var":"txt","text":"触发方式","styleSkin":"comp/label.png","height":21,"color":"#e72320"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}