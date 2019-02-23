package nlp 
{
	import laya.net.Loader;
	import laya.utils.Handler;
	import nlp.cutwords.WordCutter;
	import nlp.trie.Trie;
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
			trie = new Trie();
		}
		
		public static var I:WordDicParser = new WordDicParser();
		private var complete:Handler;
		public function loadDic(filePath:String,complete:Handler):void
		{
			this.complete = complete;
			Laya.loader.load(filePath, Handler.create(this, onFileLoaded), null, Loader.TEXT);
		}
		
		public var wordList:Array;
		public var vocList:Array;
		public var trie:Trie;
		public var cutter:WordCutter;
		private function onFileLoaded(txt:String):void
		{
			var lines:Array;
			lines = txt.split("\n");
			
			//WordUtils.printLines(lines.slice(0, 500));
			
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
				tLine = tLine.replace("\r","");
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
			trace("vocList:", vocList);
			
			trie.buildByWordList(vocList);
			trace("trie:", trie);
			
			cutter = new WordCutter();
			cutter.trie = trie;
			
			if (complete)
			{
				complete.run();
			}
		}
		
		public function cut(str:String):Array
		{
			return cutter.cut(str);
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