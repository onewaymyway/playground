package nlp.algorithm 
{
	import laya.maths.MathUtil;
	import laya.utils.Utils;
	import nlp.algorithm.map.Edge;
	/**
	 * ...
	 * @author ww
	 */
	public class Prim 
	{
		
		public function Prim() 
		{
			
		}
		
		
		public static function solve(relations:Array):void
		{
			var tempList:Array;
			tempList = Utils.copyArray([], relations);
			var solvedDic:Object;
			solvedDic = { };
			var usedPathDic:Object;
			usedPathDic = { };
			tempList.sort(MathUtil.sortByKey("weight"));
			var pathList:Array;
			pathList = [];
			var tPath:Edge;
			tPath = tempList[0];
			pathList.push(tPath);
			solvedDic[tPath.start] = true;
			solvedDic[tPath.end] = true;
			usedPathDic[0] = true;
			var i:int, len:int;
			len = tempList.length;
			var hasOne:Boolean;
			while (true)
			{
				hasOne = false;
				for (i = 1; i < len; i++)
				{
					tPath = tempList[i];
					if (usedPathDic[i]) continue;
					if (solvedDic[tPath.start] && !solvedDic[tPath.end])
					{
						solvedDic[tPath.end] = true;
						pathList.push(tPath);
						usedPathDic[i] = true;
						hasOne = true;
						break;
					}
				}
				if (!hasOne)
				{
					break;
				}
			}
			
			return pathList;
			
		}
	}

}