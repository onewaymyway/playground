package platform.managers 
{
	import laya.debug.tools.Notice;
	import laya.utils.Browser;

	/**
	 * 本类控制鼠标光标样式
	 * @author ww
	 */
	public class CursorManager 
	{
		
		public function CursorManager() 
		{
			
		}
		/**
		 * 自动
		 */
		public static const Auto:String = "default";
		public static const Hand:String="all-scroll";
		/**
		 * 水平方向调整大小
		 */
	    public static const HResize:String = "e-resize";
		/**
		 * 垂直方向调整大小
		 */
		public static const VResize:String = "n-resize";
		private static var _style:*;
		public static function init():void
		{
			_style = Browser.document.body.style;
			setType(Auto);
		}
		public static function setType(type:String):void
		{
			_style.cursor=type;
			//Notice.notify(IDEEvent.CHANGE_CURSORTYPE,type);
		}
	}

}