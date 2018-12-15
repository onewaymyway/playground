package commonui.view.prop 
{
	import commonui.colorpanel.ColorPickerControl;
	import laya.events.Event;
	import laya.ui.Box;
	import laya.utils.Handler;
	/**
	 * ...
	 * @author ww
	 */
	public class PropsColorInput extends PropsInputBase 
	{
		public var colorBox:Box;
		protected var _color:String;
		private var _changeHandler:Handler;
		public function PropsColorInput() 
		{
			super();
			_changeHandler = new Handler(this, onColorChanged);
			colorBox = new Box();
			colorBox.left = colorBox.right = colorBox.top = colorBox.bottom=2;
			addChild(colorBox);
			this.on(Event.CLICK, this, onClick);
			colorBox.on(Event.RESIZE, this,freshColorRec );
		}
		
		
		private function onClick():void
		{
			//trace("onClick");
			ColorPickerControl.showColorPicker(_changeHandler, Laya.stage,0,-1,false,true);
		}
		
		protected function freshColorRec():void
		{
			colorBox.graphics.clear();
			colorBox.graphics.drawRect(0, 0, colorBox.width, colorBox.height, _color);
		}
		private function onColorChanged(color:*):void
		{
			//trace("onColorChanged:", color);
			if(color)
			updateColor(color);
		}
		protected function updateColor(color:String):void
		{
			if (!isSettingValue && _color != color)
			{
				setValueToTarget(color);
			}
			_color = color;
			freshColorRec();
		}
		
		override public function setTarget(target:*):void 
		{
			super.setTarget(target);
			updateColor(getDisplayValue()||"#000000");
		}
		
	}

}