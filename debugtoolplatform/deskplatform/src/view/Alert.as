package view {
	import nodetools.devices.Sys;
	import ui.deskplatform.AlertUI;
	
	/**提示框
	 * @author ww
	 */
	final public class Alert extends AlertUI {
		private static var _instance:Alert;
		
		public static function get instance():Alert {
			return _instance?_instance:_instance = new Alert();
		}
		
		public static function show(msg:String, title:String = "提示"):void {
			if(title=="提示")
			{
				title=Sys.lang("提示");
			}

			instance.start(msg, title);
		}
		
		public function start(msg:String, title:String):void {
			titleLbl.text = title;
			msgLbl.text = msg;
			popup();
		}
	}
}