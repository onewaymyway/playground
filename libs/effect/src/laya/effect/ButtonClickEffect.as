package laya.effect 
{
	import laya.display.Sprite;
	import laya.events.Event;
	/**
	 * 按钮点击效果类,点击之后会有一个缩放的效果
	 */
	public class ButtonClickEffect 
	{
		
		private var _tar:Sprite;
		
		/**
		 * 设置控制对象 
		 * @param tar
		 */		
		public function set target(tar:Sprite):void
		{
			_tar = tar;
			tar.on(Event.CLICK, this, onClick);
		}
		
		private function onClick():void
		{
			EffectUtils.scaleEffect(_tar);
		}
	}

}