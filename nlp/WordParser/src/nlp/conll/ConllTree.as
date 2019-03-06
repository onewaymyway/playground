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
		
		public function getWordByIndex(index:int):ConllWord
		{
			return wordList[index];
		}
		public function addLine(line:String):void
		{
			var tWord:ConllWord;
			tWord = ConllWord.parseFromLine(line);
			if (!wordList[tWord.id])
			{
				wordList.push(tWord);
				tWord.tree = this;
				ConllWordDic.I.addWord(tWord);
			}
			
		}
		
		private static function otherSort(item0:Object, item1:Object):Boolean
		{
			return item0.len < item1.len;
		}
		
		private function dealRelation(relation:ConllRelation):void
		{
			var enWord:ConllWord;
			enWord = wordList[relation.end];
			if(enWord)
			enWord.refers.push(relation.start);
			var sWord:ConllWord;
			sWord = wordList[relation.start];
			if(sWord)
			sWord.refers.push(relation.end);
		}
		public function buildRelation():void
		{
			//debugger;
			relations = [];
			var i:int, len:int;
			len = wordList.length;
			var tRelation:ConllRelation;
			for (i = 0; i < len; i++)
			{
				tRelation = ConllRelation.buildByWord(wordList[i]);
				relations.push(tRelation);
				dealRelation(tRelation);
			}
			
			len = wordList.length;
			var tWord:ConllWord;
			for (i = 0; i < len; i++)
			{
				tWord = wordList[i];
				tWord.sortRefers(i);
			}
			//relations.sort(MathUtil.sortByKey("len", false, true));
			
			TopoSort.sort(relations, "start", "end",otherSort);
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