package debugprotocol 
{



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
  		public static const disable:String = "Performance.disable";
  	
  		/**
  		 * enable
  		 * Enable collecting and reporting metrics.
  		 * @return 
  		 */
  		public static const enable:String = "Performance.enable";
  	
  		/**
  		 * getMetrics
  		 * Retrieve current values of run-time metrics.
  		 * @return metrics:array optional:{#@optional#} Current values for run-time metrics.
  		 */
  		public static const getMetrics:String = "Performance.getMetrics";
	}

}