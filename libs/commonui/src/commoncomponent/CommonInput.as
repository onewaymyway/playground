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
		public var isAutoSize:Boolean = false;
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
		
		override public function set text(value:String):void 
		{
			if (!isAutoSize)
			{
				super.text = value;
				return;
			}
			this.width = 9999;
			super.text = value;
			this.textField.typeset();
			this.width = this.textField.textWidth + 5;
		}
	
		
		private function onBlur():void
		{
			this.editable = false;
			if (isAutoSize)
			{
				text = text;
			}
			
		}
		
	}

}