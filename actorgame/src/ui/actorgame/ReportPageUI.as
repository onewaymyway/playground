/**Created by the LayaAirIDE,do not modify.*/
package ui.actorgame {
	import laya.ui.*;
	import laya.display.*; 
	import ui.actorgame.ReportItemUI;

	public class ReportPageUI extends View {
		public var titleTxt:Label;
		public var infoTxt:Label;
		public var reportList:List;
		public var continueBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":720,"height":1280},"child":[{"type":"Label","props":{"y":74,"x":276,"width":167,"var":"titleTxt","text":"报告","styleSkin":"comp/label.png","height":45,"fontSize":30,"color":"#ffffff","align":"center"}},{"type":"Label","props":{"y":187,"x":60,"width":599,"var":"infoTxt","text":"各种统计信息","styleSkin":"comp/label.png","height":45,"fontSize":30,"color":"#ffffff","align":"center"}},{"type":"List","props":{"y":291,"x":102,"width":539,"var":"reportList","spaceY":20,"repeatY":6,"repeatX":1,"height":600},"child":[{"type":"ReportItem","props":{"name":"render","runtime":"ui.actorgame.ReportItemUI"}}]},{"type":"Button","props":{"y":1006,"x":234,"width":252,"var":"continueBtn","skin":"comp/button.png","labelSize":30,"labelColors":"#ffffff","label":"继续","height":97}}]};
		override protected function createChildren():void {
			View.regComponent("ui.actorgame.ReportItemUI",ReportItemUI);
			super.createChildren();
			createView(uiView);

		}

	}
}