package chromedebug 
{
	import laya.utils.Browser;
	/**
	 * ...
	 * @author ww
	 */
	public class ChromeProtocolUtils 
	{
		
		public function ChromeProtocolUtils() 
		{
			
		}
		
		public static function getEnableableDomains():Array
		{
			debugger;
			var tar:*;
			tar = Browser.window.debugprotocol;
			var rst:Array;
			rst = [];
			var domain:*;
			var domainO:Object;
			for (key in tar)
			{
				domain = tar[key];
				if (domain.enable)
				{
					domainO = { };
					domainO.name = key;
					domainO.clz = domain;
					rst.push(domainO);
				}
			}
			return rst;
		}
	}

}