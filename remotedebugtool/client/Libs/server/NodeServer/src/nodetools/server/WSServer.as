package nodetools.server {
	import nodetools.devices.NodeJSTools;
	
	/**
	 * ...
	 * @author ww
	 */
	public class WSServer {
		
		public function WSServer() {
		
		}
		public var serverO:*;
		public var clients:Array = [];
		public var clientClz:Class;
		public var channelDic:Object = { };
		public function run(config:Object):void {
			var WebSocket:* = NodeJSTools.require("ws");
			var _self:WSServer;
			_self = this;
			var serverO = new WebSocket.Server(config);
			serverO.on('connection', function connection(ws) {
					_self.onConnection(ws);
				});
		}
		
		protected function createClient():WSClient
		{
			if (clientClz) return new clientClz();
			return new WSClient();
		}
		
		private function onConnection(ws:*) {
			var tClient:WSClient = createClient();
			tClient.init(ws,this);
			clients.push(tClient);			
		}
		public function removeClient(client:WSClient):void
		{
			var i:int, len:int;
			len = clients.length;
			for (i = 0; i < len; i++)
			{
				if (clients[i] == client)
				{
					clients.splice(i, 1);
					removeFromChannel(client);
					break;
				}
			}
		}
		
		public function removeFromChannel(client:WSClient):void
		{
			var channelKey:String;
			channelKey = client.channel;
			var channel:Array;
			channel = channelDic[channelKey];
			if (!channel) return;
			var i:int, len:int;
			len = channel.length;
			for (i = 0; i < len; i++)
			{
				if (channel[i] == client)
				{
					channel.splice(i, 1);
					return;
				}
			}
		}
		public function addToChannel(client:WSClient):void
		{
			var channel:Array;
			if (!channelDic[client.channel])
			{
				channelDic[client.channel] = [];
			}
			channel = channelDic[client.channel];
			if (channel.indexOf(client) < 0)
			{
				channel.push(client);
			}
		}
		
		public function sendToChannel(data:*,channelName:String,but:WSClient):void
		{
			var channel:Array;
			channel = channelDic[channelName];
			if (!channel) return;
			var i:int, len:int;
			len = channel.length;
			var tClient:WSClient;
			for (i = 0; i < len; i++)
			{
				tClient = channel[i];
				if (tClient != but)
				{
					tClient.send(data);
				}
			}
		}
		public function sendToAll(data:*, but:WSClient):void
		{
			var i:int, len:int;
			len = clients.length;
			var tClient:WSClient;
			for (i = 0; i < len; i++)
			{
				tClient = clients[i];
				if (tClient != but)
				{
					tClient.send(data);
				}
			}
		}
	}

}