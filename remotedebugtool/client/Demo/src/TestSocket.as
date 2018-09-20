package  
{
	import laya.utils.Handler;
	import remotedebugtool.client.DebugClient;
	import remotedebugtool.client.DebugServer;
	import remotedebugtool.client.RemoteWorkUtils;
	import remotedebugtool.client.StockSocket;
	import remotedebugtool.ui.test.TestOrzUI;
	import remotedebugtool.view.EditorViewList;
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
			//testDebugClient();
			testDebugServer();
			Laya.loader.load("res/atlas/comp.atlas", new Handler(this, onResLoaded));
		}
		
		private function onResLoaded():void
		{
			initTestPage();
			//initControlPage();
		}
		private function initTestPage():void
		{
			var tpg:TestView;
			tpg = new TestView();
			Laya.stage.addChild(tpg);
			
			trace(RemoteWorkUtils.getAllTargetView());
			
			var tpg2:TestOrzUI;
			tpg2 = new TestOrzUI();
			tpg2.pos(600, 0);
			Laya.stage.addChild(tpg2);
		}
		
		private function initControlPage():void
		{
			var controlPage:EditorViewList;
			controlPage = new EditorViewList();
			controlPage.pos(600, 50);
			controlPage.connect("ws://127.0.0.1:9909");
			Laya.stage.addChild(controlPage);
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
		
		private var debugServer:DebugServer;
		private function testDebugServer():void
		{
			debugServer = new DebugServer();
			debugServer.connect("ws://127.0.0.1:9909");
		}
		
	}

}