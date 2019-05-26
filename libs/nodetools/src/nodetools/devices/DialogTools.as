package nodetools.devices
{
	
	/**
	 * 本类封装弹出本地对话框
	 * @author ww
	 */
	public class DialogTools
	{
		
		public function DialogTools()
		{
		
		}
		
		public static var dialog:*;
		
		public static function init():void
		{
			dialog =Device.requireRemote("dialog");
		}
		
		private static function showOpenDialog(win:* = null, options:Object = null, callBack:Function = null):void
		{
			dialog.showOpenDialog(win, options, callBack);
		}
		
		private static function showSaveDialog(win:* = null, options:Object = null, callBack:Function = null):void
		{
			dialog.showSaveDialog(win, options, callBack);
		}
		public static function showSave(title:String,fileName:String, callBack:Function):void
		{
			var option:Object={
				title:title,
				defaultPath:fileName,
				filters:[],
				properties:[]
			};
			showSaveDialog(null,option,callBack);
		}
		
		public static function showMessageBox(win:* = null, options:Object = null, callBack:Function = null):*
		{
			return dialog.showMessageBox(win, options, callBack);
		}
		
		
		public static function showErrorBox(title:String, content:String):void
		{
			dialog.showErrorBox(title, content);
		}
		public static function getOpenDirO(title:String="open Dir",defaultPath:String=null):Object
		{
			var rst:Object;
			rst={ title:title,properties:["openDirectory"]};
			if(defaultPath!=null)
			{
				rst.defaultPath=defaultPath;
			}
			
			return rst;
		}
		public static var tempOptionO:Object=
			{
				title:"",
				defaultPath:null,
				filters:[],
				properties:[]
			}
		public static function getOpenProO(title:String="open Project",extension:String="laya"):Object
		{
			//"*.morn", "*.morn"
			return {title:title,filters: [{name: '*.'+extension, extensions: [extension]}]};
		}
		public static function showOpenDir(title:String = "open Dir",callBack:Function=null, defaultPath:String = null):void
		{
			showOpenDialog(null, getOpenDirO(title, defaultPath), callBack);
		}
		public static function showOpenFile(title:String = "open file", callBack:Function=null, filter:Object = null,defaultPath:String=null):void
		{
			if (!filter) filter = filterO;
			filter.title = title;
			if(defaultPath)
			{
				filter.defaultPath=defaultPath;
			}
			showOpenDialog(null, filter, callBack);
		}
		public static function getOpenParticleO(title:String="open Particle"):Object
		{
			//"*.morn", "*.morn"
			return {title:title,filters: [{name: '*.json', extensions: ['json']}]};
		}
		
		public static var txtFilterO:Object= {title:"open txt file",filters: [{name: 'Txt', extensions: ['txt']}, {name: 'All Files', extensions: ['*']}]};
		public static var imgFilterO:Object= {title:"open Img",filters: [{name: 'Images', extensions: ['jpg', 'png']}]};
		public static var filterO:Object = {title:"open file",filters: [{name: 'Images', extensions: ['jpg', 'png', 'gif']}, {name: 'Movies', extensions: ['mkv', 'avi', 'mp4']}, {name: 'Custom File Type', extensions: ['as']}, {name: 'All Files', extensions: ['*']}]};
	}

}