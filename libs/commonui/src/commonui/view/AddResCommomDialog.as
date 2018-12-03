///////////////////////////////////////////////////////////
//  AddResCommomDialog.as
//  ActionScript file
//  Created on:      2018-6-5 上午9:13:55
//  Original author: ww
///////////////////////////////////////////////////////////


package view
{
	import commonui.consts.CommonUIConsts;
	import commonui.ui.AddDirectoryUI;
	import laya.utils.Handler;
	import nodetools.devices.Sys;

	
	/**
	 * 
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2017-10-23 下午8:59:35
	 */
	public class AddResCommomDialog extends AddDirectoryUI
	{
		private static var _instance:AddResCommomDialog;
		
		public static function get instance():AddResCommomDialog {
			return _instance ? _instance : _instance = new AddResCommomDialog();
		}
		private var dataO:Object;
		private var _complete:Handler;
		public function start(dataO:Object,complete:Handler):void {
			if (!dataO) return;
			_complete = complete;
			this.dataO = dataO;
			titleTxt.text=Sys.lang("新建");
			nameTip.text=Sys.lang("名称：");
			nameTxt.restrict=CommonUIConsts.fileNameRestrict;
			nameTxt.text = "";
			popup();
			//			Laya.stage.focus = nameTxt.textField;
			nameTxt.focus=true;
		}
		
		override public function close(type:String = null):void {			
			if (type == "sure") {
				//PagePanel.instance.addDirectory(nameTxt.text);
				if (nameTxt.text) {
					super.close(type);
					dataO.fileName = nameTxt.text;
					_complete.runWith(dataO);
				}else {
					Alert.show(Sys.lang("名称不能为空"));
				}				
			}else
			{
				super.close(type);
			}
		}
	}
}