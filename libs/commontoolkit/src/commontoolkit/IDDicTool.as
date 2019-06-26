package commontoolkit 
{
	/**
	 * ...
	 * @author ww
	 */
	public class IDDicTool 
	{
		public var idDic:Object;
		public var tMax:int = 0;
		public var idKey:String = "id";
		public function IDDicTool() 
		{
			
		}
		
		public function reset():void
		{
			idDic = {};
			tMax = 1;
		}
		
		public function getItem(id:int):*
		{
			return idDic[id];
		}
		
		public function addItem(item:Object):void
		{
			var tID:int;
			tID = item[idKey];
			if (tID && getItem(tID) == item) return;
			
			item[idKey] = tMax;
			tMax++;
			idDic[item[idKey]] = item;
		}
		
		public function removeItem(item:Object):void
		{
			var tID:int;
			tID = item[idKey];
			if (tID && getItem(tID) == item)
			{
				delete idDic[tID];
			}
		}
		public function initByItems(items:Array):void
		{
			reset();
			var i:int, len:int;
			len = items.length;
			var tID:int;
			for (i = 0; i < len; i++)
			{
				tID = items[i][idKey] || 0;
				if (tID)
				{
					if (!idDic[tID])
					{
						idDic[tID] = items[i];
					}else
					{
						items[i][idKey] = 0;
					}
				}
				if (tID > tMax)
				{
					tMax = tID;
				}
			}
			tMax++;
			var tItem:Object;
			for (i = 0; i < len; i++)
			{
				tItem = items[i];
				if (!tItem[idKey])
				{
					tItem[idKey] = tMax;
					tMax++;
				}
				idDic[tItem[idKey]] = tItem;
			}
		}
		
	}

}