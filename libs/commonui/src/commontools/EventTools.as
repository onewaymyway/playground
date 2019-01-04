package commontools 
{
	import laya.display.Sprite;
	/**
	 * ...
	 * @author ww
	 */
	public class EventTools 
	{
		
		public function EventTools() 
		{
			
		}
		
		public static function sendEventOnTree(tar:Sprite,event:String):void
		{
			while (tar)
			{
				tar.event(event);
				tar = tar.parent as Sprite;
			}
		}
	}

}