package nlp.algorithm 
{
	/**
	 * ...
	 * @author ww
	 */
	public class TopoSort 
	{
		public var startKey:String;
		public var endKey:String;
		public var relationList:Array;
		public var nodeDic:Object;
		public var otherSort:Function;
		public function TopoSort() 
		{
			
		}
		
		public function findOKNode(startPos:int):int
		{
			var i:int, len:int;
			len = relationList.length;
			var tRelation:Object;
			var tSelect:Object;
			var tI:int;
			tI = -1;
			for (i = startPos; i < len; i++)
			{
				tRelation = relationList[i];
				if (nodeDic[tRelation[startKey]] == 0)
				{
					if (!otherSort) return i;
					if (tI<0||otherSort(tRelation,relationList[tI]))
					{
						tI = i;
					}
					
				}
			}
			return tI;
		}
		
		public function switchPos(i:int, j:int):void
		{
			var tp:Object;
			tp = relationList[i];
			relationList[i] = relationList[j];
			relationList[j] = tp;
		}
		
		public function removeRefer(tRelation:Object):void
		{
			nodeDic[tRelation[endKey]] = nodeDic[tRelation[endKey]] - 1;
		}
		public function sort(relationList:Array):Array
		{
			nodeDic = { };
			this.relationList = relationList;
			var i:int, len:int;
			var tRelation:Object;
			len = relationList.length;
			for (i = 0; i < len; i++)
			{
				tRelation = relationList[i];
				if (!nodeDic[tRelation[startKey]])
				{
					nodeDic[tRelation[startKey]] = 0;
				}
				if (!nodeDic[tRelation[endKey]])
				{
					nodeDic[tRelation[endKey]] = 0;
				}
				nodeDic[tRelation[endKey]] = nodeDic[tRelation[endKey]] + 1;
			}
			var okPos:int;
			for (i = 0; i < len; i++)
			{
				okPos=findOKNode(i);
				if (okPos >= 0)
				{
					removeRefer(relationList[okPos]);
					switchPos(i, okPos);
				} 
				
			}
		}
		public static function sort(relationList:Array,startKey:String="start",endKey:String="end",otherSort:Function=null):void
		{
			var tp:TopoSort;
			tp = new TopoSort();
			tp.startKey = startKey;
			tp.endKey = endKey;
			tp.otherSort = otherSort;
			tp.sort(relationList);
		}
	}

}