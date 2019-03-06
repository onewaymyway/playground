package commontools 
{
	import laya.display.Sprite;
	/**
	 * ...
	 * @author ww
	 */
	public class VLayouts 
	{
		public var items:Array;
		public var start:Number = 0;
		public var space:Number=5;
		public function VLayouts() 
		{
			
		}
		
		public function initByItems(items:Array):void
		{
			this.items = items;
			fresh();
		}
		public function fresh():void
		{
			var i:int, len:int;
			len = items.length;
			var tItem:Sprite;
			var tValue:Number;
			tValue = start;
			for (i = 0; i < len; i++)
			{
				tItem = items[i];
				if (!tItem.visible) continue;
				tItem.y = tValue;
				tValue += tItem.height + space;
				
			}
		}
		
	}

}