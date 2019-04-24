package scriptuis 
{
	import laya.display.Sprite;
	/**
	 * ...
	 * @author ww
	 */
	public class UICreateUtils 
	{
		
		public function UICreateUtils() 
		{
			
		}
		
		public static function createHeadIcon(name:String,width:int = 50, color:String = "#ffffff" ):Sprite
		{
			var sp:Sprite;
			sp = new Sprite();
			sp.graphics.drawRect(0, 0, width, width, color);
			
			var r:Number;
			r = Math.round(width / 2 - 2);
			var maskSp:Sprite;
			maskSp = new Sprite();
			maskSp.graphics.drawCircle(0, 0, r, "#ff0000");
			maskSp.blendMode = "destination-out";
			maskSp.x = width/2;
			maskSp.y = width/2;
			sp.addChild(maskSp)
			
			sp.size(width, width);
			sp.name = name;
			return sp;
		}
		
	}

}