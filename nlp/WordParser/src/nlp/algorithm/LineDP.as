package nlp.algorithm 
{
	import nlp.algorithm.map.Edge;
	/**
	 * ...
	 * @author ww
	 */
	public class LineDP 
	{
		public var relations:Array;
		public var tarDic:Object;
		public var preDic:Object;
		public function LineDP() 
		{
			
		}
		
		public function dp():void
		{
			relations = TopoSort.sort(relations, "start", "end", null);
			var i:int, len:int;
			len = relations.length;
			
			tarDic = { };
			
			preDic = { };
			var tRelation:Edge;
			var tEnd:int;
			var tValue:Number;
			for (i = 0; i < len; i++)
			{
				
				tRelation = relations[i];
				tEnd = tRelation.end;
				tValue = getWeight(tRelation.start) + tRelation.weight;
				if (!preDic[tEnd] || getWeight(tRelation.end) < tValue)
				{
					preDic[tEnd] = tRelation;
					tarDic[tEnd] = tValue;
				}
			}
			
			
		}
		
		public function getMaxWeightPath(end:int):Array
		{
			var pathList:Array;
			pathList = [];
			var tID:int;
			tID = end;
			while (preDic[tID])
			{
				pathList.push(preDic[tID]);
				tID = preDic[tID].start;
			}
			pathList.reverse();
			return pathList;
		}
		
		private function getWeight(id:int):Number
		{
			if (!tarDic[id])
			{
				tarDic[id] = 0;
			}
			return tarDic[id];
		}
		
		
		public static function simpleDP(relations:Array):LineDP
		{
			
			var lDP:LineDP;
			lDP = new LineDP();
			lDP.relations = relations;
			lDP.dp();
			return lDP;
		}
	}

}