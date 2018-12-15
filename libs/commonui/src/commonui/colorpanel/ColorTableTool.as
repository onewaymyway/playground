package commonui.colorpanel 
{
	import laya.debug.tools.ColorTool;
	/**
	 * ...
	 * @author ww
	 */
	public class ColorTableTool 
	{
		
		public function ColorTableTool() 
		{
			
		}
		
		private static var hueList:Array;
		private static var saturationList:Array;
		private static var birghtList:Array;
		private static var grayList:Array;
		public static function initList(start:Number, end:Number, count:int,includEnd:Boolean=true):Array
		{
			var i:int, len:int;
			len = count;
			var d:Number;
			d = (end - start) / count;
			var rst:Array;
			rst = [];
			if (includEnd)
			{
				start += d;
			}
			for (i = 0; i < len; i++)
			{
				rst.push(start+i*d);
			}
			return rst;
		}
		
		public static function createGrayColor(split:int = 8):Array
		{
			var arr:Array;
			arr = [];
			var i:int, len:int;
			len = split;
			var dLen:int;
			dLen = 255 / (split-1);
			var tValue:*;
			for (i = 0; i < len; i++)
			{
				tValue = Math.floor(i*dLen);
				tValue = ColorTool.getRGBStr([tValue, tValue, tValue]);
				arr.push(tValue);
			}
			return arr;
		}
		public static function createColorTable(circleSplit:int = 32, depthSplit:int = 8,startS:Number=0.2,endS:Number=1,startB:Number=0.1,endB:Number=1):Array
		{
			grayList = createGrayColor(depthSplit);
			hueList = initList(0, 360, circleSplit-1,false);
			saturationList = initList(startS, endS, depthSplit);
			birghtList = initList(startB, endB, depthSplit);
			var i:int, len:int;
			var j:int, jLen:int;
			len = circleSplit;
			jLen = depthSplit;
			var colors:Array;
			colors = [];
			
			
			for (i = 0; i < len; i++)
			{
				for (j = 0; j < jLen; j++)
				{
					if (i == len-1)
					{
						colors.push(changeColor(grayList[j]));
					}else
					colors.push(changeColor(ColorTool.getRGBStr(ColorTool.hsb2rgb(hueList[i], saturationList[j], birghtList[j]))));
				}
			}
			return colors;
		}
		
		public static function changeColor(str:String):String
		{
			//return str;
			var ___color:Array =  ColorTool.getRGBByRGBStr(str);
			return ColorTool.getRGBStr([(___color[0] >> 3 << 3), (___color[1] >> 3 << 3), (___color[2] >> 3 << 3)]);
		}
		
		public static function getHSBByRGB(color:String):Array
		{
			var rgb:Array;
			rgb = ColorTool.getRGBByRGBStr(color);
			return ColorTool.rgb2hsb(rgb[0],rgb[1],rgb[2]);
		}
		
		public static function RGB2Gray(color:String):Number
		{
			var rgb:Array;
			rgb = ColorTool.getRGBByRGBStr(color);
			return rgb[0] * 0.299 + rgb[1] * 0.587 + rgb[2] * 0.114;
		}
		
		public static function getTextColor(color:String):String{
			return RGB2Gray(color) > 200?"#000000":"#ffffff";
		}
	}

}