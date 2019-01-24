package commonlayout 
{
	import laya.debug.tools.ClassTool;
	import laya.utils.Handler;
	import laya.utils.Pool;
	/**
	 * ...
	 * @author ww
	 */
	public class ItemCreater 
	{
		
		public function ItemCreater() 
		{
			
		}
		public var createHandler:Handler;
		private var _typeClassDic:Object = { };
		public function regItemCreater(type:String, clz:Class):void
		{
			_typeClassDic[type] = clz;
		}
		public function regItemClassList(clzList:Array):void
		{
			var i:int, len:int;
			len = clzList.length;
			var tClz:Class;
			for (i = 0; i < len; i++)
			{
				tClz = clzList[i];
				regItemCreater(ClassTool.getClassName(tClz), tClz);
			}
		}
		public function createByType(type:String):*
		{
			var clz:Class;
			clz = _typeClassDic[type];
			var rst:*;
			rst = Pool.getItemByClass(ClassTool.getClassName(clz), clz);
			if (createHandler)
			{
				createHandler.runWith(rst);
			}
			return rst;
			//return _typeClassDic[type]();
		}
	}

}