package commonui.view.prop 
{
	import laya.utils.Handler;

	/**
	 * ...
	 * @author ww
	 */
	public class UIConfigManager 
	{
		
		public function UIConfigManager() 
		{
			
		}
		
		private static var nodeConfigDic:Object = { };
		public static const DefaultType:String = "Image";
		public static var configedTypeDic:Object = { };
		initDatas();
		private static function initDatas():void
		{
			configedTypeDic["Image"] = true;
		}
		
		public static function getCompProp(type:String, key:String):String
		{
			if (!nodeConfigDic[type]) return null;
			return nodeConfigDic[type][key];
		}
		
		public static function getCompConfig(type:String):Object
		{
			return nodeConfigDic[type];
		}
		
		public static function getCompTreeIcon(type:String):String
		{
			var iconurl:String;
			iconurl=UIConfigManager.getCompProp(type, "icon");
			
			if(!iconurl)
			{
				iconurl="Image";
			}
			return getTypeIcon(iconurl);
		}
		
		public static function getNickNameFromPropConfig(propConfig:Object):String
		{
			return propConfig.nickName || propConfig.title || propConfig.name;
		}
		
		public static function getTypeIcon(type:String):String
		{
			return type + ".png";
		}
		
		public static function getConfigedType(type:String):String
		{
			if (!configedTypeDic[type]) return DefaultType;
			return type;
		}
		public static function getTypeFromNode(node:*):String
		{
			if (!node || !node.comXml)
			{
				return DefaultType;
			}
			return getConfigedType(node.comXml.type);
		}
		
		public static function getPropValueFromNode(node:*, key:String):*
		{
			if (!node || !node.comXml||!node.comXml.props)
			{
				return null;
			}
			return node.comXml.props[key];
		}
		
		public static function getNodeIDFromNode(node:*):*
		{
			if (!node || !node.comXml)
			{
				return null;
			}
			return node.comXml.compId;
		}
		
		public static var propsConfigRoot:String = "props/";
		public static function getTypeConfigPath(type:String):String
		{
			return propsConfigRoot + type + ".json";
		}
		public static function loadConfigByNode(node:Object,complete:Handler):void
		{
			var type:String;
			type = getTypeFromNode(node);
			if (nodeConfigDic[type])
			{
				complete.runWith(nodeConfigDic[type]);
			}else
			{
				Laya.loader.load(getTypeConfigPath(type), Handler.create(null, onConfigLoaded, [type,complete]));
			}
		}
		
		private static function onConfigLoaded(type:String,complete:Handler,dataO:Object):void
		{
			nodeConfigDic[type] = dataO;
			complete.runWith(dataO);
		}
		
	}

}