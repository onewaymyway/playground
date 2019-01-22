package view.actorgame 
{
	import laya.events.Event;
	import laya.ui.UIUtils;
	import ui.actorgame.ActorItemUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ActorItem extends ActorItemUI 
	{
		
		public function ActorItem() 
		{
			icon.on(Event.CLICK, this, onClick);
		}
		private var _dataO:Object;
		public function initByData(dataO:Object):void
		{
			_dataO = dataO;
			//nameTxt.text = dataO.label;
			nameTxt.text = dataO.label + "(" + dataO.count + ")";
			if (dataO.count > 15)
			{
				nameTxt.color = "#ffff00";
			}else
			if (dataO.count < 3)
			{
				nameTxt.color = "#ff0000";
			}else
			{
				nameTxt.color = "#ffffff";
			}
			if (dataO.label == QGameState.I.preActor)
			{
				this.mouseEnabled = false;
				UIUtils.gray(this);
			}else
			{
				this.mouseEnabled = true;
				this.filters = null;
			}
		}
		
		private function onClick():void
		{
			QGameState.I.preActor = _dataO.label;
			QuestionPage.I.start(QGameState.I.getQuestionByRole(_dataO.label));
		}
		
	}

}