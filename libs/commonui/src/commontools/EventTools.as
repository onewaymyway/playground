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
	}

}