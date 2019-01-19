/**Created by the LayaAirIDE,do not modify.*/
package ui.actorgame {
	import laya.ui.*;
	import laya.display.*; 

	public class QuestionPageUI extends Dialog {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":599,"height":543},"child":[{"type":"Box","props":{"y":0,"x":0,"width":599,"height":543},"child":[{"type":"Label","props":{"y":20,"x":0,"width":599,"text":"游戏市场数据不错，是否换皮刷钱","styleSkin":"comp/label.png","height":149,"fontSize":30,"color":"#ffffff","align":"center"}},{"type":"Button","props":{"y":268,"x":162,"width":275,"skin":"comp/button.png","labelSize":30,"labelColors":"#ffffff","label":"选项1","height":67}},{"type":"Button","props":{"y":362,"x":162,"width":275,"skin":"comp/button.png","labelSize":30,"labelColors":"#ffffff","label":"选项2","height":67}},{"type":"Button","props":{"y":452,"x":162,"width":275,"skin":"comp/button.png","labelSize":30,"labelColors":"#ffffff","label":"选项3","height":67}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}