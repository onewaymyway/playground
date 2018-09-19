package  
{
	import remotedebugtool.client.DebugClient;
	import remotedebugtool.client.StockSocket;
	/**
	 * ...
	 * @author ww
	 */
	public class TestSocket 
	{
		
		public function TestSocket() 
		{
			Laya.init(1000, 900);
			//test();
			testDebugClient();
		}
		
		private var socket:StockSocket;
		private function test():void
		{
			socket = new StockSocket();
			socket.channel = "debug";
			socket.on(StockSocket.OnJoinedChannel,this,onJoinedChannel);
			socket.connect("ws://127.0.0.1:9909");
		}
		
		private function onJoinedChannel():void
		{
			trace("onJoinedChannel");
			debugger;
			socket.sendToChannel({"hihi":"orz"});
		}
		
		
		private var debugClient:DebugClient;
		private function testDebugClient():void
		{
			debugClient = new DebugClient();
			debugClient.connect("ws://127.0.0.1:9909");
		}
		
	}

}