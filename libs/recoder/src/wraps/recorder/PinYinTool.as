package wraps.recorder {
	
	/**
	 * ...
	 * @author ww
	 */
	public class PinYinTool {
		public static var pinyin_dict_notone:Object = { };
		public static var wordToPinYinDic:Object={};
		//init();
		public function PinYinTool() {
		
			
		}
		public static function init(tpath:String):void
		{
			var py:String;
			for (py in pinyin_dict_notone)
			{
				var i:int, len:int;
				var str:String;
				str = pinyin_dict_notone[py];
				len = str.length;
				for (i = 0; i < len; i++)
				{
					wordToPinYinDic[str.charAt(i)] = py;
				}
			}
		}
		
		public static function getWordPinYin(word:String):String
		{
			return wordToPinYinDic[word] || word;
		}
		public static function changeWordsToPinyin(words:String):String
		{
			var tArr:Array;
			tArr = [];
			var i:int, len:int;
			len = words.length;
			for (i = 0; i < len; i++)
			{
				tArr.push(getWordPinYin(words.charAt(i)));
			}
			return tArr.join("");
		}
	
	}

}