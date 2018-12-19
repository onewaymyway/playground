package view {

	import commonui.consts.CommonUIConsts;
	import commonui.ui.RenameResUI;
	import laya.debug.tools.StringTool;
	import laya.utils.Handler;
	import nodetools.devices.FileTools;
	import nodetools.devices.Sys;
	import webfile.FilePathUtils;

	
	/**重命名资源
	 * @author ww
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
		private var _complete:Handler;
		public function start(oldPath:String,complete:Handler):void {
			_oldPath = oldPath;
			_complete = complete;
			var oldName:String;
			oldName=FilePathUtils.getFileName(oldPath);
			resLbl.text = oldName;
			nameTxt.restrict = CommonUIConsts.fileNameRestrict;
			nameTxt.restrict = CommonUIConsts.fileNameRestrictEx;
			nameTxt.text = oldName;
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
					_complete.runWith([_oldPath,nameTxt.text]);
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