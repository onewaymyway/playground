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
		public static var I:GameMain;
		public function GameMain() 
		{
			startBtn.on(Event.CLICK, this, onStartBtn);
			roleList.mouseEnabled = true;
			roleList.renderHandler = new Handler(this, itemRender);
			roleList.visible = false;
			dayTip.visible = false;
			gameInfo.visible = false;
			init();
		}
		
		private function init():void
		{
			freshUI();
		}
		
		public function nextDay():void
		{
			QGameState.I.nextDay();
			freshUI();
		}
		
		public function freshUI():void
		{
			gameInfo.text = "剩余资金:" + QGameState.I.money+" 第"+QGameState.I.day+"天";
			roleList.array = QGameState.I.roleStates;
			if (QGameState.I.money <= 0)
			{
				gameInfo.text = "钱用完了，公司倒闭。Game Over!您总共坚持了"+QGameState.I.day+"天";
				roleList.visible = false;
			}
		}
		private function itemRender(cell:ActorItem, index:int):void
		{
			cell.initByData(cell.dataSource);
		}
		
		private function onStartBtn():void
		{
			roleList.visible = true;
			startBtn.visible = false;
			welcomeTxt.visible = false;
			dayTip.visible = true;
			gameInfo.visible = true;
		}
	}

}