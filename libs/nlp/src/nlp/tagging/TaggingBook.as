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
			rst.index = index;
			return rst;
		
		}
		public static function cutStr2Words(str:String,tagWords:Array=null,idDic:IDDicTool=null):Array
		{
			var words:Array;
			words = WordDicParser.I.cut(str);
			var tagWords:Array;
			var i:int, len:int;
			len = words.length;
			if(!tagWords)
			tagWords = [];
			var tWordPiece:WordPiece;
			var tWord:TaggingWord;
			for (i = 0; i < len; i++)
			{
				tWordPiece = words[i];
				tWord = TaggingWord.createByWordPiece(tWordPiece);
				if (idDic)
				{
					idDic.addItem(tWord);
				}
				tagWords.push(tWord);
			}
			return tagWords;
		}
		
		public function findWordIndexInCurLine(word:TaggingWord):int
		{
			var lineInfo:Object;
			lineInfo = getCurLineInfo();
			var start:int;
			var end:int;
			if (!lineInfo)
			{
				start = lineInfo.start;
				end = lineInfo.end;
			}else
			{
				start = 0;
				end = words.length-1;
			}
			
			return findWordIndexInRange(word, start, end);
			
		}
		
		public function findWordIndexInRange(word:TaggingWord, start:int=0, end:int=-1):int
		{
			var i:int;
			var tWord:TaggingWord;
			if (end < 0)
			{
				end = words.length - 1;
			}
			for (i = start; i <= end; i++)
			{
				tWord = words[i];
				if (tWord.id == word.id)
				{
					return i;
				}
			}
			return -1;
		}
		
		public function createWordByStr(str:String):TaggingWord
		{
			var rst:TaggingWord;
			rst = TaggingWord.createByWordStr(str);
		
			idWordDic.addItem(rst);
			return rst;
		}
		public function breakWord(word:TaggingWord):Boolean
		{
			//debugger;
			var  tIndex:int;
			tIndex = findWordIndexInCurLine(word);
			var wordStr:String;
			wordStr = word.word;
			var i:int, len:int;
			len = wordStr.length;
			var nWordList:Array;
			nWordList = [tIndex,1];
			for (i = 0; i < len; i++)
			{
				nWordList.push(createWordByStr(wordStr.charAt(i)));
			}
		
			//debugger;
			words.splice.apply(words,nWordList);
			lines = getLines();
			return false;
			
		}
		
		
		public function getWordListByIndex(startIndex:int, endIndex:int):Array
		{
			var tWords:Array;
			tWords = [];
			var i:int, len:int;
			for (i = startIndex; i <= endIndex;i++ )
			{
				tWords.push(words[i].word);
			}
			return tWords;
		}
		
		public function reCutWord(startWord:TaggingWord, endWord:TaggingWord,connectAll:Boolean=false):void
		{
			var startIndex:int;
			var endIndex:int;
			startIndex = findWordIndexInCurLine(startWord);
			endIndex = findWordIndexInCurLine(endWord);
			if (endIndex < startIndex)
			{
				var tmp:int;
				tmp = startIndex;
				startIndex = endIndex;
				endIndex = tmp;
			}
			
			var wordStr:String;
			wordStr = getWordListByIndex(startIndex, endIndex).join("");
			var nWordList:Array;
			nWordList = [startIndex, endIndex - startIndex + 1];
			nWordList = cutStr2Words(wordStr,nWordList,idWordDic);
			words.splice.apply(words, nWordList);
			return false;
		}
		public function connectWord(startWord:TaggingWord, endWord:TaggingWord,connectAll:Boolean=false):Boolean
		{
			var startIndex:int;
			var endIndex:int;
			startIndex = findWordIndexInCurLine(startWord);
			endIndex = findWordIndexInCurLine(endWord);
			if (endIndex < startIndex)
			{
				var tmp:int;
				tmp = startIndex;
				startIndex = endIndex;
				endIndex = tmp;
			}
			if (connectAll)
			{
				connectWordByWordList(getWordListByIndex(startIndex, endIndex));
				
			}else
			{
				connectWordByIndex(startIndex, endIndex);
			}
			
			lines = getLines();
			//debugger;
			return false;
		}
		
		
		public function isSame(pos:int, wordList:Array):Boolean
		{
			var i:int, len:int;
			len = wordList.length;
			var tPos:int;
			for (i = 0; i < len; i++)
			{
				tPos = i + pos;
				if (!words[tPos] || words[tPos].word != wordList[i]) return false;
			}
			return true;
		}
		public function connectWordByWordList(wordList:Array,updateLines:Boolean=false):void
		{
			var i:int;
			var wordLen:int;
			wordLen = wordList.length - 1;
			for (i = words.length - wordList.length; i >= 0; i--)
			{
				if (isSame(i, wordList))
				{
					connectWordByIndex(i, i + wordLen);
				}
			}
			if (updateLines)
			{
				lines = getLines();
			}
		}
		
		public function connectWordByIndex(startIndex:int, endIndex:int,updateLines:Boolean=false):void
		{
			var tWords:Array;
			tWords = getWordListByIndex(startIndex,endIndex);
			var newWord:TaggingWord;
			newWord = createWordByStr(tWords.join(""));
			words.splice(startIndex, endIndex - startIndex + 1, newWord);
			if (updateLines)
			{
				lines = getLines();
			}
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
		public function pre():Object
		{
			index--;
			normalIndex();
			return getCurLineInfo();
		}
		
		public function next():Object
		{
			index++;
			normalIndex();
			return getCurLineInfo();
		}
		
		public function goto(value:int):Object
		{
			index = value;
			normalIndex();
			return getCurLineInfo();
		}
		
		private function normalIndex():void
		{
			if (index < 0) index = 0;
			if (index >= lines.length) index = lines.length - 1;
		}
		
		public function get maxLine():int
		{
			if (!lines) return 0;
			return lines.length-1;
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
			this.index = dataO.index || 0;
			normalIndex();
		}
		
	}

}