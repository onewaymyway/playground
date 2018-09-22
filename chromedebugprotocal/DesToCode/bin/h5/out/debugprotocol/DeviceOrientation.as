package debugprotocol.DeviceOrientation 
{



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
  		public static const clearDeviceOrientationOverride:String = "DeviceOrientation.clearDeviceOrientationOverride";
  	
  		/**
  		 * setDeviceOrientationOverride
  		 * Overrides the Device Orientation.
  		 * @param alpha:number optional:{#@optional#} Mock alpha
  		 * @param beta:number optional:{#@optional#} Mock beta
  		 * @param gamma:number optional:{#@optional#} Mock gamma
  		 * @return 
  		 */
  		public static const setDeviceOrientationOverride:String = "DeviceOrientation.setDeviceOrientationOverride";
	}

}