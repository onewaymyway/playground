package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class DeviceOrientation 
	{
		
		public function DeviceOrientation() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  		/**
  		 * clearDeviceOrientationOverride
  		 * Clears the overridden Device Orientation.
  		 * @return 
  		 */	
  		public static function clearDeviceOrientationOverride(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DeviceOrientation.clearDeviceOrientationOverride", paramO);
  		}
  		
  		/**
  		 * setDeviceOrientationOverride
  		 * Overrides the Device Orientation.
  		 * @param alpha:number optional:{#@optional#} Mock alpha
  		 * @param beta:number optional:{#@optional#} Mock beta
  		 * @param gamma:number optional:{#@optional#} Mock gamma
  		 * @return 
  		 */	
  		public static function setDeviceOrientationOverride(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("DeviceOrientation.setDeviceOrientationOverride", paramO);
  		}
  		
	}

}