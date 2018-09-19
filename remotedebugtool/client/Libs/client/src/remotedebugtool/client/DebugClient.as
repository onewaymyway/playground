package remotedebugtool.client 
{
	/**
	 * ...
	 * @author ww
	 */
	public class DebugClient 
	{
		private var socket:StockSocket;
		public var channel:String = "debug";
		public function DebugClient() 
		{
			socket = new StockSocket();
			
			socket.on(StockSocket.OnJoinedChannel, this, onJoinedChannel);
			socket.on(StockSocket.OnChannelMsg,this,onChannelMsg);
		}
		
		public function connect(server:String="ws://127.0.0.1:9909"):void
		{
			socket.channel = channel;
			socket.connect(server);
		}
		
		protected function onJoinedChannel():void
		{
			trace("onJoinedChannel");
			debugger;
			socket.sendToChannel({"hihi":"debug"});
		}
		
		protected function onChannelMsg(dataO:Object):void
		{
			trace("onChannelMsg:", dataO);
			var curData:Object;
			curData = dataO.data;
			if (!curData) return;
			dealChannelMsg(curData);

		}
		
		protected function dealChannelMsg(dataO:Object):void
		{
			switch(dataO.type)
			{
				
			}
		}
		
		
	}

}