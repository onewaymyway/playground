package commonui.colorpanel.colorselectorpanel
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	/**
	 * ...
	 * @author ww
	 */
	public class ColorSelectorControl 
	{
		public var closeWhenOtherClick:Boolean = false;
		private var hideCompleteHandler:Handler;
		public function ColorSelectorControl() 
		{
			colorPicker = new ColorPickerWithIndex();
			colorPicker.on(Event.CHANGE, this, onColorChange);
		}
		private var colorPicker:ColorPickerWithIndex;
		
		private function onColorChange(color:*):void
		{
			if (colorChangeHandler)
			{
				colorChangeHandler.runWith(color);
			}
		}
		
		public var showY:Number;
		public var hideY:Number;
		public function showEffect():void
		{
			Laya.stage.off(Event.CLICK, this, onStageClick);
			colorPicker.y = hideY;
			Tween.clearTween(colorPicker);
			Tween.to(colorPicker, {y:showY }, 300, Ease.circOut, Handler.create(this, onShowComplete));
		}
		
		private function onShowComplete():void
		{
			Laya.stage.on(Event.CLICK, this, onStageClick);
		}
		
		private function onStageClick(e:Event):void
		{
			if (!colorPicker.contains(e.target))
			{
				hideEffect();
			}
		}
		
		public function hideEffect():void
		{
			Laya.stage.off(Event.CLICK, this, onStageClick);
			Tween.clearTween(colorPicker);
			Tween.to(colorPicker, {y:hideY }, 300, Ease.circIn, Handler.create(this, onHideComplete));
		}
		
		private function onHideComplete():void
		{
			isShow = false;
			colorPicker.removeSelf();
			if (hideCompleteHandler)
			{
				hideCompleteHandler.run();
			}
		}
		
		private static var _colorSelectorPanel:ColorSelectorControl;
		public static var colorChangeHandler:Handler;
		public static var isShow:Boolean = false;
		private static function _init():void
		{
			if (!_colorSelectorPanel)
			{
				_colorSelectorPanel = new ColorSelectorControl();
			}
		}
		public static function showColorPicker(colorChangeHandler:Handler, parentBox:Sprite, parentBottomOffset:Number=100,childIndex:int=-1,hasImage:Boolean=true,autoClose:Boolean=false,hideHandler:Handler=null):void
		{
			if (isShow) return;
			_init();
			ColorSelectorControl.colorChangeHandler = colorChangeHandler;
			_colorSelectorPanel.colorPicker.setHasImage(hasImage);
			_colorSelectorPanel.hideY = parentBox.height;
			_colorSelectorPanel.showY = parentBox.height - _colorSelectorPanel.colorPicker.height - parentBottomOffset;
			isShow = true;
			_colorSelectorPanel.closeWhenOtherClick = autoClose;
			_colorSelectorPanel.hideCompleteHandler = hideHandler;
			if (childIndex >= 0)
			{
				parentBox.addChildAt(_colorSelectorPanel.colorPicker, childIndex);
			}else
			{
				parentBox.addChild(_colorSelectorPanel.colorPicker);
			}
			
			_colorSelectorPanel.showEffect();
		}
		public static function hideColorPicker():void
		{
			if (!isShow) return;
			isShow = false;
			if (_colorSelectorPanel)
			{
				_colorSelectorPanel.hideEffect();
			}
		}
	}

}