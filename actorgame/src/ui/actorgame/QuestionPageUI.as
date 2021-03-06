/**Created by the LayaAirIDE,do not modify.*/
package ui.actorgame {
	import laya.ui.*;
	import laya.display.*; 
	import view.actorgame.QuestionSelectItem;

	public class QuestionPageUI extends Dialog {
		public var questionTxt:Label;
		public var selectList:List;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":599,"height":543},"child":[{"type":"Image","props":{"y":0,"x":0,"top":0,"text":"TextInput","skin":"comp/input_22_selected.png","sizeGrid":"6,7,5,12","right":0,"left":0,"bottom":0}},{"type":"Label","props":{"y":40,"x":49,"wordWrap":true,"width":500,"var":"questionTxt","text":"游戏市场数据不错，是否换皮刷钱","styleSkin":"comp/label.png","height":144,"fontSize":30,"color":"#ffffff","align":"center"}},{"type":"List","props":{"y":254,"x":80,"width":437,"var":"selectList","spaceY":20,"repeatX":1,"height":248},"child":[{"type":"QuestionSelectItem","props":{"runtime":"view.actorgame.QuestionSelectItem","right":0,"name":"render","left":0}}]}]};
		override protected function createChildren():void {
			View.regComponent("view.actorgame.QuestionSelectItem",QuestionSelectItem);
			super.createChildren();
			createView(uiView);

		}

	}
}