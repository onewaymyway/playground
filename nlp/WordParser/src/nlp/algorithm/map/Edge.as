package nlp.algorithm.map 
{
	/**
	 * ...
	 * @author ww
	 */
	public class Edge 
	{
		public var data:Object;
		public var start:int;
		public var end:int;
		public var weight:int;
		public function Edge() 
		{
			
		}
		
		public static function create(start:int, end:int, weight:Number,data:Object=null):Edge
		{
			var rst:Edge;
			rst = new Edge();
			rst.start = start;
			rst.end = end;
			rst.weight = weight;
			rst.data = data;
			return rst;
		}
	}

}