package chromedebug {
	import debugprotocol.Page;
	import laya.events.Event;
	import laya.events.EventDispatcher;
	import laya.net.Socket;
	import laya.utils.Byte;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ChromeSocket extends EventDispatcher {
		public var socket:Socket;
		public var userName:String;
		public var md5Pwd:String;
		public var isLogined:Boolean;
		private var _serverStr:String;
		public static const OnServerMsg:String = "OnServerMsg";
		public static const Welcome:String = "welcome";
		public static const OnJoinedChannel:String = "OnJoinedChannel";
		public static const OnChannelMsg:String = "OnChannelMsg";
		
		public var channel:String;
		public function ChromeSocket() {
			socket = new Socket("127.0.0.1", 0, Byte);
			socket.disableInput = true;
			
			socket.on(Event.OPEN, this, onConnect);
			socket.on(Event.MESSAGE, this, onMessage);
			socket.on(Event.ERROR, this, onErr);
			socket.on(Event.CLOSE, this, onClose);
			
			ChromeMsg.socket = this;
		}
		public var autoOpenUrl:String = "http://baidu.com";
		public function connectByTargetO(targetO:Object):void
		{
			var targetPath:String;
			targetPath = targetO["webSocketDebuggerUrl"];
			connect(targetPath);
		}
		public function connect(serverStr:String):void {
			_serverStr = serverStr;
			socket.connectByUrl(serverStr);
		}
		
		private function onConnect():void {
			trace('socket connect');
			if (autoOpenUrl)
			{
				//sendCmd(Page.enable);
				Page.enable();
				Page.navigate({ url:autoOpenUrl });

				//sendCmd(Page.navigate,{ url:autoOpenUrl });
			}

		}
		
		public function sendCmd(method:String, params:Object=null):void
		{
			sendJson(ChromeMsg.createCmd(method,params));
		}
		
		public function sendCmdAndWaitReplay(cmdO:Object):Promise
		{
			function sendPromise(resolve:Function, reject:Function):void
			{
				sendJson(cmdO);
				_resolveDic[cmdO.id] = resolve;
			}
			var promise:* = new Promise(sendPromise);
			
			return promise;
		}
		
		private var _resolveDic:Object = { };
		private function onMessage(msg:String):void {
			trace('socket onMessage');
			trace("Msg:" + msg);
			var dataO:Object;
			dataO = JSON.parse(msg);
			trace("MsgO:" + dataO);
			
			var tMethodId:int;
			tMethodId = dataO.id;
			if (tMethodId && _resolveDic[tMethodId])
			{
				trace("resolve:",tMethodId,dataO.result);
				_resolveDic[tMethodId](dataO.result);
				delete _resolveDic[tMethodId];
			}

		}
		
		
		
		private var msgID:int = 0;
		
		private function send(msg:String):void {
			msgID++;
			msg = msg + msgID;
			trace("try send:" + msg);
			socket.send(msg);
		}
		
		public function sendJson(obj:Object):void {
			if (!obj)
				return;
			socket.send(JSON.stringify(obj));
		}
		
		
		public function closeLater():void {
			socket.close();
			trace("after close");
		}
		
		private function onErr(e:*):void {
			trace('socket onErr', e);
		}
		
		private function onClose():void {
			trace('socket onClose');
			//Laya.timer.once(1000, this, closeLater);
		}
	}

}