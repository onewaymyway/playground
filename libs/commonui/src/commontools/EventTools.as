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
		
		public static function sendEventOnTree(tar:Sprite,event:String,data:*=null):void
		{
			while (tar)
			{
				tar.event(event,data);
				tar = tar.parent as Sprite;
			}
		}
		
		public static function sendStopAbleEventOnTree(eventType:String, event:Event, tar:Sprite, root:Sprite):void
		{
			event._stoped = false;
			while (tar)
			{
				tar.event(eventType, event);
				if (tar != root&&!event._stoped)
				{
					tar = tar.parent as Sprite;
				}else
				{
					break;
				}
			}
		}
	}

}