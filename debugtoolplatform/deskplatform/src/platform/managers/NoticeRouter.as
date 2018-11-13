///////////////////////////////////////////////////////////
//  NoticeRouter.as
//  Macromedia ActionScript Implementation of the Class NoticeRouter
//  Created on:      2015-10-26 上午10:39:45
//  Original author: ww
///////////////////////////////////////////////////////////

package platform.managers
{
	
	import laya.events.Event;
	import laya.events.Keyboard;
	import platform.editzone.EditZone;
	import view.AddDirectory;
	import view.AddResCommomDialog;
	import view.ResPanel;

	
	/**
	 * 本类集中初始化各个模块监听的消息
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2015-10-26 上午10:39:45
	 */
	public class NoticeRouter
	{
		public function NoticeRouter()
		{
		}
		private static var _initsList:Array;
		public static function init():void
		{
			_initsList = [];
			_initsList.push(ResPanel.instance);
			_initsList.push(EditZone.instance);
			_initsList.push(AddDirectory.instance);
			_initsList.push(AddResCommomDialog.instance);
			
			var i:int, len:int = _initsList.length;
			for (i = 0; i < len; i++)
			{
				_initsList[i].initListener();
			}

		}

	}
}