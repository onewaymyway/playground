package view {
	import configs.StyleConsts;
	import nodetools.devices.Sys;
	import platform.interfaces.PlatformEvents;
	import platform.tools.Notice;
	import ui.deskplatform.AddDirectoryUI;


	
	/**添加目录
	 * @author ww
	 */
	public class AddDirectory extends AddDirectoryUI {
		private static var _instance:AddDirectory;
		
		public static function get instance():AddDirectory {
			return _instance ? _instance : _instance = new AddDirectory();
		}
		public function initListener():void
		{
			Notice.listen(PlatformEvents.OPEN_ADDDIR, this, start);
		}
		public function start():void {
			nameTxt.restrict=StyleConsts.fileNameRestrict;
			nameTxt.text = "";
			popup();
//			Laya.stage.focus = nameTxt.textField;
			nameTxt.focus=true;
		}
		
		override public function close(type:String = null):void {			
			if (type == "sure") {
				
				if (nameTxt.text) {
					super.close(type);
					Notice.notify(PlatformEvents.ADD_DIR,[nameTxt.text]);
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