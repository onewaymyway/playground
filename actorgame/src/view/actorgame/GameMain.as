package view.actorgame 
{
	import laya.events.Event;
	import laya.utils.Handler;
	import ui.actorgame.GameMainUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class GameMain extends GameMainUI 
	{
		
		public function GameMain() 
		{
			startBtn.on(Event.CLICK, this, onStartBtn);
			roleList.mouseEnabled = true;
			roleList.renderHandler = new Handler(this, itemRender);
			roleList.visible = false;
		}
		
		
		private function itemRender(cell:*, index:int):void
		{
		}
		
		private function onStartBtn():void
		{
			roleList.visible = true;
			startBtn.visible = false;
		}
	}

}