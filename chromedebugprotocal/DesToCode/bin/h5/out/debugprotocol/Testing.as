package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Testing 
	{
		
		public function Testing() 
		{
			
		}
		public static const DependDomains:Array=[Page];
  	
  		/**
  		 * generateTestReport
  		 * Generates a report for testing.
  		 * @param message:string optional:{#@optional#} Message to be displayed in the report.
  		 * @param group:string optional:true Specifies the endpoint group to deliver the report to.
  		 * @return 
  		 */	
  		public static function generateTestReport(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Testing.generateTestReport", paramO);
  		}
  		
	}

}