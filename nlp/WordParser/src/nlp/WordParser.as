package nlp 
{
	import laya.debug.tools.StringTool;
	/**
	 * ...
	 * @author ww
	 */
	public class WordParser 
	{
		public var word:String;
		public var alasDic:Object;
		public var lineCount:int;
		public var part:String;
		private var tWord:WordOne;
		public var wordList:Array;
		public function WordParser() 
		{
			lines = [];
			wordList = [];
			alasDic = { };
		}
		
		public var lines:Array;
		private var preLine:String;
		private var preIsPinYin:Boolean = false;
		public function addToAlasDic(word:String):void
		{
			word = word.replace("（", "").replace("）", "");
			alasDic[word] = word;
		}
		public function addLine(line:String):void
		{
			lines.push(line);
			var tLine:String;
			tLine = line;
			var isPinYin:Boolean;
			isPinYin = false;
			
			if (line.length=1&&alasDic[line])
			{
				
				tLine = preLine;
			}else
			if (line.charAt(0)=="（")
			{
				addToAlasDic(line);
				tLine = preLine;
			}else
			if (line.charAt(0)=="〖")
			{
				if (tWord)
				{
					tWord.addLine(line);
				}
			}else
			if (line.charAt(0)=="∶")
			{
				if (tWord)
				{
					tWord.addLine(line);
				}
			}else
			if (line.charAt(0)=="【")
			{
				if (tWord)
				{
					tWord.type = StringTool.getBetween(line, "【", "】");
				}
			}else
			if (line.indexOf("详细解释：") >= 0)
			{
				tLine = line.replace("详细解释：","");
				tWord = null;
			}else
			if (line.indexOf("部首：") >= 0)
			{
				part = line.replace("部首：","").replace("；","");
				
			}else
			if (line.indexOf("笔画数：") >= 0)
			{
				lineCount = parseInt(line.replace("笔画数：",""));
				
			}else
			if (line.indexOf("基本解释：") >= 0)
			{
				//tWord = createWord();
				tLine = word;
			}else
			if (PingYinDic.isPinYin(line))
			{
				if (preIsPinYin)
				{
					//trace("preIsPinYin:(", preLine, ") (", line + ")");
					if (tWord)
					{
						tWord.twPY = line;
					}
				}else
				{
					if (tWord)
					{
						tWord.parseEnd(true);
					}
					tWord = createWord();
					tWord.word = preLine;
					tWord.pinyin = line;
					isPinYin = true;
				}
				
				
			}else
			{
				if (tWord)
				{
					tWord.addLine(line);
				}
			}
			preLine = tLine;
			preIsPinYin = isPinYin;
		}
		
		public function addHead(line:String):void
		{
			var tArr:Array;
			tArr = line.split(" ");
			var tt:String;
			tt = tArr[0];
			word = tt.charAt(1);
			
		}
		
		public function createWord():WordOne
		{
			var rst:WordOne;
			rst = new WordOne();
			rst.word = word;
			rst.oWord = this;
			wordList.push(rst);
			return rst;
		}
	}

}