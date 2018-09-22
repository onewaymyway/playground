package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Performance 
	{
		
		public function Performance() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  		/**
  		 * metrics
  		 * Current values of the metrics.
  		 * @param metrics:array optional:{#@optional#} Current values of the metrics.
  		 * @param title:string optional:{#@optional#} Timestamp title.
  		 * @return 
  		 */
  		public static const metrics:String = "Performance.metrics";
  		/**
  		 * disable
  		 * Disable collecting and reporting metrics.
  		 * @return 
  		 */	
  		public static function disable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Performance.disable", paramO);
  		}
  		
  		/**
  		 * enable
  		 * Enable collecting and reporting metrics.
  		 * @return 
  		 */	
  		public static function enable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Performance.enable", paramO);
  		}
  		
  		/**
  		 * getMetrics
  		 * Retrieve current values of run-time metrics.
  		 * @return metrics:array optional:{#@optional#} Current values for run-time metrics.
  		 */	
  		public static function getMetrics(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Performance.getMetrics", paramO);
  		}
  		
	}

}