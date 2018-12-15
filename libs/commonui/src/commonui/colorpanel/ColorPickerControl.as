package commonui.colorpanel 
{
	import colorpanel.ColorPickerWithIndex;
	import colorpanel.colorselectorpanel.SelectorColorPicker;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	/**
	 * ...
	 * @author ww
	 */
	public class ColorPickerControl 
	{
		public var closeWhenOtherClick:Boolean = false;
		private var hideCompleteHandler:Handler;
		public function ColorPickerControl() 
		{
			//colorPicker = new ColorPickerWithIndex();
			colorPicker = new SelectorColorPicker();
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
		
		private static var _skySettingPanel:ColorPickerControl;
		public static var colorChangeHandler:Handler;
		public static var isShow:Boolean = false;
		private static function _init():void
		{
			if (!_skySettingPanel)
			{
				_skySettingPanel = new ColorPickerControl();
			}
		}
		public static function showColorPicker(colorChangeHandler:Handler, parentBox:Sprite, parentBottomOffset:Number=100,childIndex:int=-1,hasImage:Boolean=true,autoClose:Boolean=false,hideHandler:Handler=null):void
		{
			if (isShow) return;
			_init();
			ColorPickerControl.colorChangeHandler = colorChangeHandler;
			_skySettingPanel.colorPicker.setHasImage(hasImage);
			_skySettingPanel.hideY = parentBox.height;
			_skySettingPanel.showY = parentBox.height - _skySettingPanel.colorPicker.height - parentBottomOffset;
			isShow = true;
			_skySettingPanel.closeWhenOtherClick = autoClose;
			_skySettingPanel.hideCompleteHandler = hideHandler;
			if (childIndex >= 0)
			{
				parentBox.addChildAt(_skySettingPanel.colorPicker, childIndex);
			}else
			{
				parentBox.addChild(_skySettingPanel.colorPicker);
			}
			
			_skySettingPanel.showEffect();
		}
		public static function hideColorPicker():void
		{
			if (!isShow) return;
			isShow = false;
			if (_skySettingPanel)
			{
				_skySettingPanel.hideEffect();
			}
		}
	}

}