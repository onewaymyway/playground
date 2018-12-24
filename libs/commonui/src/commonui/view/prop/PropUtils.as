package commonui.view.prop 
{
	/**
	 * ...
	 * @author ww
	 */
	public class PropUtils 
	{
		
		public function PropUtils() 
		{
			
		}
		
		public static function getNumberFix(value:Number):int
		{
			var str:String;
			str = value + "";
			var index:int;
			index = str.indexOf(".");
			if (index < 0) return 0;
			return str.length - index-1;
		}
		
		public static function numberToFixed(value:Number, fix:int=0):Number
		{
			if (fix <= 0)
			{
				return Math.floor(value);
			}
			var p:Number;
			p = Math.pow(10, fix);
			return Math.round(value * p) / p;
		}
		public static function mParseInt(v:*):int
		{
			return parseInt(v)||0;
		}
		public static function mParserFloat(v:*):Number
		{
			return parseFloat(v)||0;
		}
		public static function isNumber(value:*):Boolean
		{
			return  (parseFloat(value)==value);
		}
		public static function isNaNS(value:*):Boolean
		{
			return ( value.toString()=="NaN");
		}
		public static function isNaN(value:*):Boolean
		{
			if(typeof(value)=="number") return false;
			if(typeof(value)=="string")
			{
				if(parseFloat(value).toString()!="NaN")
				{
					if(parseFloat(value)==value)
					{
						return false;
					}
				}
			}
			return true;
		}
		
		public static function getDisplayPropObject(propO:Object):Object
		{
			return propO;
		}
		public static function getDefaultValueByType(valueType:String):*
		{
			var value:*;
			if(valueType.toLowerCase!=null)
			valueType = valueType.toLowerCase();
			switch (valueType) {
				case "int": 
				case "number": 
				case "snumber": 
				case "number":
				case "pnumber": 
				case "unumber":		
					value = 0;
					break;
				case "bool": 
					value = false;
					break;
				default:
					value="";
			}
			
			return value;
		}
		public static function getAdptValue(value:*, valueType:String):* {
			if (value != "") {
				if(valueType.toLowerCase!=null)
				valueType = valueType.toLowerCase();
				switch (valueType) {
				case "int": 
					value = mParseInt(value);
				case "number": 
				case "snumber": 
				case "number":
					
					value = parseFloat(value);
					break;
				case "pnumber": 
				case "unumber":
					
					value = Math.abs(parseFloat(value));
					break;
				case "bool": 
					value = (value == "true"||value==true) ? true : false;
					break;
				}
				if (isNaNS(value)) {
					value = 0;
				}
			}
			return value;
		}
	}

}