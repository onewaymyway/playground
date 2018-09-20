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
				case DebugMsgConst.UpdateNodeProps:
					updateNodeProps(dataO.data);
					break;
			}
		}
		
		private function updateNodeProps(dataO:Object):void
		{
			var rootO:Object;
			rootO = dataO.root;
			var nodeO:Object;
			nodeO = dataO.node;
			//debugger;
			var node:Object;
			node = RemoteWorkUtils.findNodeByCompId(nodeO.compId, rootO.gid);
			if (!node) return;
			RemoteWorkUtils.updateNodeProp(node, nodeO.props);
		}
		
	}

}