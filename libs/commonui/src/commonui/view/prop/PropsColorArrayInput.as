package commonui.view.prop 
{
	import laya.debug.tools.ColorTool;
	/**
	 * ...
	 * @author ww
	 */
	public class PropsColorArrayInput extends PropsColorInput 
	{
		
		public function PropsColorArrayInput() 
		{
			super();
			
		}
		
		public function getAlpha():Number
		{
			return _colorArr[3];
		}
		public static function getColorStrByColorArr(colorArr:Array,rate:Number=255):String
		{
			return "#" + ColorTool.getColorBit(colorArr[0]*rate) + ColorTool.getColorBit(colorArr[1]*rate) + ColorTool.getColorBit(colorArr[2]*rate);
		}
		
		public static function colorStrToColorArray(tColorStr:String,alpha:Number=1):Array
		{
			var rgbs:Array;
			rgbs=ColorTool.getRGBByRGBStr(tColorStr);
			var i:int,len:int;
			len = rgbs.length;
			var _colorArr:Array;
			_colorArr = [];
			_colorArr.length = 4;
			for(i=0;i<len;i++)
			{
				_colorArr[i]=rgbs[i]/255;
			}
			_colorArr[3] = alpha;
			return _colorArr;
		}
		
		override public function setTarget(target:*):void 
		{
			super.setTarget(target);
			initColor(getDisplayValue()||[1,1,1,1]);
		}
		
		override protected function updateColor(color:String):void 
		{
			if (!isSettingValue && _color != color)
			{
				setValueToTarget(colorStrToColorArray(color,getAlpha()));
			}
			_color = color;
			freshColorRec();
		}
		
		private var _colorArr:Array;
		private function initColor(colorArr:Array):void
		{
			_colorArr = colorArr;
			var colorStr:String;
			colorStr = getColorStrByColorArr(colorArr);
			updateColor(colorStr);
		}
	}

}