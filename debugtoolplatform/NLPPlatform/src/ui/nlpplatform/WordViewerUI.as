/**Created by the LayaAirIDE,do not modify.*/
package ui.nlpplatform {
	import laya.ui.*;
	import laya.display.*; 
	import commoncomponent.AutoSizeLabel;

	public class WordViewerUI extends View {
		public var txt:AutoSizeLabel;
		public var typeTxt:AutoSizeLabel;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":85,"height":60},"child":[{"type":"Label","props":{"y":30,"x":0,"width":85,"var":"txt","text":"文字","runtime":"commoncomponent.AutoSizeLabel","height":29,"fontSize":20,"color":"#0dcd62"}},{"type":"Label","props":{"y":0,"x":0,"width":85,"var":"typeTxt","text":"文字","runtime":"commoncomponent.AutoSizeLabel","height":29,"fontSize":20,"color":"#eac654"}}]};
		override protected function createChildren():void {
			View.regComponent("commoncomponent.AutoSizeLabel",AutoSizeLabel);
			super.createChildren();
			createView(uiView);

		}

	}
}