package nlp {
	
	/**
	 * ...
	 * @author ww
	 */
	public class PingYinDic {
		public var pinYinList:Array;
		
		public function PingYinDic() {
			pinYinList = [];
		}
		
		/**
		   @ function:检测特殊字符
		   @ param
		   @ str:待检测字符串
		 */
		public static function checkIsHasSpecialStr(str:String):Boolean {
			var pattern:* = new RegExp("[`~!@#$^&*()=|{}':;',\\[\\].<>《》/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]");
			if (pattern.test(str)) {
				return true;
			}
			return false;
		
		}
		
		public static function hasChina(obj:String):Boolean {
			
			var reg:* = /[\u4E00-\u9FA5\uF900-\uFA2D]/;
			return reg.test(obj);
		}
		
		public static function isPinYin(line:String):Boolean {
			if (line.length < 1)
				return false;
			if (line.charAt(0) =="∶") return false;
			if (checkIsHasSpecialStr(line))
				return false;
			if (hasChina(line))
				return false;
			var char0:String;
			char0 = line.charAt(0);
			var charCode0:int;
			charCode0 = line.charCodeAt(0);
			return true;
		}
		
		public function addIfOK(line:String):void {
			if (isPinYin(line)) {
				pinYinList.push(line);
			}
		}
		
		public var charDic:Object;
		public var headDic:Object;
		public function makeCharDic():void
		{
			charDic = { };
			headDic = { };
			var i:int, len:int;
			len = pinYinList.length;
			for (i = 0; i < len; i++)
			{
				addWordToDic(pinYinList[i]);
			}
		}
		public static const DebugChars:Array = ["’"];
		public static var DebugDic:Object;
		public static var EnglishCharDic:Object = { };
		public static var NumCharDic:Object = { };
		public static var NumCharDicCN:Object = { };
		public static var transDic:Object = {};
		public static function isNumChar(char:String):Boolean
		{
			return NumCharDic[char];
		}
		
		public static function isEnglishChar(char:String):Boolean
		{
			return EnglishCharDic[char];
		}
		
		public static function inits():void
		{
			DebugDic = WordUtils.arrToDic(DebugChars);
			var i:int, len:int;
			var start:int;
			start = "A".charCodeAt(0);
			len = "Z".charCodeAt(0);
			for (i = start; i <= len; i++)
			{
				EnglishCharDic[String.fromCharCode(i)] = true;
			}
			start = "a".charCodeAt(0);
			len = "z".charCodeAt(0);
			for (i = start; i <= len; i++)
			{
				EnglishCharDic[String.fromCharCode(i)] = true;
			}
			for (i = 0; i < 10; i++)
			{
				NumCharDic[i] = true;
			}
			start = "０".charCodeAt(0);
			len = "９".charCodeAt(0);
			for (i = start; i <= len; i++)
			{
				NumCharDic[String.fromCharCode(i)] = true;
				transDic[String.fromCharCode(i)] = (i - start) + "";
			}
			
			var numCN0:String = "一二三四五六七八九十百千万亿兆";
			var numCN1:String = "壹贰叁肆伍陆柒捌玖拾佰仟";
			len = numCN0.length;
			for (i = 0; i < len; i++)
			{
				NumCharDicCN[numCN0.charAt(i)] = true;
			}
			len = numCN1.length;
			for (i = 0; i < len; i++)
			{
				transDic[numCN1.charAt(i)] = numCN0.charAt(i);
			}
		}
		inits();
		public function addWordToDic(word:String):void
		{
			var charList:Array;
			charList = word.split("");
			if (!charList.length) return;
			var i:int, len:int;
			len = charList.length;
			var tChar:String;
			tChar = charList[0];
			headDic[tChar] = tChar;
			for (i = 0; i < len; i++)
			{
				tChar = charList[i];
				charDic[tChar] = tChar;
				//if (DebugDic.hasOwnProperty(tChar))
				//{
					//trace("debugChar:",word);
				//}
			}
		}
	
	}

}