package objecteditor 
{
	/**
	 * ...
	 * @author ww
	 */
	public class ObjectDataTpl 
	{
		
		public function ObjectDataTpl() 
		{
			
		}
		
		public static function createUData(type:String):Object
		{
			var rst:Object;
			rst = {
				"type":type,
				"props": { },
				"childs":[]
				};
			return rst;
		}
		public static function createKeyData():Object
		{
			var rst:Object;
			rst = createUData("KeyItem")
			return rst;
		}
		
		public static function createArrayData():Object
		{
			var rst:Object;
			rst = createUData("ArrayItem")
			return rst;
		}
		
		public static function createObjectData():Object
		{
			var rst:Object;
			rst = createUData("ObjectItem")
			return rst;
		}
		
		public static function createValueData():Object
		{
			var rst:Object;
			rst = createUData("ValueItem")
			return rst;
		}
		
	}

}