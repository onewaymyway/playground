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
			
			var reg = /[\u4E00-\u9FA5\uF900-\uFA2D]/;
			return reg.test(obj);
		}
		
		public static function isPinYin(line:String):Boolean {
			if (line.length < 1)
				return false;
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
	
	}

}