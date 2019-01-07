package commoncomponent 
{
	import laya.events.Event;
	import laya.ui.TextInput;
	
	/**
	 * ...
	 * @author ww
	 */
	public class CommonInput extends TextInput 
	{
		
		public function CommonInput(text:String="") 
		{
			super(text);
			this.editable = false;
			this.textField.mouseEnabled = false;
			this.on(Event.BLUR, this, onBlur);
			this.on(Event.DOUBLE_CLICK, this, onDoubleClick);
		}
		
		private function onDoubleClick():void
		{
			this.editable = true;
			this.focus = true;
		}
		
		private function onBlur():void
		{
			this.editable = false;
		}
		
	}

}