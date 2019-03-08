package nlp.cutwords 
{
	/**
	 * ...
	 * @author ww
	 */
	public class CharDicCutter 
	{
		public var allDic:Object={};
		
		public function CharDicCutter() 
		{
			
		}
		
		public function addCutDic(type:String, charDic:Object):void
		{
			var tConfig:Object;
			tConfig = { };
			tConfig.type = type;
			tConfig.charDic = charDic;
			var key:String;
			for (key in charDic)
			{
				allDic[key] = tConfig;
			}
		}
		
		
		public function findMaxWord(str:String, tPos:int):WordPiece
		{
			var tChar:String;
			tChar = str.charAt(tPos);
			var tCutConfig:Object;
			tCutConfig = allDic[tChar];
			if (!tCutConfig) return null;
			
			
			var tPiece:WordPiece;
			tPiece = new WordPiece();
			tPiece.start = tPos;
			tPiece.end = tPos + 1;
			
			var charDic:Object;
			charDic = tCutConfig.charDic;
			var start:int;
			start = tPos;
			var end:int;
			end = tPos;
			while (charDic[tChar])
			{
				tPiece.end = tPiece.end+1;
				if (tPiece.end >= str.length) break;
				tChar = str.charAt(tPiece.end);
			}
			tPiece.word = str.substring(tPiece.start, tPiece.end);
			tPiece.type = tCutConfig.type;
			return tPiece;
		}
		
		public function findMaxWordR(str:String, tPos:int):WordPiece
		{
			var tChar:String;
			tChar = str.charAt(tPos);
			var tCutConfig:Object;
			tCutConfig = allDic[tChar];
			if (!tCutConfig) return null;
			
			
			var tPiece:WordPiece;
			tPiece = new WordPiece();
			tPiece.start = tPos;
			tPiece.end = tPos + 1;
			
			var charDic:Object;
			charDic = tCutConfig.charDic;
			var start:int;
			start = tPos;
			var end:int;
			end = tPos;
			while (charDic[tChar])
			{
				tPiece.start = start;
				start--;
				if (start<0) break;
				tChar = str.charAt(start);
			}
			tPiece.word = str.substring(tPiece.start, tPiece.end);
			tPiece.type = tCutConfig.type;
			return tPiece;
		}
		
		
	}

}