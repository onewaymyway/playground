package nlp.conll 
{
	import nlp.WordUtils;
	import nlp.algorithm.KeysCounter;
	/**
	 * ...
	 * @author ww
	 */
	public class ConllTreeArcAnalyser 
	{
		public static const SHIFT:String = "shift";
		public static const LEFTASPARENT:String = "leftAsParent";
		public static const RIGHTASPARENT:String = "rightAsParent";
		public static var defaultBufferHead:ConllWord;
		public function ConllTreeArcAnalyser() 
		{
			infoCounter = new KeysCounter();
		}
		
		private static function inits():void
		{
			defaultBufferHead = new ConllWord();
			defaultBufferHead.form = "Empty";
			defaultBufferHead.postag = "Empty";
		}
		inits();
		private var stack:Array;
		private var buffer:Array;
		private var actionList:Array;
		public var isBuildMode:Boolean = false;
		private var infoCounter:KeysCounter;
		public function reset():void
		{
			stack = [];
			buffer = [];
			actionList = [];
		}
		
		public static var typeConfigs:Array = [
		[2, 2, 2],
		[1, 1, 1],
		[1, 1, 0],
		[0, 1, 1],
		[1, 0, 1],
		[0, 0, 1],
		[1, 0, 0],
		[0, 1, 0]
		];
		public function getAdptWordKey(word:ConllWord, id:int):String
		{
			var rst:String;
			switch(id)
			{
				case 0:
					rst= WordUtils.getAdptWordType(defaultBufferHead);
					break;
				case 1:
					rst= WordUtils.getAdptWordType(word);
					break;
				case 2:
					rst= word.form;
					break;
			}
			return rst;
		}
		private function recordState(action:String):void
		{
			trace("recordState:", action);
			var itemL:ConllWord;
			var itemR:ConllWord;
			var bufferHead:ConllWord;
			var tail:int;
			tail = stack.length - 1;
			itemL = stack[tail - 1]||defaultBufferHead;
			itemR = stack[tail]||defaultBufferHead;
			bufferHead = buffer[0] || defaultBufferHead;
			var posInt:*;
			posInt = itemL - itemR==-1?true:false;
			var i:int, len:int;
			var tArr:Array;
			len = typeConfigs.length;
			for (i = 0; i < len; i++)
			{
				tArr = typeConfigs[i];
				infoCounter.addKey(getAdptWordKey(itemL,tArr[0]), getAdptWordKey(itemR,tArr[1]), getAdptWordKey(bufferHead,tArr[2]), action);
			}
		}
		
		public function shift():void
		{
			actionList.push(SHIFT);
			if (isBuildMode)
			{
				
			}else
			{
				recordState(SHIFT);
			}
			var item:ConllWord;
			item = buffer.shift();
			stack.push(item);
		}
		
		public function leftAsParent():void
		{
			actionList.push(LEFTASPARENT);
			var itemL:ConllWord;
			var itemR:ConllWord;
			var tail:int;
			tail = stack.length - 1;
			itemL = stack[tail - 1];
			itemR = stack[tail];
			if (isBuildMode)
			{
				itemR.head = itemL.id;
			}else
			{
				recordState(LEFTASPARENT);
			}
			stack.pop();
		}
		
		public function rightAsParent():void
		{
			actionList.push(RIGHTASPARENT);
			var itemL:ConllWord;
			var itemR:ConllWord;
			var tail:int;
			tail = stack.length - 1;
			itemL = stack[tail - 1];
			itemR = stack[tail];
			if (isBuildMode)
			{
				itemL.head = itemR.id;
			}else
			{
				recordState(RIGHTASPARENT);
			}
			stack.pop();
			stack.pop();
			stack.push(itemR);
		}
		
		public  function buildTree(wordList:Array):ConllTree
		{
			reset();
			isBuildMode = true;
			var i:int, len:int;
			len = wordList.length;
			for (i = 0; i < len; i++)
			{
				buffer.push(wordList[i]);
			}
			doTrans();
			var conllTree:ConllTree;
			conllTree = new ConllTree();
			conllTree.wordList = wordList;
			return conllTree;
		}
		
		public function canAct(action:String):Boolean
		{
			if (buffer.length == 0 && action == SHIFT) return false;
			if (stack.length < 2 && action != SHIFT) return false;
			return true;
		}
		
		public function getRandomAct():String
		{
			if (canAct(SHIFT)) return SHIFT;
			return LEFTASPARENT;
		}
		public function getMove():String
		{
			if (stack.length < 2)
			{
				return  SHIFT;
			}else
			{
				var itemL:ConllWord;
				var itemR:ConllWord;
				var bufferHead:ConllWord;
				var tail:int;
				tail = stack.length - 1;
				itemL = stack[tail - 1]||defaultBufferHead;
				itemR = stack[tail]||defaultBufferHead;
				bufferHead = buffer[0] || defaultBufferHead;
				var posInt:*;
				posInt = itemL - itemR==-1?true:false;
				
				var i:int, len:int;
				var tArr:Array;
				len = typeConfigs.length;
				var tType:String;
				for (i = 0; i < len; i++)
				{
					tArr = typeConfigs[i];
					tType = infoCounter.getMaxKey(getAdptWordKey(itemL,tArr[0]), getAdptWordKey(itemR,tArr[1]), getAdptWordKey(bufferHead,tArr[2]));
					
					if (tType&& canAct(tType)) return tType;
				}
				
				
				
			}
			return getRandomAct();
		}
		public function doTrans():void
		{
			var moveType:String;
			debugger;
			while (true)
			{
				if (stack.length == 1 && buffer.length == 0)
				{
					break;
				}
				if (stack.length < 2)
				{
					shift();
				}else
				{
					moveType = getMove();
					switch(moveType)
					{
						case SHIFT:
							shift();
							break;
						case LEFTASPARENT:
							leftAsParent();
							break;
						case RIGHTASPARENT:
							rightAsParent();
							break;
						default:
							debugger;
							return
					}
				}
				
			}
		}
		
		public function analyseTreeList(treeList:Array):void
		{
			var i:int, len:int;
			len = treeList.length;
			for (i = 0; i < len; i++)
			{
				analyseTree(treeList[i]);
			}
		}
		
		public function analyseTree(conllTree:ConllTree):void
		{
			reset();
			isBuildMode = false;
			var i:int, len:int;
			var wordList:Array;
			wordList = conllTree.wordList;
			len = wordList.length;
			for (i = 0; i < len; i++)
			{
				buffer.push(wordList[i]);
			}
			analyseTrans();
			trace("actionList:",actionList);
		}
		public function analyseTrans():void
		{
			var itemL:ConllWord;
			var itemR:ConllWord;
			var tail:int;
			debugger;
			while (true)
			{
				if (stack.length == 1 && buffer.length == 0)
				{
					break;
				}
				if (stack.length < 2)
				{
					shift();
				}else
				{
					tail = stack.length - 1;
					itemL = stack[tail - 1];
					itemR = stack[tail];
					if (itemL.head == itemR.id)
					{
						rightAsParent();
					}else
					if (itemR.head == itemL.id)
					{
						leftAsParent();
					}else
					{
						if (buffer.length)
						{
							shift();
						}else
						{
							debugger;
							break;
						}
						
					}
				}
				
			}
		}
		
	}

}