package commonui.view.prop 
{
	import commonui.ui.prop.PropTextInputUI;
	import laya.events.Event;
	import laya.ui.TextInput;
	import laya.utils.Handler;
	/**
	 * ...
	 * @author ww
	 */
	public class PropsTextInput extends PropTextInputUI 
	{
		//protected var input:TextInput;
		public function PropsTextInput() 
		{
			super();
			
			input.fontSize = PropStyleConst.PropPanelFontSize;
			this.mouseEnabled = true;
			input.on(Event.ENTER, this, onInput);
			input.on(Event.BLUR, this, onInput);
		}
		
		
		private function onInputPageBack(value:String,ifSave:Boolean):void
		{
			trace("onInputPageBack:", value, ifSave);
			if (ifSave)
			{
				if (input.text != value)
				{
					input.text = value;
					setValueToTarget(value);
				}
			}
		}
		
		private function onInput():void
		{
			trace("valueChange:", this.input.text);
			setValueToTarget(this.input.text);
		}
		
		override public function setTarget(target:*):void 
		{
			super.setTarget(target);
			input.text = getDisplayValue()||"";
		}
		
		override public function initByConfig(configO:Object):void 
		{
			super.initByConfig(configO);
		}
		
	}

}