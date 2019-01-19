/**Created by the LayaAirIDE,do not modify.*/
package ui.actorgame {
	import laya.ui.*;
	import laya.display.*; 
	import ui.actorgame.ActorItemUI;

	public class GameMainUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":720,"height":1280},"child":[{"type":"Button","props":{"y":959,"x":234,"width":252,"skin":"comp/button.png","labelSize":30,"labelColors":"#ffffff","label":"开始","height":97}},{"type":"List","props":{"y":122,"x":41,"width":630,"spaceY":20,"spaceX":40,"repeatY":2,"repeatX":3,"height":605},"child":[{"type":"ActorItem","props":{"name":"render","runtime":"ui.actorgame.ActorItemUI"}}]}]};
		override protected function createChildren():void {
			View.regComponent("ui.actorgame.ActorItemUI",ActorItemUI);
			super.createChildren();
			createView(uiView);

		}

	}
}