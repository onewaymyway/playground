package commonui.view {
	import laya.ui.Label;
	import laya.utils.Tween;
	
	/**
	 * ...
	 * @author ww
	 */
	public class TipMessage {
		private static var i:TipMessage;
		
		public static var label:Label;
		public static function hideTipLabel():void
		{
			if (label) label.removeSelf();
		}
		
		public static function getTipLabel():Label
		{
			if (!label)
			{
				label = new Label();
				label.width = 400;
				label.fontSize = 60;
				label.align = "center";
			}
			return label;
		}
		
	}
}