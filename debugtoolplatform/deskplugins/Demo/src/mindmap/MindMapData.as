package mindmap 
{
	/**
	 * ...
	 * @author ww
	 */
	public class MindMapData 
	{
		
		public function MindMapData() 
		{
			
		}
		public var _mapData:Object;
		private var _nodeList:Array;
		private var _idDic:Object = { };
		public function initByObj(obj:Object):void
		{
			_mapData = obj;
			adptMapData();
		}
		private function adptMapData():void
		{
			if (!_mapData.nodeList) _mapData.nodeList = [];
			_nodeList = _mapData.nodeList;
		}
		
		public function addNode(node:Object):void
		{
			
		}
		
		public function removeNode():void
		{
			
		}
		
		public function getNodeByID(id:int):Object
		{
		}
		
		public function getNodeList():Array
		{
			return _nodeList;
		}
		public static function createByObj(obj:Object):MindMapData
		{
			var mapData:MindMapData;
			mapData = new MindMapData();
			mapData.initByObj(obj);
			return mapData;
		}
		
	}

}