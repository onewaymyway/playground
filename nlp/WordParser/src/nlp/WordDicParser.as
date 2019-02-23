package nlp 
{
	import laya.net.Loader;
	import laya.utils.Handler;
	/**
	 * ...
	 * @author ww
	 */
	public class WordDicParser 
	{
		
		public function WordDicParser() 
		{
			wordList = [];
			vocList = [];
		}
		
		public static var I:WordDicParser = new WordDicParser();
		
		public function loadDic(filePath:String):void
		{
			Laya.loader.load(filePath, Handler.create(this, onFileLoaded), null, Loader.TEXT);
		}
		
		public var wordList:Array;
		public var vocList:Array;
		private function onFileLoaded(txt:String):void
		{
			var lines:Array;
			lines = txt.split("\n");
			
			WordUtils.printLines(lines.slice(0, 500));
			
			var pinyin:PingYinDic;
			pinyin = new PingYinDic();
			wordList = [];
			var tWord:WordParser;
			
			var i:int, len:int;
			len = lines.length;
			var tLine:String;
			for (i = 0; i < len; i++)
			{
				tLine = lines[i];
				pinyin.addIfOK(tLine);
				if (tLine.charAt(0) == "*")
				{
					tWord = new WordParser();
					tWord.addHead(tLine);
					wordList.push(tWord);
				}else
				{
					if (tWord)
					{
						tWord.addLine(tLine);
					}
				}
			}
			trace("word count:", wordList.length, wordList);
			pinyin.makeCharDic();
			trace(pinyin);
			addToWordList(wordList);
			trace("vocList:",vocList);
		}
		
		private function addToWordList(wList:Array):void
		{
			var i:int, len:int;
			len = wList.length;
			var tWord:WordParser;
			for (i = 0; i < len; i++)
			{
				tWord = wList[i];
				addWordToVocList(tWord);
			}
		}
		
		private function addWordToVocList(word:WordParser):void
		{
			var tList:Array;
			tList = word.wordList;
			if (!tList) return;
			var i:int, len:int;
			len = tList.length;
			
			for (i = 0; i < len; i++)
			{
				vocList.push(tList[i]);
			}
		}
		
	}

}