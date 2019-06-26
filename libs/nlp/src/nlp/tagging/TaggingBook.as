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
			if (lineInfo)
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
		
		public function isNoUseEmpyt(i:int):Boolean
		{
			var tword:TaggingWord;
			tword = words[i];
			if (!tword) return false;
			if (tword.type != "空格") return false;
			tword = words[i - 1];
			
			if (!tword) return false;
			if (tword.type == "空格" || tword.type == "标点符号") return false;
			tword = words[i + 1];
			if (!tword) return false;
			if (tword.type == "空格" || tword.type == "标点符号") return false;
			return true;
		}
		public function removeNoUseEmpty():Boolean
		{
			var i:int;
			for (i = words.length - 1; i >= 0; i--)
			{
				if (isNoUseEmpyt(i))
				{
					words.splice(i, 1);
				}
			}
			updateLines();
			return false;
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
		public function breakWord(word:TaggingWord,all:Boolean=false):Boolean
		{
			//debugger;
			if (all)
			{
				breakWordByWordStr(word.word);
			}else
			{
				breakWordByIndex(findWordIndexInCurLine(word), true);
			}

			return false;
			
		}
		
		public function breakWordByWordStr(word:String):void
		{
			var i:int;
			var tWord:TaggingWord;
			for (i = words.length - 1; i >= 0; i--)
			{
				tWord = words[i];
				if (tWord.word == word)
				{
					breakWordByIndex(i, false);
				}
			}
			updateLines();
		}
		public function breakWordByIndex(tIndex:int,updateLines:Boolean=false):Boolean
		{
			var word:TaggingWord;
			word = words[tIndex];
			if (!word) return false;
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
			words.splice.apply(words, nWordList);
			if (updateLines)
			{
				lines = getLines();
			}
			return true;
		}
		
		
		public function getWordListByIndex(startIndex:int, endIndex:int,onlyWord:Boolean=true):Array
		{
			var tWords:Array;
			tWords = [];
			var i:int, len:int;
			if (startIndex > endIndex)
			{
				var temp:int;
				temp = startIndex;
				startIndex = endIndex;
				endIndex = temp;
			}
			if (onlyWord)
			{
				for (i = startIndex; i <= endIndex;i++ )
				{
					tWords.push(words[i].word);
				}
			}else
			{
				for (i = startIndex; i <= endIndex;i++ )
				{
					tWords.push(words[i]);
				}
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
		
		public function isSameWW(pos:int, wordList:Array):Boolean
		{
			var i:int, len:int;
			len = wordList.length;
			var tPos:int;
			for (i = 0; i < len; i++)
			{
				tPos = i + pos;
				if (!words[tPos] || words[tPos].word != wordList[i].word) return false;
			}
			return true;
		}
		
		public function copyWordPropByWord(startWord:TaggingWord, endWord:TaggingWord):void
		{
			if (!startWord) return;
			if (!endWord)
			{
				copyWordPropByWordList(getWordListByIndex(findWordIndexInRange(startWord), findWordIndexInCurLine(startWord),false));
			}else
			{
				copyWordPropByWordList(getWordListByIndex(findWordIndexInRange(startWord), findWordIndexInCurLine(endWord),false));
			}
		}
		
		public function copyWordPropByWordList(wordList:Array):void
		{
			var i:int;
			var wordLen:int;
			wordLen = wordList.length - 1;
			for (i = words.length - wordList.length; i >= 0; i--)
			{
				if (isSameWW(i, wordList))
				{
					copyWordPropByIndex(i, i + wordLen,wordList);
				}
			}
		}
		
		public function copyWordPropByIndex(startIndex:int, endIndex:int,wordList:Array,updateLines:Boolean=false):void
		{
			var i:int, len:int;
			len = wordList.length;
			var tWord:TaggingWord;
			var sWord:TaggingWord;
			for (i = 0; i < len; i++)
			{
				tWord = words[startIndex + i];
				sWord = wordList[i];
				if (tWord && sWord)
				{
					tWord.type = sWord.type;
				}
			}
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
		
		public function updateLines():void
		{
			lines = getLines();
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