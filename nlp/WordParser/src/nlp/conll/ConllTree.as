package nlp.conll 
{
	import laya.maths.MathUtil;
	import nlp.algorithm.TopoSort;
	/**
	 * ...
	 * @author ww
	 */
	public class ConllTree 
	{
		public var wordList:Array;
		public var relations:Array;
		public function ConllTree() 
		{
			wordList = [];
		}
		
		public function addLine(line:String):void
		{
			wordList.push(ConllWord.parseFromLine(line));
		}
		
		public function buildRelation():void
		{
			relations = [];
			var i:int, len:int;
			len = wordList.length;
			for (i = 0; i < len; i++)
			{
				relations.push(ConllRelation.buildByWord(wordList[i]));
			}
			//relations.sort(MathUtil.sortByKey("len", false, true));
			
			TopoSort.sort(relations, "start", "end");
			return;
			var j:int;
			var tWord:ConllRelation;
			var cpWord:ConllRelation;
			var tmpWord:ConllRelation;
			for (i = 0; i < len; i++)
			{
				tWord = relations[i];
				for (j = i + 1; j < len; j++)
				{
					cpWord = relations[j];
					if (tWord.end == cpWord.start)
					{
						relations[j] = tWord;
						tWord = cpWord;
					}
				}
			}
		}
	}

}