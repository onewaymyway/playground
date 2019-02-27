package nlp.conll 
{
	import laya.maths.MathUtil;
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
			relations.sort(MathUtil.sortByKey("len",false,true));
		}
	}

}