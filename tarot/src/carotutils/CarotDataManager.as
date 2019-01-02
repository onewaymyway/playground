package carotutils 
{
	/**
	 * ...
	 * @author ww
	 */
	public class CarotDataManager 
	{
		public static var cardList:Array;
		public function CarotDataManager() 
		{
			
		}
		
		public static function initByCardDatas(datas:Array):void
		{
			cardList = datas;
		}
		
		public static function getCardByID(id:int):Object
		{
			return cardList[id];
		}
		
		private static function getRandomID():int
		{
			return Math.floor(Math.random() * 9999999) % cardList.length;
		}
		
		public static function getRamdomCard(cardCount:int = 3):Array
		{
			var cardDic:Object;
			cardDic = { };
			var tID:int;
			var rst:Array;
			rst = [];
			var tDataO:Object;
			while (cardCount > 0)
			{
				tID = getRandomID();
				if (!cardDic[tID])
				{
					cardCount--;
					cardDic[tID] = true;
					tDataO = { };
					tDataO.id = tID;
					tDataO.isRevert = Math.random() > 0.5;
					rst.push(tDataO);
				}
			}
			return rst;
			
			
		}
	}

}