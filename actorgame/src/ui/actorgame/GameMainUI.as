/**Created by the LayaAirIDE,do not modify.*/
package ui.actorgame {
	import laya.ui.*;
	import laya.display.*; 
	import view.actorgame.ActorItem;

	public class GameMainUI extends View {
		public var startBtn:Button;
		public var dayTip:Label;
		public var roleList:List;
		public var welcomeTxt:Label;
		public var gameInfo:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":720,"height":1280},"child":[{"type":"Button","props":{"y":959,"x":234,"width":252,"var":"startBtn","skin":"comp/button.png","labelSize":30,"labelColors":"#ffffff","label":"开始","height":97}},{"type":"Label","props":{"y":783,"x":60,"wordWrap":true,"width":599,"var":"dayTip","text":"新的一天开始了，今天你要处理哪方面的事务","styleSkin":"comp/label.png","height":333,"fontSize":30,"color":"#ffffff","align":"center"}},{"type":"List","props":{"y":122,"x":41,"width":630,"var":"roleList","spaceY":20,"spaceX":40,"repeatY":2,"repeatX":3,"height":605},"child":[{"type":"ActorItem","props":{"runtime":"view.actorgame.ActorItem","name":"render"}}]},{"type":"Label","props":{"y":197,"x":70,"wordWrap":true,"width":599,"var":"welcomeTxt","text":"一觉醒来你成了游戏公司的CEO,你的任务是让公司稳健的运行","styleSkin":"comp/label.png","height":333,"fontSize":30,"color":"#ffffff","align":"center"}},{"type":"Label","props":{"y":26,"x":39,"wordWrap":true,"width":599,"var":"gameInfo","text":"剩余资金:100000","styleSkin":"comp/label.png","height":54,"fontSize":30,"color":"#ffffff","align":"left"}}]};
		override protected function createChildren():void {
			View.regComponent("view.actorgame.ActorItem",ActorItem);
			super.createChildren();
			createView(uiView);

		}

	}
}