///////////////////////////////////////////////////////////
//  EditRenderManager.as
//  Macromedia ActionScript Implementation of the Class EditRenderManager
//  Created on:      2018-5-25 上午10:45:03
//  Original author: ww
///////////////////////////////////////////////////////////

package platform.managers
{
	import nodetools.devices.FileManager;
	import nodetools.devices.FileTools;
	import platform.editzone.CustomIFrameRender;
	import platform.editzone.IEditViewer;
	
	/**
	 * 编辑区渲染器管理器
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2018-5-25 上午10:45:03
	 */
	public class EditRenderManager
	{
		public function EditRenderManager()
		{
		}
		public static var renderDic:Object={};
	
		public static function regRenderClass(extension:String,clz:Class):void
		{
			renderDic[extension]=clz;
		}
		
		public static function regRender(extension:String,renderPath:String):void
		{
			renderDic[extension]=renderPath;
		}
		
		public static function regRenderClassByType(type:String,clz:Class):void
		{
			var extension:String;
			extension=TypeManager.getExtension(type);
			regRenderClass(extension,clz);
		}
		
		private static function getCustomRenderByExtension(extension:String):*
		{
			return renderDic[extension];
		}
		
		public static function hasCustomRenderByPath(filePath:String):Boolean
		{
			if(!filePath) return false;
			if(!filePath is String) return false;
			var extension:String;
			extension=FileTools.getExtensionName(filePath);
			return renderDic.hasOwnProperty(extension);
		}
		
		public static function createCustomRenderByPath(filePath:String):CustomIFrameRender
		{
			var extension:String;
			extension=FileTools.getExtensionName(filePath);
			var extensionPath:String;
			extensionPath=getCustomRenderByExtension(extension);
			if(!extensionPath is String)
			{
				var renderI:IEditViewer;
				var renderClz:Class=getCustomRenderByExtension(extension);
				return new renderClz();
			}
			var rst:CustomIFrameRender;
			rst=new CustomIFrameRender();
			rst.renderPagePath = extensionPath;
			rst.initIframe();
			return rst;
		}
		
		public static function init():void
		{
			regIDERenders();
			var customDesignPath:String;
			customDesignPath=FileManager.getAppPath("plugins/");
//			debugger;
			var folders:Array;
			folders=FileTools.getDirChildDirs(customDesignPath);
			var i:int,len:int;
			len=folders.length;
			for(i=0;i<len;i++)
			{
				addCustomDesignByFolder(folders[i]);
			}
		}
		
		private static function regIDERenders():void
		{
			
		}
		
		public static function addCustomDesignByFolder(folder:String):void
		{
			if(!FileManager.exists(folder)) return;
			var configPath:String;
			configPath=FileManager.getPath(folder,"render.cfg");
			if (!FileManager.exists(configPath)) return;
			trace("addCustomDesignByFolder:",configPath);
			var configO:Object;
			try
			{
				configO=FileManager.readJSONFile(configPath);
				if(!configO) return;
				if(configO.extension&&configO.url)
				{
					var renderPath:String;
					renderPath=FileManager.getPath(folder,configO.url);
					if(FileManager.exists(renderPath))
					{
						regRender(configO.extension,renderPath);
					}
				}
			}catch(e:*)
			{
				
			}
			
		}
	}
}