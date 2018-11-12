///////////////////////////////////////////////////////////
//  StateManager.as
//  Macromedia ActionScript Implementation of the Class StateManager
//  Created on:      2015-10-22 下午7:45:51
//  Original author: ww
///////////////////////////////////////////////////////////

package platform.managers
{
	import platform.managers.state.State;
	
	/**
	 * 状态管理类
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2015-10-22 下午7:45:51
	 */
	public class StateManager
	{
		public function StateManager()
		{
		}
		private static var _stateDic:Object={};
		/**
		 * 是否已经存有状态 
		 * @param sign 状态标识符
		 * @return 
		 * 
		 */
		public static function has(sign:String):Boolean
		{
			return _stateDic.hasOwnProperty(sign);
		}
		/**
		 * 获取状态 
		 * @param sign 状态标识符
		 * @return 
		 * 
		 */
		public static function getState(sign:String):State
		{
			if(!_stateDic[sign]) _stateDic[sign]=new State();
			return  _stateDic[sign];
		}
		/**
		 * 更新状态，将会自动设置是否变化的值 
		 * @param sign 状态标识符
		 * @param data 状态，将会创建一个副本存入
		 * 
		 */
		public static function updateState(sign:String,data:Object):void
		{
			setChangeState(sign,has(sign));
			getState(sign).addE(data);
		}
		/**
		 * 清除状态 
		 * @param sign 状态标识符
		 * 
		 */
		public static function removeState(sign:String):void
		{
			delete _stateDic[sign];
			delete _changeDic[sign];
		}
		
		public static function renameState(sign:String,newSign:String):void
		{
			if(_stateDic[sign])
			{
				_stateDic[newSign]=_stateDic[sign];
				delete _stateDic[sign];
			}
			if(_changeDic[sign])
			{
				_changeDic[newSign]=_changeDic[sign];
				delete _changeDic[sign];
			}
		}
		private static var _changeDic:Object = { };
		
		/**
		 * 状态是否改变 
		 * @param sign
		 * @return 
		 * 
		 */
		public static function hasChange(sign:String):Boolean
		{
			return _changeDic[sign];
		}
		/**
		 * 设置状态是否改变 
		 * @param sign
		 * @param changed
		 * 
		 */
		public static function setChangeState(sign:String,changed:Boolean):void
		{
			_changeDic[sign]=changed;
		}
		
	}
}