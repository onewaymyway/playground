package nlp.algorithm.map 
{
	/**
	 * ...
	 * @author ww
	 */
	public class Vertex 
	{
		public var inList:Array;
		public var outList:Array;
		public var inDic:Object;
		public var outDic:Object;
		public var id:int;
		public function Vertex() 
		{
			reset();
		}
		
		public function reset():void
		{
			inList = [];
			outList = [];
			inDic = { };
			outDic = { };
		}
		
		public function addEdge(edge:Edge):void
		{
			if (edge.start == id)
			{
				addOut(edge.end, edge.weight);
			}else
			if (edge.end == id)
			{
				addIn(edge.start, edge.weight);
			}
		}
		
		public function addIn(id:int,weight:Number):void
		{
			inList.push(id);
			inDic[id] = weight;
		}
		
		public function addOut(id:int,weight:Number):void
		{
			outList.push(id);
			outDic[id] = weight;
		}
		
		public static function createByID(id:int):Vertex
		{
			var rst:Vertex;
			rst = new Vertex();
			rst.reset();
			rst.id = id;
			return rst;
		}
	}

}