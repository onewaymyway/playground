package nlp.cutwords 
{
	import nlp.algorithm.map.MapStruct;
	import nlp.dictools.TypeDicParser;
	import nlp.trie.Trie;
	import nlp.trie.TrieNode;
	import nlp.WordUtils;
	/**
	 * ...
	 * @author ww
	 */
	public class WordCutter 
	{
		public var trie:Trie;
		public var typeDic:TypeDicParser;
		public function WordCutter() 
		{
			
		}
		
		public function cut(str:String):Array
		{
			
			var splitStrs:Array;
			splitStrs = WordUtils.splitWordBySpecial(str);
			trace("cutStr:",str);
			trace("split:", splitStrs);
			var i:int, len:int;
			var rst:Array;
			var tempRst:Array;
			rst = [];
			len = splitStrs.length;
			for (i = 0; i < len; i++)
			{
				tempRst = cutSmallPiece(splitStrs[i]);
				rst = rst.concat(tempRst);
			}
			return rst;
		}
		
		public function cutSmallPiece(str:String):Array
		{
			trace("cutSmall:",str);
			var rst:Array;
			rst = cutWork(str);
			var score:Number;
			score = WordUtils.scoreWordList(rst);
			trace("cut:"+score, rst);
			var rst1:Array;
			rst1 = cutWorkR(str);
			var score1:Number;
			score1 = WordUtils.scoreWordList(rst1);
			trace("cut:"+score1, rst1);
			var isSame:Boolean;
			isSame = WordUtils.isWordListSame(rst, rst1);
			trace("isSame:", isSame);
			if (!isSame)
			{
				if (score > score1)
				{
					return rst;
				}else
				{
					return rst1;
				}
			}
			//return cutWork(str);
			return rst;
		}
		
		public function cutToMap(str:String):void
		{
			var i:int, len:int;
			len = str.length;
			var map:MapStruct;
			map = new MapStruct();
			
			for (i = 0; i < len; i++)
			{
				findWordToMap(str, i, map);
				
			}
			var wList:Array;
			wList = map.findMaxWeightPath(str.length - 1);
			trace("wList:",wList);
		}
		
		private function findWordToMap(str:String,pos:int, map:MapStruct):void
		{
			var start:int;
			start = pos;
			var tChar:String;
			var tchar:String;
			tchar = str.charAt(pos);
			var tTrieNode:TrieNode;
			tTrieNode = trie.findByChar(tchar);
			if (!tTrieNode)
			{
				map.addEdge(start, pos+1, WordUtils.getWordScore(tchar), tchar);
			}
			while (tTrieNode)
			{
				if (tTrieNode.isWord())
				{
					map.addEdge(start, pos+1, 1/WordUtils.getWordScore(tTrieNode.word.word), tTrieNode);
				}
				pos++;
				tchar = str.charAt(pos);
				tTrieNode = tTrieNode.findByChar(tchar);
			}
		}
		
		private function cutWork(str:String):Array
		{
			var tPos:int;
			tPos = 0;
			var rst:Array;
			rst = [];
			var tPiece:WordPiece;
			while (tPos < str.length)
			{
				tPiece = findMaxWord(str, tPos);
				if (!tPiece) break;
				rst.push(tPiece);
				tPos = tPiece.end;
			}
			
			return rst;
		}
		
		private function cutWorkR(str:String):Array
		{
			var tPos:int;
			tPos = str.length-1;
			var rst:Array;
			rst = [];
			var tPiece:WordPiece;
			while (tPos >=0)
			{
				tPiece = findMaxWordR(str, tPos);
				if (!tPiece) break;
				rst.push(tPiece);
				tPos = tPiece.start-1;
			}
			rst.reverse();
			return rst;
		}
		
		public function adptPiece(piece:WordPiece):WordPiece
		{
			piece.update();
			if (typeDic)
			{
				piece.typeO = typeDic.getWordType(piece.word);
			}
			
			return piece;
		}
		public function findMaxWord(str:String, pos:int = 0):WordPiece
		{
			var tchar:String;
			tchar = str.charAt(pos);
			var tTrieNode:TrieNode;
			tTrieNode = trie.findByChar(tchar);
			
			var tPiece:WordPiece;
			tPiece = new WordPiece();
			tPiece.start = pos;
			tPiece.end = pos + 1;
			if (!tTrieNode)
			{
				tPiece.word = tchar;
				tPiece.type = "new";
				
				return adptPiece(tPiece);
			} 
			
			//tPiece
			if (tTrieNode.isWord())
			{
				tPiece.end = pos+1;
				tPiece.wordRef = tTrieNode.word;
			}else
			{
				tPiece.word = tchar;
				tPiece.type = "new";
			}
			var end:int;
			end = pos;
			var next:TrieNode;
			while (tTrieNode)
			{
				end++;
				if (end >= str.length)
				{
					break;
				}
				tchar = str.charAt(end);
				next = tTrieNode.findByChar(tchar);
				if (!next) break;
				tTrieNode = next;
				if (tTrieNode.isWord())
				{
					tPiece.end = end+1;
					tPiece.wordRef = tTrieNode.word;
				}
			}
			
			return adptPiece(tPiece);
		}
		
		public function findMaxWordR(str:String, pos:int = -2):WordPiece
		{
			if (pos == -2)
			{
				pos = str.length - 1;
			}
			var tchar:String;
			tchar = str.charAt(pos);
			var tTrieNode:TrieNode;
			tTrieNode = trie.findByCharR(tchar);
			
			var tPiece:WordPiece;
			tPiece = new WordPiece();
			tPiece.start = pos;
			tPiece.end = pos + 1;
			if (!tTrieNode)
			{
				tPiece.word = tchar;
				tPiece.type = "new";
				
				return adptPiece(tPiece);
			} 
			
			//tPiece
			if (tTrieNode.isWord())
			{
				tPiece.end = pos+1;
				tPiece.wordRef = tTrieNode.word;
			}
			
			if (!tTrieNode.isWord())
			{
				tPiece.word = tchar;
				tPiece.type = "new";
			}
			var start:int;
			start = pos;
			var next:TrieNode;
			while (tTrieNode)
			{
				start--;
				if (start < 0)
				{
					break;
				}
				tchar = str.charAt(start);
				next = tTrieNode.findByChar(tchar);
				if (!next) break;
				tTrieNode = next;
				if (tTrieNode.isWord())
				{
					tPiece.start = start;
					tPiece.wordRef = tTrieNode.word;
				}
			}
			
			
			return adptPiece(tPiece);
		}
		
		
	}

}