package nlp.tagging 
{
	import commontoolkit.IDDicTool;
	import nlp.WordDicParser;
	import nlp.cutwords.WordPiece;
	/**
	 * ...
	 * @author ww 
	 */
	public class TaggingBook 
	{
		public var words:Array;
		public var idWordDic:IDDicTool;
		public function TaggingBook() 
		{
			idWordDic = new IDDicTool();
		}
		public function toData():Object
		{
			var wList:Array;
			wList = [];
			var i:int, len:int;
			len = words.length;
			for (i = 0; i < len; i++)
			{
				wList.push(words[i].toData());
			}
			var rst:Object;
			rst = {};
			rst.words = wList;
			return rst;
		
		}
		public static function cutStr2Words(str:String,tagWords:Array=null):Array
		{
			var words:Array;
			words = WordDicParser.I.cut(str);
			var tagWords:Array;
			var i:int, len:int;
			len = words.length;
			if(!tagWords)
			tagWords = [];
			var tWordPiece:WordPiece;
			for (i = 0; i < len; i++)
			{
				tWordPiece = words[i];
				tagWords.push(TaggingWord.createByWordPiece(tWordPiece));
			}
			return tagWords;
		}
		public function initByString(str:String):void
		{
			
			var strLines:Array;
			strLines = str.split("\n");
			var i:int, len:int;
			len = strLines.length;
			
			var lineSplit:WordPiece;
			lineSplit = WordDicParser.I.cutter.findWordPiece("\n");
			
			var wordList:Array;
			wordList = [];
			for (i = 0; i < len; i++)
			{
				if (i > 0)
				{
					wordList.push(TaggingWord.createByWordPiece(lineSplit));
				}
				cutStr2Words(strLines[i], wordList);
				
			}
			words = wordList;
			idWordDic.initByItems(words);
			initLines();
		}
		
		public var lines:Array;
		public function initLines():void
		{
			lines = getLines();
			index = 0;
		}
		public function getLines():Array
		{
			var rst:Array;
			var i:int, len:int;
			rst = [];
			len = words.length;
			var tWord:TaggingWord;
			var tLineO:Object;
			for (i = 0; i < len; i++)
			{
				tWord = words[i];
				if (!tLineO)
				{
					tLineO = {};
					tLineO.start = i;
					rst.push(tLineO);
					
				}
				if (tWord.word == "\n")
				{
					tLineO.end = i;
					tLineO = null;
				}
			}
			if (tLineO)
			{
				tLineO.end = len - 1;
			}
			return rst;
			
		}
		
		public var index:int;
		public function reset():void
		{
			index = 0;
		}
		
		public function getCurLineInfo():Object
		{
			return lines[index];
		}
		
		public function set line(value:int):void
		{
			index = value;
			normalIndex();
		}
		public function get line():int
		{
			return index;
		}
		public function pre():String
		{
			index--;
			normalIndex();
			return getCurLineInfo();
		}
		
		public function next():String
		{
			index++;
			normalIndex();
			return getCurLineInfo();
		}
		
		private function normalIndex():void
		{
			if (index < 0) index = 0;
			if (index >= lines.length) index = lines.length - 1;
		}
		
		public function initByData(dataO:Object):void
		{
			var wList:Array;
			wList = dataO.words;
			var i:int, len:int;
			len = wList.length;
			var wordList:Array;
			wordList = [];
			for (i = 0; i < len; i++)
			{

				wordList.push(TaggingWord.fromData(wList[i]));

			}
			words = wordList;
			idWordDic.initByItems(words);
			initLines();
		}
		
	}

}