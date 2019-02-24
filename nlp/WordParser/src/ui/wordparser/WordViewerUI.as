/**Created by the LayaAirIDE,do not modify.*/
package ui.wordparser {
	import laya.ui.*;
	import laya.display.*; 
	import commoncomponent.AutoSizeLabel;

	public class WordViewerUI extends View {
		public var txt:AutoSizeLabel;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":85,"height":29},"child":[{"type":"Label","props":{"y":0,"x":0,"width":85,"var":"txt","text":"文字","runtime":"commoncomponent.AutoSizeLabel","height":29,"fontSize":20,"color":"#f4e4e4"}}]};
		override protected function createChildren():void {
			View.regComponent("commoncomponent.AutoSizeLabel",AutoSizeLabel);
			super.createChildren();
			createView(uiView);

		}

	}
}