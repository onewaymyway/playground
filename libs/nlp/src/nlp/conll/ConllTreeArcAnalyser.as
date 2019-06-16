package nlp.conll 
{
	/**
	 * ...
	 * @author ww
	 */
	public class ConllTreeArcAnalyser 
	{
		public static const SHIFT:String = "shift";
		public static const LEFTASPARENT:String = "leftAsParent";
		public static const RIGHTASPARENT:String = "rightAsParent";
		public function ConllTreeArcAnalyser() 
		{
			
		}
		private var stack:Array;
		private var buffer:Array;
		private var actionList:Array;
		public var isBuildMode:Boolean = false;
		public function reset():void
		{
			stack = [];
			buffer = [];
			actionList = [];
		}
		
		private function recordState(action:String):void
		{
			trace("recordState:",action);
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
		
		public  function buildTree(wordList:Array):void
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
		}
		
		public function getMove():String
		{
			return SHIFT;
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