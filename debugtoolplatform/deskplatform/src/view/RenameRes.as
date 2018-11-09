package view {

	import configs.StyleConsts;
	import laya.debug.tools.StringTool;
	import laya.editor.comonents.Alert;
	import nodetools.devices.FileManager;
	import ui.deskplatform.RenameResUI;

	
	/**重命名资源
	 * @author yung
	 */
	public class RenameRes extends RenameResUI {
		private static var _instance:RenameRes;
		
		public static function get instance():RenameRes {
			return _instance ? _instance : _instance = new RenameRes();
		}
		public function initListener():void
		{
		
		}
		private var _oldPath:String;
		public function start(oldPath:String):void {
			_oldPath=oldPath;
			var oldName:String;
			oldName=FileManager.getFileName(oldPath);
			resLbl.text = oldName;
			nameTxt.restrict=StyleConsts.fileNameRestrict;
			nameTxt.text = oldName;
			updateCheck.selected = true;
			updateCheck.visible=false;
			popup();
			Laya.stage.focus = nameTxt.textField;
		}
		
		override public function close(type:String = null):void {
			
			if (type == "sure") {
				if(StringTool.isOkFileName(nameTxt.text))
				{
					if(FileTools.isPathSame(nameTxt.text,resLbl.text))
					{
						Alert.show(Sys.lang("文件名不能相同！！"));
						return;
					}
					//Notice.notify(IDEEvent.RENAME_RES,[_oldPath,nameTxt.text, updateCheck.selected]);
//					ResPanel.instance.rename(_oldPath,nameTxt.text, updateCheck.selected);
					super.close(type);
				}else
				{
					Alert.show(Sys.lang("文件名不合法"));
				}
				
			}else
			{
				super.close(type);
			}
		}
	}
}