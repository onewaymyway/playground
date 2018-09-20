package remotedebugtool.client 
{
	import laya.events.EventDispatcher;
	/**
	 * ...
	 * @author ww
	 */
	public class DebugClient extends EventDispatcher
	{
		protected var socket:StockSocket;
		public var channel:String = "debug";
		public static const OnReady:String = "OnReady";
		public static const OnRemoteInfo:String = "OnRemoteInfo";
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
			socket.sendToChannel( { "hihi":"debug" } );
			event(OnReady);
		}
		
		public function sendToChannel(obj:Object):void
		{
			socket.sendToChannel(obj);
		}
		
		public function sendTypedToChannel(type:String, obj:Object):void
		{
			socket.sendTypedToChannel(type, obj);
		}
		
		protected function onChannelMsg(dataO:Object):void
		{
			trace("onChannelMsg:", dataO);
			var curData:Object;
			curData = dataO.data;
			if (!curData) return;
			event(OnRemoteInfo, curData);
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