package commontools 
{
	import laya.ui.Label;
	/**
	 * ...
	 * @author ww
	 */
	public class LabelBtnsLayout 
	{
		
		public function LabelBtnsLayout() 
		{
			
		}
		
		public var width:int = 300;
		public var allBtns:Array;
		public var sideWidth:int = 5;
		public var spaceX:Number=10;
		public function setUpBtns(btnList:Array):void
		{
			var tBtn:Label;
			var i:int, len:int;
			len = allBtns.length;
			
			var showBtns:Array;
			for (i = 0; i < len; i++)
			{
				tBtn = allBtns[i];
				tBtn.visible = false;
			}
			
			if (!btnList.length) return;
			showBtns = [];
			len = btnList.length;
			var tBtnStr:String;
			for (i = 0; i < len; i++)
			{
				tBtn = allBtns[i];
				showBtns.push(tBtn);
				tBtnStr = btnList[i];
				tBtn.text = tBtnStr;
				tBtn.visible = true;
			}
			
			var btnWidth:int;
			btnWidth = (this.width - spaceX * (showBtns.length - 1) - sideWidth * 2) / showBtns.length;
			btnWidth = Math.round(btnWidth);
			len = showBtns.length;
			var tX:Number;
			tX = sideWidth;
			for (i = 0; i < len; i++)
			{
				tBtn = showBtns[i];
				tBtn.x = tX;
				tBtn.width = btnWidth;
				tX += btnWidth + spaceX;
			}
		}
		
	}

}