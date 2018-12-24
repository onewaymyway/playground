package commonui.view.prop 
{
	import laya.debug.tools.layout.Layouter;
	import laya.ui.Box;
	import laya.ui.Image;
	
	/**
	 * ...
	 * @author ww
	 */
	public class PropItemBox extends Box 
	{
		public var layouter:Layouter;
		public function PropItemBox() 
		{
			super();
			
		}
		
		override protected function changeSize():void 
		{
			super.changeSize();
			this.graphics.clear();
			//this.graphics.drawRect(0, 0, this.width, this.height, "#ffffff");
			this.graphics.drawRect(0, 0, this.width, this.height, "#333333");
		}
		
	}

}