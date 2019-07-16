package commonlayout 
{
	import laya.display.Sprite;
	/**
	 * ...
	 * @author ww
	 */
	public class WordLayout 
	{
		public var spaceX:Number = 2;
		public var spaceY:Number = 2;
		public var startY:Number = 2;
		public var border:Number = 2;
		public var newLineSignDic:Object = {".":true, "!":true, "。":true, "！":true};
		public var getWordFun:Function;
		public function WordLayout() 
		{
			
		}
		
		public function isNewLineItem(item:Object):Boolean
		{
			if (getWordFun == null) return false;
			return newLineSignDic[getWordFun(item)];
		}
		
		public function layout(items:Array, width:Number, height:Number):void
		{
			var i:int, len:int;
			len = items.length;
			var tX:Number, tY:Number;
			
			width = width - border;
			height = height - border;
			tX = border;
			tY = startY;
			
			var tItem:Sprite;
			var tHeight:Number;
			
			for (i = 0; i < len; i++)
			{
				tItem = items[i];
				tItem.x = tX;
				tItem.y = tY;
				tX += tItem.width + spaceX;
				if (tX > width)
				{
					tY += tItem.height + spaceY;
					tItem.x = spaceX;
					tItem.y = tY;
					tX = tItem.width + spaceX;
					
				}else
				{
					if (isNewLineItem(tItem))
					{
						tY += tItem.height + spaceY;
						tX = spaceX;
						
					}
				}
				
				
				
			}
		}
		
	}

}