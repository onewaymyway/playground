package commontools 
{
	/**
	 * ...
	 * @author ww
	 */
	public class RevertDic 
	{
		public var revertDic:Object = { };
		public function RevertDic() 
		{
			
		}
		
		public function reset():void
		{
			revertDic = { };
		}
		
		public function addValue(value:String, transValue:String):void
		{
			revertDic[transValue] = value;
		}
		
		public function addLangValue(value:String):String
		{
			var langValue:String;
			langValue = Sys.lang(value);
			revertDic[langValue] = value;
			return langValue;
		}
		
		public function addLangValues(values:Array):Array
		{
			var i:int, len:int;
			len = values.length;
			var rst:Array;
			rst = [];
			for (i = 0; i < len; i++)
			{
				rst.push(addLangValue(values[i]));
			}
			return rst;
		}
		
		
		public function getRevertValue(transValue:String):String
		{
			if (revertDic.hasOwnProperty(transValue))
			{
				return revertDic[transValue];
			}
			return transValue;
		}
		
	}

}