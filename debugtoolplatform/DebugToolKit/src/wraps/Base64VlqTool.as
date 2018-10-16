package wraps {
	
	/**
	 * ...
	 * @author ww
	 */
	public class Base64VlqTool {
		public static const Base64CodeStr:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
		
		public function Base64VlqTool() {
		
		}
		
		public static function encodeBase64(num:int):String {
			return Base64CodeStr[num];
		}
		
		private static var _base64Dic:Object;
		
		public static function decodeBase64(str:String):int {
			if (!_base64Dic) {
				_base64Dic = {};
				var i:int, len:int;
				len = Base64CodeStr.length;
				for (i = 0; i < len; i++) {
					_base64Dic[Base64CodeStr[i]] = i;
				}
			}
			return _base64Dic[str];
		}
		
		public static function encodeVlq(field:int):String {
			var vlq:String = "";
			var sign:int;
			sign = field < 0 ? 1 : 0;
			field = (field << 1) + sign;
			do {
				var byte:int = field & 0x1F;
				if ((field >> 5) > 0) {
					byte += 0x20;
				}
				
				vlq += encodeBase64(byte);
				
				field = field >> 5;
			} while (field > 0);
			
			return vlq;
		}
		
		public static function encodeVlqArr(segment:Array):String {
			var vlq:String = '';
			
			for (var fieldIndex:int = 0; fieldIndex < segment.length; ++fieldIndex) {
				var field:int = segment[fieldIndex];
				vlq += encodeVlq(field);
			}
			
			return vlq;
		}
		
		public static function decodeVlq(segment):Array {
			var bits:int = 0;
			var continuation:Boolean = false;
			var fields:Array = [];
			
			for (var i:int = 0; i < segment.length; ++i) {
				if (!continuation) {
					fields.push(0);
					bits = 0;
				}
				
				var byte:int = decodeBase64(segment[i]);
				
				continuation = (byte & 0x20) > 0; // 0b00100000
				fields[fields.length - 1] += (byte & 0x1F) * Math.pow(2, bits);
				bits += 5;
				
				if (!continuation) {
					if (fields[fields.length - 1] & 1) {
						fields[fields.length - 1] = -fields[fields.length - 1];
					}
					
					fields[fields.length - 1] = fields[fields.length - 1] >> 1;
				}
			}
			
			return fields;
		}
	}

}