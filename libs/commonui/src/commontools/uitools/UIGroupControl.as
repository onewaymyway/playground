package commontools.uitools 
{
	import laya.display.Sprite;
	/**
	 * ...
	 * @author ww
	 */
	public class UIGroupControl 
	{
		public var items:Array;
		public function UIGroupControl() 
		{
			
		}
		
		public function removeSelf():void
		{
			execute("removeSelf")
		}
		
		public function addToParent(parentO:Sprite):void
		{
			if (!items) return;
			var i:int, len:int;
			len = items.length;
			var tItem:*;
			for (i = 0; i < len; i++)
			{
				tItem = items[i];
				parentO.addChild(tItem);
			}
		}
		
		public function execute(funName:String, params:Array = null):void
		{
			if (!items) return;
			var i:int, len:int;
			len = items.length;
			var tItem:*;
			for (i = 0; i < len; i++)
			{
				tItem = items[i];
				if (params)
				{
					tItem[funName].apply(tItem, params);
				}else
				tItem[funName]();
			}
		}
	}

}