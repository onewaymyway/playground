package simulator 
{
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
		public function runUpdates():void
		{
			var i:int, len:int;
			len = objectList.length;
			for (i = 0; i < len; i++)
			{
				objectList[i].update(this);
			}
		}
		public function runTasks():void
		{
			var i:int, len:int;
			len = objectList.length;
			for (i = 0; i < len; i++)
			{
				objectList[i].runTasks(this);
			}
		}
		public function doChecks():void
		{
			var i:int, len:int;
			len = objectList.length;
			for (i = 0; i < len; i++)
			{
				objectList[i].doChecks(this);
			}
		}
		
		public function getObject(id:String):Object
		{
			return null;
		}
		
		public function getObjectByName(name:String):Array
		{
			return null;
		}
		
		public function addObject(obj:ObjectBase):void
		{
			
		}
	}

}