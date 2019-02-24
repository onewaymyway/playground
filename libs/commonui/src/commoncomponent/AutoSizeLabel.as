package commoncomponent 
{
	import laya.ui.Label;
	
	/**
	 * ...
	 * @author ...
	 */
	public class AutoSizeLabel extends Label 
	{
		
		public function AutoSizeLabel(text:String="") 
		{
			super(text);
			
		}
		
		override public function set text(value:String):void 
		{
			this.width = 9999;
			super.text = value;
			this.textField.typeset();
			this.width = this.textField.textWidth + 5;
		}
		
	}

}