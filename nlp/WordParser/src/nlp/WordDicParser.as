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
		}
		
		public static var I:WordDicParser = new WordDicParser();
		
		public function loadDic(filePath:String):void
		{
			Laya.loader.load(filePath, Handler.create(this, onFileLoaded), null, Loader.TEXT);
		}
		
		public var wordList:Array;
		private function onFileLoaded(txt:String):void
		{
			var lines:Array;
			lines = txt.split("\n");
			
			WordUtils.printLines(lines.slice(0, 500));
			debugger;
			
			wordList = [];
			var tWord:WordParser;
			
			var i:int, len:int;
			len = lines.length;
			var tLine:String;
			for (i = 0; i < len; i++)
			{
				tLine = lines[i];
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
			trace("word count:",wordList.length);
			debugger;
		}
		
	}

}