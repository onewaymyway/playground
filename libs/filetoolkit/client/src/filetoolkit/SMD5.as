///////////////////////////////////////////////////////////
//  SMD5.as
//  Macromedia ActionScript Implementation of the Class SMD5
//  Created on:      2016-10-20 下午4:14:49
//  Original author: ww
///////////////////////////////////////////////////////////

package filetoolkit
{
	
	/**
	 * 
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2016-10-20 下午4:14:49
	 */
	public class SMD5
	{
		public function SMD5()
		{
		}
		/*
		* Add integers, wrapping at 2^32. This uses 16-bit operations internally
		* to work around bugs in some JS interpreters.
		*/
		public static function safeAdd (x:int, y:int):int {
			var lsw:int = (x & 0xFFFF) + (y & 0xFFFF);
			var msw:int = (x >> 16) + (y >> 16) + (lsw >> 16);
			return (msw << 16) | (lsw & 0xFFFF);
		}
		
		/*
		* Bitwise rotate a 32-bit number to the left.
		*/
		public static function bitRotateLeft (num:int, cnt:int):int {
			return (num << cnt) | (num >>> (32 - cnt))
		}
		
		/*
		* These functions implement the four basic operations the algorithm uses.
		*/
		public static function md5cmn (q:int, a:int, b:int, x:int, s:int, t:int):int {
			return safeAdd(bitRotateLeft(safeAdd(safeAdd(a, q), safeAdd(x, t)), s), b)
		}
		public static function md5ff (a:int, b:int, c:int, d:int, x:int, s:int, t:int):int {
			return md5cmn((b & c) | ((~b) & d), a, b, x, s, t)
		}
		public static function md5gg (a:int, b:int, c:int, d:int, x:int, s:int, t:int):int {
			return md5cmn((b & d) | (c & (~d)), a, b, x, s, t)
		}
		public static function md5hh (a:int, b:int, c:int, d:int, x:int, s:int, t:int):int {
			return md5cmn(b ^ c ^ d, a, b, x, s, t)
		}
		public static function md5ii (a:int, b:int, c:int, d:int, x:int, s:int, t:int):int {
			return md5cmn(c ^ (b | (~d)), a, b, x, s, t)
		}
		
		/*
		* Calculate the MD5 of an array of little-endian words, and a bit length.
		*/
		public static function binlMD5 (x:Array, len:int):Array {
			/* append padding */
			x[len >> 5] |= 0x80 << (len % 32)
			x[(((len + 64) >>> 9) << 4) + 14] = len
			
			var i:int;
			var olda:int;
			var oldb:int;
			var oldc:int;
			var oldd:int;
			var a:int = 1732584193;
			var b:int = -271733879;
			var c:int = -1732584194;
			var d:int = 271733878;
			
			for (i = 0; i < x.length; i += 16) {
				olda = a
				oldb = b
				oldc = c
				oldd = d
				
				a = md5ff(a, b, c, d, x[i], 7, -680876936)
				d = md5ff(d, a, b, c, x[i + 1], 12, -389564586)
				c = md5ff(c, d, a, b, x[i + 2], 17, 606105819)
				b = md5ff(b, c, d, a, x[i + 3], 22, -1044525330)
				a = md5ff(a, b, c, d, x[i + 4], 7, -176418897)
				d = md5ff(d, a, b, c, x[i + 5], 12, 1200080426)
				c = md5ff(c, d, a, b, x[i + 6], 17, -1473231341)
				b = md5ff(b, c, d, a, x[i + 7], 22, -45705983)
				a = md5ff(a, b, c, d, x[i + 8], 7, 1770035416)
				d = md5ff(d, a, b, c, x[i + 9], 12, -1958414417)
				c = md5ff(c, d, a, b, x[i + 10], 17, -42063)
				b = md5ff(b, c, d, a, x[i + 11], 22, -1990404162)
				a = md5ff(a, b, c, d, x[i + 12], 7, 1804603682)
				d = md5ff(d, a, b, c, x[i + 13], 12, -40341101)
				c = md5ff(c, d, a, b, x[i + 14], 17, -1502002290)
				b = md5ff(b, c, d, a, x[i + 15], 22, 1236535329)
				
				a = md5gg(a, b, c, d, x[i + 1], 5, -165796510)
				d = md5gg(d, a, b, c, x[i + 6], 9, -1069501632)
				c = md5gg(c, d, a, b, x[i + 11], 14, 643717713)
				b = md5gg(b, c, d, a, x[i], 20, -373897302)
				a = md5gg(a, b, c, d, x[i + 5], 5, -701558691)
				d = md5gg(d, a, b, c, x[i + 10], 9, 38016083)
				c = md5gg(c, d, a, b, x[i + 15], 14, -660478335)
				b = md5gg(b, c, d, a, x[i + 4], 20, -405537848)
				a = md5gg(a, b, c, d, x[i + 9], 5, 568446438)
				d = md5gg(d, a, b, c, x[i + 14], 9, -1019803690)
				c = md5gg(c, d, a, b, x[i + 3], 14, -187363961)
				b = md5gg(b, c, d, a, x[i + 8], 20, 1163531501)
				a = md5gg(a, b, c, d, x[i + 13], 5, -1444681467)
				d = md5gg(d, a, b, c, x[i + 2], 9, -51403784)
				c = md5gg(c, d, a, b, x[i + 7], 14, 1735328473)
				b = md5gg(b, c, d, a, x[i + 12], 20, -1926607734)
				
				a = md5hh(a, b, c, d, x[i + 5], 4, -378558)
				d = md5hh(d, a, b, c, x[i + 8], 11, -2022574463)
				c = md5hh(c, d, a, b, x[i + 11], 16, 1839030562)
				b = md5hh(b, c, d, a, x[i + 14], 23, -35309556)
				a = md5hh(a, b, c, d, x[i + 1], 4, -1530992060)
				d = md5hh(d, a, b, c, x[i + 4], 11, 1272893353)
				c = md5hh(c, d, a, b, x[i + 7], 16, -155497632)
				b = md5hh(b, c, d, a, x[i + 10], 23, -1094730640)
				a = md5hh(a, b, c, d, x[i + 13], 4, 681279174)
				d = md5hh(d, a, b, c, x[i], 11, -358537222)
				c = md5hh(c, d, a, b, x[i + 3], 16, -722521979)
				b = md5hh(b, c, d, a, x[i + 6], 23, 76029189)
				a = md5hh(a, b, c, d, x[i + 9], 4, -640364487)
				d = md5hh(d, a, b, c, x[i + 12], 11, -421815835)
				c = md5hh(c, d, a, b, x[i + 15], 16, 530742520)
				b = md5hh(b, c, d, a, x[i + 2], 23, -995338651)
				
				a = md5ii(a, b, c, d, x[i], 6, -198630844)
				d = md5ii(d, a, b, c, x[i + 7], 10, 1126891415)
				c = md5ii(c, d, a, b, x[i + 14], 15, -1416354905)
				b = md5ii(b, c, d, a, x[i + 5], 21, -57434055)
				a = md5ii(a, b, c, d, x[i + 12], 6, 1700485571)
				d = md5ii(d, a, b, c, x[i + 3], 10, -1894986606)
				c = md5ii(c, d, a, b, x[i + 10], 15, -1051523)
				b = md5ii(b, c, d, a, x[i + 1], 21, -2054922799)
				a = md5ii(a, b, c, d, x[i + 8], 6, 1873313359)
				d = md5ii(d, a, b, c, x[i + 15], 10, -30611744)
				c = md5ii(c, d, a, b, x[i + 6], 15, -1560198380)
				b = md5ii(b, c, d, a, x[i + 13], 21, 1309151649)
				a = md5ii(a, b, c, d, x[i + 4], 6, -145523070)
				d = md5ii(d, a, b, c, x[i + 11], 10, -1120210379)
				c = md5ii(c, d, a, b, x[i + 2], 15, 718787259)
				b = md5ii(b, c, d, a, x[i + 9], 21, -343485551)
				
				a = safeAdd(a, olda)
				b = safeAdd(b, oldb)
				c = safeAdd(c, oldc)
				d = safeAdd(d, oldd)
			}
			return [a, b, c, d]
		}
		
		/*
		* Convert an array of little-endian words to a string
		*/
		public static function binl2rstr (input:Array):String {
			var i:int;
			var output:String = ''
			var length32:int = input.length * 32
			for (i = 0; i < length32; i += 8) {
				output += String.fromCharCode((input[i >> 5] >>> (i % 32)) & 0xFF)
			}
			return output;
		}
		
		/*
		* Convert a raw string to an array of little-endian words
		* Characters >255 have their high-byte silently ignored.
		*/
		public static function rstr2binl (input:String):Array {
			var i:int;
			var output:Array = []
			output[(input.length >> 2) - 1] = undefined
			for (i = 0; i < output.length; i += 1) {
				output[i] = 0
			}
			var length8:int = input.length * 8
			for (i = 0; i < length8; i += 8) {
				output[i >> 5] |= (input.charCodeAt(i / 8) & 0xFF) << (i % 32)
			}
			return output;
		}
		
		/*
		* Calculate the MD5 of a raw string
		*/
		public static function rstrMD5 (s:String):String {
			return binl2rstr(binlMD5(rstr2binl(s), s.length * 8))
		}
		
		/*
		* Calculate the HMAC-MD5, of a key and some data (raw strings)
		*/
		public static function rstrHMACMD5 (key:String, data:String):String {
			var i:int;
			var bkey:Array = rstr2binl(key);
			var ipad:Array = [];
			var opad :Array= [];
			var hash:Array;
			ipad[15] = opad[15] = undefined;
			if (bkey.length > 16) {
				bkey = binlMD5(bkey, key.length * 8)
			}
			for (i = 0; i < 16; i += 1) {
				ipad[i] = bkey[i] ^ 0x36363636
				opad[i] = bkey[i] ^ 0x5C5C5C5C
			}
			hash = binlMD5(ipad.concat(rstr2binl(data)), 512 + data.length * 8)
			return binl2rstr(binlMD5(opad.concat(hash), 512 + 128))
		}
		
		/*
		* Convert a raw string to a hex string
		*/
		public static function rstr2hex (input:String):String {
			var hexTab:String = '0123456789abcdef';
			var output:String = '';
			var x:int;
			var i:int;
			for (i = 0; i < input.length; i += 1) {
				x = input.charCodeAt(i)
				output += hexTab.charAt((x >>> 4) & 0x0F) +
					hexTab.charAt(x & 0x0F)
			}
			return output
		}
		
		/*
		* Encode a string as utf-8
		*/
		public static function str2rstrUTF8 (input:String):String {
			return unescape(encodeURIComponent(input))
		}
		
		/*
		* Take string arguments and return either raw or hex encoded strings
		*/
		public static function rawMD5 (s:String):String {
			return rstrMD5(str2rstrUTF8(s))
		}
		public static function hexMD5 (s:String):String {
			return rstr2hex(rawMD5(s))
		}
		public static function rawHMACMD5 (k:String, d:String):String {
			return rstrHMACMD5(str2rstrUTF8(k), str2rstrUTF8(d))
		}
		public static function hexHMACMD5 (k:String, d:String):String {
			return rstr2hex(rawHMACMD5(k, d))
		}
		
		public static function md5 (string:String, key:String, raw:String):String {
			if (!key) {
				if (!raw) {
					return hexMD5(string)
				}
				return rawMD5(string)
			}
			if (!raw) {
				return hexHMACMD5(key, string)
			}
			return rawHMACMD5(key, string)
		}
		

	}
}