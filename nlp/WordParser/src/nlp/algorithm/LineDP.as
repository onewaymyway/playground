package nlp.algorithm 
{
	import nlp.algorithm.map.Edge;
	/**
	 * ...
	 * @author ww
	 */
	public class LineDP 
	{
		public var defaultValue:Number = 0;
		public var relations:Array;
		public var tarDic:Object;
		public var preDic:Object;
		public var walkAble:Object;
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
		
		public function dpWithStart(startList:Array,startValue:Number=0,defaultValue:Number=0):void
		{
			relations = TopoSort.sort(relations, "start", "end", null);
			var i:int, len:int;
			
			
			tarDic = { };
			
			preDic = { };
			
			walkAble = { };
			
			this.defaultValue = defaultValue;
			
			var hasStart:Boolean;
			hasStart = false;
			
			
			if (startList && startList.length)
			{
				hasStart = true;
				len = startList.length;
				for (i = 0; i < len; i++)
				{
					walkAble[startList[i]] = true;
					setWeight(startList[i],startValue);
				}
			}
			
			
			len = relations.length;
			var tRelation:Edge;
			var tEnd:int;
			var tValue:Number;
			var tStart:int;
			for (i = 0; i < len; i++)
			{
				
				tRelation = relations[i];
				tEnd = tRelation.end;
				tStart = tRelation.start;
				if (hasStart && !walkAble[tStart]) continue;
				if (hasStart)
				{
					if (!walkAble[tStart]) continue;
					walkAble[tEnd] = true;
				}
				
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
			if (!tarDic.hasOwnProperty(id))
			{
				tarDic[id] = defaultValue;
			}
			return tarDic[id];
		}
		
		private function setWeight(id:int, value:Number):void
		{
			tarDic[id] = value;
		}
		
		
		public static function simpleDP(relations:Array):LineDP
		{
			
			var lDP:LineDP;
			lDP = new LineDP();
			lDP.relations = relations;
			lDP.dp();
			return lDP;
		}
		
		public static function dpEx(relations:Array,startList:Array=null, startValue:Number = 0, defaultValue:Number = 0):LineDP
		{
			var lDP:LineDP;
			lDP = new LineDP();
			lDP.relations = relations;
			lDP.dpWithStart(startList, startValue, defaultValue);
			return lDP;
		}
	}

}