package dataeditor 
{
	/**
	 * ...
	 * @author ww
	 */
	public class DataTpl 
	{
		
		public function DataTpl() 
		{
			
		}
		
		public static function createDataListData():Object
		{
			var rst:Object;
			
			rst = { 
				"title":"title",
				"type":"type",
				"itemtpl": { },
				"width":400,
				"height":400,
				"isMin":false
				};
			
			
			return rst;
		}
		
		public static function adptDataListData(dataO:Object):void
		{
			if (!dataO.width) dataO.width = 400;
			if (!dataO.height) dataO.height = 400;
		}
	}

}