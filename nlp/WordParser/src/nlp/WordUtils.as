package nlp 
{
	import nlp.cutwords.WordPiece;
	import nlp.dictools.TypeDicParser;
	/**
	 * ...
	 * @author ww
	 */
	public class WordUtils 
	{
		public static var typeDic:TypeDicParser;
		public function WordUtils() 
		{
			
		}
		
		public static function printLines(lines:Array):void
		{
			var i:int, len:int;
			len = lines.length;
			for (i = 0; i < len; i++)
			{
				trace(lines[i]);
			}
		}
		
		public static function showChars(start:int, end:int):void
		{
			var i:int;
			for (i = start; i <= end; i++)
			{
				trace("char:",i,":(",String.fromCharCode(i),")");
			}
		}
		
		public static function arrToDic(arr:Array):Object
		{
			var rst:Object;
			rst = { };
			var i:int, len:int;
			len = arr.length;
			for (i = 0; i < len; i++)
			{
				rst[arr[i]] = arr[i];
			}
			return rst;
		}
		
		public static function getDicKeys(dic:Object):Array
		{
			var rst:Array;
			rst = [];
			var key:String;
			
			for (key in dic)
			{
				rst.push(key);
			}
			return rst;
		}
		
		public static function dic2Arr(dic:Object):Array
		{
			var rst:Array;
			rst = [];
			var key:String;
			
			for (key in dic)
			{
				rst.push({key:key,value:dic[key]});
			}
			return rst;
		}
		public static function isWordListSame(wordList1:Array, wordList2:Array):Boolean
		{
			if (!wordList1.length == wordList2.length) return false;
			var i:int, len:int;
			len = wordList1.length;
			var word1:WordPiece, word2:WordPiece;
			for (i = 0; i < len; i++)
			{
				word1 = wordList1[i];
				word2 = wordList2[i];
				if (word1.start != word2.start)
				{
					trace("Dif:",i,word1.word,word2.word);
					return false;
				}
				
				if (word1.end != word2.end)
				{
					trace("Dif:",i,word1.word,word2.word);
					return false;
				}
			}
			return true;
		}
		
		public static function getMaxScore(dic:Object):Number
		{
			var score:Number;
			score = 0;
			var key:String;
			var tScore:Number;
			for (key in dic)
			{
				tScore = dic[key];
				if (tScore>score)
				{
					score = tScore;
				}
			}
			return score;
		}
		public static function scoreWordList(wordList:Array):Number
		{
			var i:int, len:int;
			len = wordList.length;
			var score:Number;
			score = 0;
			var tWord:WordPiece;
			for (i = 0; i < len; i++)
			{
				tWord = wordList[i];
				if (tWord.typeO)
				{
					score += getMaxScore(tWord.typeO);
				}
			}
			return score/len;
		}
		
		public static function getWordScore(word:String):Number
		{
			var tTypeO:Object;
			tTypeO=typeDic.getWordType(word);
			if (!tTypeO) return 1;
			return getMaxScore(tTypeO);
		}
		
		public static function removeSameNB(arr:Array):Array
		{
			var i:int;
			i = arr.length - 1;
			for (i = arr.length - 1; i >= 0; i--)
			{
				if (arr[i + 1] == arr[i]) arr.splice(i, 1);
			}
			return arr;
		}
		public static function splitWordBySpecial(str:String):Array
		{
			var rst:Array;
			rst = [];
			var i:int, len:int;
			len = str.length;
			var tStart:Number;
			var tEnd:Number;
			tStart = 0;
			tEnd = tStart;
			var tChar:String;
			var lastChar:int;
			lastChar = -1;
			
			while (tEnd < len)
			{
				
				//if (tEnd >= len)
				//{
					//break;
				//}
				tChar = str.charAt(tEnd);
				if (PingYinDic.checkIsHasSpecialStr(tChar))
				{
					rst.push(str.substring(tStart, tEnd), tChar);
					lastChar = tEnd;
					tStart = tEnd + 1;
					tEnd = tStart;
				}else
				{
					tEnd++;
				}
				
			}
			
			if (tStart > lastChar&&tStart<len)
			{
				rst.push(str.substring(tStart));
			}
			
			return rst;
		}
		
		public static function arr2keyObj(arr:Array, KeyList:Array):Object
		{
			var rst:Object;
			rst = new Object();
			var i:int, len:int;
			len = KeyList.length;
			for (i = 0; i < len; i++)
			{
				rst[KeyList[i]] = arr[i];
			}
			return rst;
		}
	}

}