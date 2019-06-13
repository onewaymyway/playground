package nlp.algorithm.datastruct 
{
	/**
	 * ...
	 * @author ww
	 */
	public class AutoTensor 
	{
		public var defaultValue:Number = 0;
		public var _dic:Object;
		public function AutoTensor() 
		{
			_dic = {};
		}
		
		public function hasValue(...args):Boolean
		{
			var i:int, len:int;
			len = args.length-1;
			var key:String;
			var tDic:Object;
			tDic = _dic;
			for (i = 0; i < len; i++)
			{
				key = args[i];
				if (!tDic[key])
				{
					return false;
				}
				tDic = tDic[key];
			}
			if (!tDic) return false;
			key = args[len];
			if (tDic.hasOwnProperty(key))
			{
				return true;
			}
			return false;
		}
		public function getValue(...args):*
		{
			var i:int, len:int;
			len = args.length-1;
			var key:String;
			var tDic:Object;
			tDic = _dic;
			for (i = 0; i < len; i++)
			{
				key = args[i];
				if (!tDic[key])
				{
					return defaultValue;
				}
				tDic = tDic[key];
			}
			if (!tDic) return defaultValue;
			key = args[len];
			if (tDic.hasOwnProperty(key))
			{
				return tDic[key];
			}
			return defaultValue;
		}
		public function setValue(value:*,...args):void
		{
			var i:int, len:int;
			len = args.length-1;
			var key:String;
			var tDic:Object;
			tDic = _dic;
			for (i = 0; i < len; i++)
			{
				key = args[i];
				if (!tDic[key])
				{
					tDic[key] = {};
				}
				tDic = tDic[key];

			}
			key = args[len];
			tDic[key] = value;
			
		}
		
	}

}