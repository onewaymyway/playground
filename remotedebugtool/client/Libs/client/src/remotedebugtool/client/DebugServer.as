package remotedebugtool.client 
{
	/**
	 * ...
	 * @author ww
	 */
	public class DebugServer extends DebugClient 
	{
		
		public function DebugServer() 
		{
			super();
			
		}
		
		override protected function dealChannelMsg(dataO:Object):void 
		{
			super.dealChannelMsg(dataO);
			switch(dataO.type)
			{
				case DebugMsgConst.GetAllDebugView:
					socket.sendTypedToChannel(DebugMsgConst.GetAllDebugView, RemoteWorkUtils.getAllTargetView());
					break;
			}
		}
		
	}

}