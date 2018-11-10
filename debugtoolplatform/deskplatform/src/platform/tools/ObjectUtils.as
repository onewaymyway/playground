package platform.tools {
	import extendui.ui.TextField;
	import laya.display.Sprite;

	
	/**对象工具集*/
	public class ObjectUtils {
		/**添加滤镜*/
		public static function addFilter(target:Sprite, filter:*):void {
			var filters:Array = target.filters || [];
			filters.push(filter);
			target.filters = filters;
		}
		
		/**清除滤镜*/
		public static function clearFilter(target:Sprite, filterType:Class):void {
			var filters:Array = target.filters;
			if (filters != null && filters.length > 0) {
				for (var i:int = filters.length - 1; i > -1; i--) {
					var filter:* = filters[i];
					if (filter is filterType) {
						filters.splice(i, 1);
					}
				}
				target.filters = filters;
			}
		}
		
		
		private static var _tf:TextField = new TextField();
		
		/**获得实际文本*/
		public static function getTextField(format:*, text:String = "Test"):TextField {
			//_tf.autoSize = "left";
			_tf.align="left";
			//_tf.defaultTextFormat = format;
			_tf.text = text;
			return _tf;
		}
		public static function measureTextWidth(format:*, text:String = "Test"):Number
		{
			return getTextField(format, text).width;
		}
	}
}