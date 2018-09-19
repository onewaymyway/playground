package remotedebugtool.common 
{
	/**
	 * ...
	 * @author ww
	 */
	public class MsgConst 
	{
		public static const Hello:String = "hello";
		public static const JoinChannel:String = "joinchannel";
		public static const ToChannelOther:String = "tochannelother";
		public function MsgConst() 
		{
			
		}
		
		public static function createMsg(type:String, data:Object):Object
		{
			var rst:Object;
			rst = { };
			rst.type = type;
			rst.data = data;
			return rst;
		}
		
	}

}