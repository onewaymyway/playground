package view.tarot 
{
	import carotutils.CarotDataManager;
	import laya.events.Event;
	import ui.tarot.TarotMainUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class TarotMain extends TarotMainUI 
	{
		
		public function TarotMain() 
		{
			init();
		}
		
		private var cardItems:Array; 
		private var resetDatas:Array;
		private function init():void
		{
			var datas:Array;
			datas = [];
			var tData:Object;
			tData = { };
			tData.title = "过去";
			datas.push(tData);
			
			tData = { };
			tData.title = "现在";
			datas.push(tData);
			
			tData = { };
			tData.title = "未来";
			datas.push(tData);
			resetDatas = datas;
			
			
			cardItems = [];
			cardItems = [past, now, feature];
			
			resetCards();
			
			workBtn.on(Event.CLICK, this, onPlay);
			
			detailTxt.text = "";
		}
		
		private function resetCards():void
		{
			var i:int, len:int;
			len = cardItems.length;
			var tCard:TarotCard;
			for (i = 0; i < len; i++)
			{
				tCard = cardItems[i];
				tCard.initCardItem(resetDatas[i]);
				tCard.detailTxt = detailTxt;
			}
		}
		
		private function onPlay():void
		{
			var datas:Array;
			datas = CarotDataManager.getRamdomCard(3);
			var i:int, len:int;
			len = cardItems.length;
			var tCard:TarotCard;
			for (i = 0; i < len; i++)
			{
				tCard = cardItems[i];
				tCard.setCard(datas[i]);
			}
			detailTxt.text = "";
		}
		
	}

}