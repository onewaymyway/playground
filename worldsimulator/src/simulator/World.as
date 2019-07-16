package simulator 
{
	import laya.debug.tools.IDTools;
	import laya.utils.Utils;
	/**
	 * ...
	 * @author ww
	 */
	public class World 
	{
		
		public function World() 
		{
			
		}

		public var objectList:Array;
		
		public function loop():void
		{
			runUpdates();
			runTasks();
			doChecks();
		}
		
		private var _tempArr:Array=[];
		public function runSafeLoop(funName:String):void
		{
			var i:int, len:int;
			
			var objList:Array;
			objList = Utils.copyArray(_tempArr, objectList);
			len = objList.length;
			for (i = 0; i < len; i++)
			{
				if(objList[i][funName] is Function)
				objList[i][funName](this);
			}
		}
		public function runUpdates():void
		{
			runSafeLoop("update");
		}
		public function runTasks():void
		{
			runSafeLoop("runTasks");
		}
		public function doChecks():void
		{
			runSafeLoop("doChecks");
		}
		
		public function getObject(id:String):Object
		{
			var i:int, len:int;
			len = objectList.length;
			for (i = 0; i < len; i++)
			{
				if (IDTools.getObjID(objectList[i]) == id)
				{
					return objectList[i];
				}
			}
			return null;
		}
		
		public function getObjectByName(name:String):Array
		{
			var rst:Array;
			rst = [];
			var i:int, len:int;
			len = objectList.length;
			for (i = 0; i < len; i++)
			{
				if (objectList[i].name== name)
				{
					rst.push(objectList[i]);
				}
			}
			return rst;
		}
		
		public function addObject(obj:ObjectBase):void
		{
			if (objectList.indexOf(obj) < 0)
			{
				objectList.push(obj);
			}
		}
	}

}