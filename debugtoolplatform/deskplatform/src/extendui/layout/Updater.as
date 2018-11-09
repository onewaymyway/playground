package extendui.layout 
{
	/**
	 * ...
	 * @author ww
	 */
	public class Updater 
	{
		
		public function Updater(tar:Object,tarSign:String,src:Object,srcSign:String,dValue:Number=0) 
		{
			this.tar = tar;
			this.tarSign = tarSign;
			this.src = src;
			this.srcSign = srcSign;
			this.dValue = dValue;
		}
		public var tar:Object;
		public var tarSign:String;
		public var src:Object;
		public var srcSign:String;
		public var dValue:Number = 0;
		public function update():void
		{
//			trace("update:",tarSign,srcSign,dValue + src[srcSign]);
			tar[tarSign] = dValue + src[srcSign];
		}
		public function clear():void
		{
			tar = null;
			src = null;
		}
	}

}