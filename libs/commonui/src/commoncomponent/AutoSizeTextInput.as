package commoncomponent 
{
	import laya.ui.TextInput;
	
	/**
	 * ...
	 * @author ww
	 */
	public class AutoSizeTextInput extends TextInput 
	{
		
		public function AutoSizeTextInput(text:String="") 
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