package nlp.algorithm 
{
	/**
	 * ...
	 * @author ww
	 */
	public class KeysCounter 
	{
		public var _dic:Object = {};
		public static const CountKey:String = "_@_Count";
		public static const TypeKey:String = "_@_Type";
		public function KeysCounter() 
		{
			_dic[CountKey] = 0;
			_dic[TypeKey] = 0;
		}
		public function getKeyRateNum(...args):Number
		{
			return getKeyNum.apply(this, args) / _dic[CountKey];
		}
		public function getKeyLogNum(...args):Number
		{
			var num:Number;
			num=(getKeyNum.apply(this, args)||0.5) / _dic[CountKey]
			return Math.log(num);
		}
		public function getKeyNum(...args):int
		{
			var i:int, len:int;
			len = args.length;
			var key:String;
			var tDic:Object;
			tDic = _dic;
			for (i = 0; i < len; i++)
			{
				key = args[i];
				if (!tDic[key])
				{
					return 0;
				}
				tDic = tDic[key];
			}
			if (!tDic) return 0;
			return tDic[CountKey];
		}
		public function addKey(...args):void
		{
			var i:int, len:int;
			len = args.length;
			var key:String;
			var tDic:Object;
			tDic = _dic;
			tDic[CountKey] = tDic[CountKey] + 1;
			for (i = 0; i < len; i++)
			{
				key = args[i];
				if (!tDic[key])
				{
					tDic[key] = {};
					tDic[key][CountKey] = 0;
					tDic[key][TypeKey] = 0;
					tDic[TypeKey] = tDic[TypeKey] + 1;
				}
				tDic = tDic[key];
				tDic[CountKey] = tDic[CountKey] + 1;
			}
		}
		
	}

}