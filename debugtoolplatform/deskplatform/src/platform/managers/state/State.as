package platform.managers.state 
{
	import laya.debug.tools.ObjectTools;

	/**
	 * 历史状态管理类
	 * @author ww
	 */
	public class State 
	{
		
		public function State() 
		{
			
		}
		public static const MaxLen:int=150;
		private var _stateList:Array=[];
		private var _tI:int=-1;
		/**
		 * 添加状态 ，直接使用传入的状态值
		 * @param data
		 * 
		 */
		private function add(data:Object):void
		{
//			trace("before add");
			traceState();
			if(_tI!=_stateList.length-1)
			{
				_stateList.length=_tI+1;
			}
			_stateList.push(data);
			if(_stateList.length>MaxLen)
			{
				_stateList.shift();
			}
			_tI=_stateList.length-1;
//			trace("after add");
			traceState();
		}
		
		public function getLastCache():Object
		{
			if(_stateList.length>1)
			{
				return _stateList[_stateList.length-2];
			}
			return null;
		}
		
		private function traceState():void
		{
//			trace("state:",_tI+"/"+_stateList.length);
		}
		/**
		 * 添加状态 ，会拷贝一个副本数据存入
		 * @param data
		 * 
		 */
		public function addE(data:Object):void
		{
			add(ObjectTools.copyObj(data));
		}
		/**
		 * 获取当前状态 
		 * @return 
		 * 
		 */
		public function now():Object
		{
			return ObjectTools.copyObj(_stateList[_tI]);
		}
		/**
		 * 向后回退 
		 * @return 
		 * 
		 */
		public function back():Object
		{	
			if(_tI<=0) return null;
			_tI--;		
			traceState();
			return now();
		}
		/**
		 * 向前重做 
		 * @return 
		 * 
		 */
		public function forward():Object
		{
			if(_tI>=_stateList.length-1) return null;
			_tI++;
			traceState();
			return now();
		}
		
		
	}

}