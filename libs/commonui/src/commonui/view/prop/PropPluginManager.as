///////////////////////////////////////////////////////////
//  PropPluginManager.as
//  Macromedia ActionScript Implementation of the Class PropPluginManager
//  Created on:      2018-5-7 上午10:23:40
//  Original author: ww
///////////////////////////////////////////////////////////

package commonui.view.prop
{
	
	/**
	 * 属性面板插件管理器
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2018-5-7 上午10:23:40
	 */
	public class PropPluginManager
	{
		public function PropPluginManager()
		{
		}
		public static var typeToPluginDic:Object = { };
		public static var defaultInputClz:Class;
		initIDEPlugins();
		public static function regPlugin(type:String,clz:Class):void
		{
			type = type.toLowerCase();
			typeToPluginDic[type]=clz;
		}
		public static function createPluginByType(type:String):PropsInputBase
		{
			type = type.toLowerCase();
			var tClz:Class;
			tClz=typeToPluginDic[type]||defaultInputClz;
			if(!tClz) return null;
			return new tClz();
		}
		private static function initIDEPlugins():void
		{
			defaultInputClz = PropsTextInput;
			regPlugin("number", PropsNumberInput);
			//regPlugin("bool", PropsBoolInput);
			regPlugin("color", PropsColorInput);
			regPlugin("colorarray", PropsColorArrayInput);
		}
		
	}
}