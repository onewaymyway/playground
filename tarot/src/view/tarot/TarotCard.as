package view.tarot 
{
	import carotutils.CarotDataManager;
	import laya.events.Event;
	import laya.ui.Label;
	import ui.tarot.TarotCardUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class TarotCard extends TarotCardUI 
	{
		
		public function TarotCard() 
		{
			detailBtn.on(Event.CLICK, this, showDetail);
			img.on(Event.CLICK, this, showCardInfo);
		}
		
		public function initCardItem(dataO:Object):void
		{
			titleTxt.text = dataO.title;
			contentBox.visible = false;
		}
		
		public var cardData:Object;
		public var tDataO:Object;
		public var detailTxt:Label;
		public function setCard(dataO:Object):void
		{
			tDataO = dataO;
			cardData = CarotDataManager.getCardByID(dataO.id);
			freshUI();
		}
		
		public function get isRevert():Boolean
		{
			if (!tDataO) return false;
			return tDataO.isRevert;
		}
		private function freshUI():void
		{
			img.scaleY = isRevert? -1:1;
			nameTxt.text = cardData.name.replace("　","\n");
			img.skin = "cards/" + cardData.image + ".jpg";
			contentBox.visible = true;
		}
		
		private function showCardInfo():void
		{
			var arr:Array;
			arr = [];
			arr.push(cardData.description);
			
			detailTxt.text = arr.join("\n\n");
		}
		
		private function showDetail():void
		{
			var text:String;
			var arr:Array;
			arr = [];
			//arr.push(cardData.description);
			if (isRevert)
			{
				arr.push("逆位");
				arr.push(cardData.invert);
			}else
			{
				
				arr.push("正位");
				arr.push(cardData.normal);
			}
			
			detailTxt.text = arr.join("\n\n");
		}
		
	}

}