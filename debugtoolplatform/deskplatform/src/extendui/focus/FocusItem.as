package extendui.focus 
{
	import laya.display.Graphics;
	import laya.ui.Box;
	
	/**
	 * 焦点提示
	 * @author ww
	 */
	public class FocusItem extends Box 
	{
		
		public function FocusItem() 
		{
			
		}
		override protected function changeSize():void
		{
			super.changeSize();
			var g:Graphics = graphics;
			g.clear();
			g.drawRect(0, 0, width, height, "#33c5f5");
		}
		
	}

}