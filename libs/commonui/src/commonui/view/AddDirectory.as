package view {
	import commonui.consts.CommonUIConsts;
	import commonui.ui.AddDirectoryUI;
	import laya.utils.Handler;
	import nodetools.devices.Sys;


	
	/**添加目录
	 * @author ww
	 */
	public class AddDirectory extends AddDirectoryUI {
		private static var _instance:AddDirectory;
		
		public static function get instance():AddDirectory {
			return _instance ? _instance : _instance = new AddDirectory();
		}
		private var _complete:Handler;
		public function start(complete:Handler):void {
			_complete = complete;
			nameTxt.restrict=CommonUIConsts.fileNameRestrict;
			nameTxt.text = "";
			popup();
//			Laya.stage.focus = nameTxt.textField;
			nameTxt.focus=true;
		}
		
		override public function close(type:String = null):void {			
			if (type == "sure") {
				
				if (nameTxt.text) {
					super.close(type);
					_complete.runWith(nameTxt.text);
				}else {
					Alert.show(Sys.lang("目录名称不能为空"));
				}				
			}else
			{
				super.close(type);
			}
		}
	}
}