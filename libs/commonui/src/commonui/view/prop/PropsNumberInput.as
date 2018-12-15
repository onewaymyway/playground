package commonui.view.prop 
{
	import commonui.ui.prop.NumberInputUI;
	import commonui.view.TipMessage;
	import laya.events.Event;
	import laya.ui.Label;
	
	/**
	 * ...
	 * @author ww
	 */
	public class PropsNumberInput extends NumberInputUI 
	{
		public var tick:Number = 1;
		public var fix:int = 1;
		public function PropsNumberInput() 
		{
			//input.on(Event.ENTER, this, onInput);
			//input.on(Event.BLUR, this, onInput);
			input.editable = false;
			input.mouseEnabled = false;
			leftBtn.on(Event.MOUSE_DOWN, this, onBtnAction,["left"]);
			rightBtn.on(Event.MOUSE_DOWN, this, onBtnAction, ["right"]);
			
			leftBtn.on(Event.MOUSE_UP, this, onBtnAction,["stopAllTimer"]);
			rightBtn.on(Event.MOUSE_UP, this, onBtnAction, ["stopAllTimer"]);
			leftBtn.on(Event.MOUSE_OUT, this, onBtnAction,["stopAllTimer"]);
			rightBtn.on(Event.MOUSE_OUT, this, onBtnAction,["stopAllTimer"]);
		}
		
		private var _dValue:Number;
		private function onBtnAction(type:String):void
		{
			var curValue:Number;
			curValue = getCurValue();
			switch(type)
			{
				case "left":
					setUpTipLabel();
					curValue-= tick;
					updateValueTo(curValue);
					tryStartAutoUpdate(-tick);
					break;
				case "right":
					setUpTipLabel();
					curValue += tick;
					updateValueTo(curValue);
					tryStartAutoUpdate(tick);
					break;
				case "stopAllTimer":
					hideTipLabel();
					Laya.timer.clear(this, startAutoUpdate);
					stopAutoUpdate();
					break;
			}
		}
		
		private function setUpTipLabel():void
		{
			var label:Label;
			label = TipMessage.getTipLabel();
			this.addChild(label);
			label.y = -150;
			label.x = this.width * 0.5 - label.width * 0.5;
		}
		
		private function updateTipLabelText():void
		{
			var label:Label;
			label = TipMessage.getTipLabel();
			if (label.parent)
			{
				label.text = input.text;
			}
		}
		
		private function hideTipLabel():void
		{
			TipMessage.hideTipLabel();
		}
		
		private function tryStartAutoUpdate(dValue:Number):void
		{
			Laya.timer.once(500, this, startAutoUpdate, [dValue]);
		}
		
		private function startAutoUpdate(dValue:Number):void
		{
			_dValue = dValue;
			stopAutoUpdate();
			Laya.timer.frameLoop(1, this, autoUpdateLoop);
		}
		
		public function getCurValue():Number
		{
			return PropUtils.mParserFloat(input.text);
		}
		
		private function stopAutoUpdate():void
		{
			Laya.timer.clear(this, autoUpdateLoop);
		}
		
		private function autoUpdateLoop():void
		{
			updateValueTo(getCurValue() +_dValue );
		}
		
		private function updateValueTo(value:Number):void
		{
			if(tick!=1)
			value = PropUtils.numberToFixed(value, fix);
			input.text = value + "";
			updateTipLabelText();
			onInput();
			
		}
		
		override public function initByConfig(configO:Object):void 
		{
			super.initByConfig(configO);
			tick = configO.tick || 1;
			fix = PropUtils.getNumberFix(tick);
		}
		private function onInput():void
		{
			//trace("valueChange:", this.input.text);
			setValueToTarget(PropUtils.mParserFloat(this.input.text));
		}
		
		override public function setTarget(target:*):void 
		{
			super.setTarget(target);
			input.text =""+ (getDisplayValue()||"");
		}
		
	}

}