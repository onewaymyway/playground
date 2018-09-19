package  
{
	import laya.utils.Handler;
	import remotedebugtool.client.DebugClient;
	import remotedebugtool.client.RemoteWorkUtils;
	import remotedebugtool.client.StockSocket;
	import view.TestView;
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
			Laya.loader.load("res/atlas/comp.atlas", new Handler(this, initTestPage));
		}
		
		
		private function initTestPage():void
		{
			var tpg:TestView;
			tpg = new TestView();
			Laya.stage.addChild(tpg);
			
			trace(RemoteWorkUtils.getAllTargetView());
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