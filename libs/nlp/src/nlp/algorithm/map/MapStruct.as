package nlp.algorithm.map 
{
	import nlp.algorithm.LineDP;
	/**
	 * ...
	 * @author ww
	 */
	public class MapStruct 
	{
		public var vList:Array;
		public var eList:Array;
		public function MapStruct() 
		{
			reset();
		}
		public function reset():void
		{
			vList = [];
			eList = [];
		}
		
		public function getVertex(id:int):Vertex
		{
			if (!vList[id]) vList[id] = Vertex.createByID(id);
			return vList[id];
			
		}
		public function addEdge(start:int, end:int, weight:Number,data:Object=null):void
		{
			var edge:Edge;
			edge = Edge.create(start, end, weight,data);
			var startV:Vertex;
			var endV:Vertex;
			startV = getVertex(start);
			endV = getVertex(end);
			startV.addOut(end,weight);
			endV.addIn(start, weight);
			eList.push(edge);
		}
		
		public function findMaxWeightPath(endI:int):Array
		{
			return LineDP.dpEx(eList,[0],0,-999).getMaxWeightPath(endI);
			return LineDP.simpleDP(eList).getMaxWeightPath(endI);
		}
		
		public static function showEdgeList(eList:Array):void
		{
			var i:int, len:int;
			//var 
		}
		public function buildMap():void
		{
			
		}
		
	}

}