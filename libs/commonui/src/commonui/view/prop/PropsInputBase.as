///////////////////////////////////////////////////////////
//  PropsInputBase.as
//  Macromedia ActionScript Implementation of the Class PropsInputBase
//  Created on:      2018-5-7 上午10:11:55
//  Original author: ww
///////////////////////////////////////////////////////////

package commonui.view.prop
{
	import laya.events.Event;
	import laya.ui.View;
	import laya.utils.Handler;
	
	/**
	 * 属性面板输入插件基类
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2018-5-7 上午10:11:55
	 */
	public class PropsInputBase extends View
	{
		/**
		 * 注册属性面板插件 
		 * @param type 输入类型
		 * @param clz 使用的类
		 * 
		 */		
		public static function regPlugin(type:String,clz:Class):void
		{
			PropPluginManager.regPlugin(type,clz);
		}
		public function PropsInputBase()
		{
		}
		public var isFixHeight:Boolean = true;
		/**
		 * 是否使用IDE自身的Label 
		 */		
		public var useIDELabel:Boolean=true;
		/**
		 * 是否添加左右边距 
		 */		
		public var hasSide:Boolean = true;
		public var selfAlign:Boolean = false;
		/**
		 * 编辑的属性的key 
		 */		
		public var valueKey:String;
		/**
		 * 当前编辑的对象 
		 */		
		public var target:Object;
		public var config:Object;
		public var isSettingValue:Boolean;
		/**
		 * 设置编辑对象 
		 * @param target
		 * 
		 */		
		public function setTarget(target:*):void
		{
			this.target=target;
		}
		
		public function getValueFromTarget():*
		{
			return target[valueKey];
		}
		
		public function getValueFromTargetProps():*
		{
			return target.comXml.props[valueKey];
		}
		
		public function getDisplayValue():*
		{
			if (isPropValueExist()) return getValueFromTargetProps();
			if (isConfigDefaultExist()) return getDefaultValue();
			return getValueFromTarget()
		}
		
		public function isPropValueExist():Boolean
		{
			return target.comXml.props.hasOwnProperty(valueKey);
		}
		
		public function isConfigDefaultExist():Boolean
		{
			return config.hasOwnProperty("default");
		}
		
		public function getTitle():String
		{
			return config.nickName || config.title || config.name;
		}
		
		public function getDefaultValue():*
		{
			return config["default"];
		}
		/**
		 * 根据配置文件初始化输入框 
		 * @param configO
		 * 
		 */		
		public function initByConfig(configO:Object):void
		{
			this.config = configO;
		}
		
		public function setValueToTarget(value:*):void
		{
			target.comXml.props[valueKey] = value;
			target[valueKey] = value;
			
		}
		
		public function noticeValueChange():void
		{
			
		}
		
		/**
		 * 通知宽高变化 
		 * 
		 */		
		public function freshSize():void
		{
			this.event(Event.RESIZE);
		}
	}
}