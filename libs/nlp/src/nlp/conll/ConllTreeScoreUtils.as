package nlp.conll 
{
	import nlp.WordUtils;
	import nlp.algorithm.KeysCounter;
	/**
	 * ...
	 * @author ww
	 */
	public class ConllTreeScoreUtils 
	{

		public var rootCounter:KeysCounter;
		
		private var _workList:Array;
		private var _workList2:Array;
		public var conllTree:ConllTree;
		private function getAdptWordType(word:ConllWord):String
		{
			if (WordUtils.typeDic.getWordType(word.word))
			{
				return WordUtils.typeDic.getWordTypeStr(word.word);
			}else
			{
				return word.postag;
			}
		}
		
		public function ConllTreeScoreUtils() 
		{
			_workList = [];
			_workList2 = [];
			
			rootCounter = new KeysCounter();
			
			
			
			_workList.push([KeysCounter.create(), [2, 2], 1]);
			_workList.push([KeysCounter.create(), [1, 2], 0.01]);
			_workList.push([KeysCounter.create(), [2, 1], 0.01]);
			_workList.push([KeysCounter.create(), [1, 1], 0.0001]);
			
			
			//_workList2.push([KeysCounter.create(), [2, 2], 1]);
			//_workList2.push([KeysCounter.create(), [1, 2], 0.01]);
			//_workList2.push([KeysCounter.create(), [2, 1], 0.01]);
			//_workList2.push([KeysCounter.create(),[1,1],0.0001]);
			
		}
		
		
		public function getWordWordType(startWord:ConllWord, endWord:ConllWord):int
		{
			var type:int;
			type = endWord.id - startWord.id;
			return type > 0?1: -1;
			if (type == 1 || type ==-1||type==0)
			{
				
			}else
			{
				if (tye > 0)
				{
					type = 3;
				}else
				{
					type = -3;
				}
				
			}
			
			return type;
		}
		
		public function getAdptWordKey(word:ConllWord, id:int,referWord:ConllWord=null):String
		{
			var rst:String;
			switch(id)
			{
				case 1:
					rst= WordUtils.getAdptWordType(word);
					break;
				case 2:
					rst = word.form;
					//rst= getWordWordRelationKey(word, referWord, 0);
					break;
			}
			return rst;
		}
		
		
		
		public function getWordWordRelationKey(startWord:ConllWord, endWord:ConllWord,curWord:int=0):String
		{
			if (curWord == 0)
			{
				return conllTree.getWordTypeReferToWord(startWord, endWord);
			}else
			{
				return conllTree.getWordTypeReferToWord(endWord, startWord);
			}
		}
		
		public function addRelation(startWord:ConllWord, endWord:ConllWord):void
		{
			var type:*;
			type = getWordWordType(startWord, endWord);
			var i:int, len:int;
			
			var tCounter:KeysCounter;
			var tArr:Array;
			var tGroupArr:Array;
			
			len = _workList.length;
			for (i = 0; i < len; i++)
			{
				tGroupArr = _workList[i];
				tCounter = tGroupArr[0];
				tArr = tGroupArr[1];
				tCounter.addKey(getAdptWordKey(startWord,tArr[0],endWord), getAdptWordKey(endWord,tArr[1],startWord), type);
			}
			
			len = _workList2.length;
			for (i = 0; i < len; i++)
			{
				tGroupArr = _workList2[i];
				tCounter = tGroupArr[0];
				tArr = tGroupArr[1];
				tCounter.addKey(getAdptWordKey(endWord,tArr[0],startWord), getAdptWordKey(startWord,tArr[1],endWord), type);
			}
		}
		
		public function addRoot(startWord:ConllWord):void
		{
			rootCounter.addKey(startWord.form);
			rootCounter.addKey(startWord.postag);
		}
		
		public function getRootScore(startWord:ConllWord):Number
		{
			var rst:Number;
			rst = rootCounter.getKeyLogNum(startWord.form);
			rst += rootCounter.getKeyLogNum(startWord.postag) * 0.01;
			return rst;
		}
		public function getScore(startWord:ConllWord, endWord:ConllWord,tree:ConllTree):Number
		{
			this.conllTree = tree;
			var type:*;
			type = getWordWordType(startWord, endWord);
			var rst:Number;
			
			var i:int, len:int;
			
			var tCounter:KeysCounter;
			var tArr:Array;
			var tGroupArr:Array;
			var tWeight:Number;
			rst = 0;
			
			len = _workList.length;
			for (i = 0; i < len; i++)
			{
				tGroupArr = _workList[i];
				tCounter = tGroupArr[0];
				tArr = tGroupArr[1];
				tWeight = tGroupArr[2];
				rst += tCounter.getKeyLogNum(getAdptWordKey(startWord,tArr[0],endWord), getAdptWordKey(endWord,tArr[1],startWord), type)*tWeight;
			}
			
			len = _workList2.length;
			for (i = 0; i < len; i++)
			{
				tGroupArr = _workList2[i];
				tCounter = tGroupArr[0];
				tArr = tGroupArr[1];
				tWeight = tGroupArr[2];
				rst += tCounter.getKeyLogNum(getAdptWordKey(endWord,tArr[0],startWord), getAdptWordKey(startWord,tArr[1],endWord), type)*tWeight;
			}
			
			rst += -Math.abs(startWord.id - endWord.id) * 0.1;
			return rst;
		}
	}

}