package chromedebug {
	import laya.events.Event;
	import laya.events.EventDispatcher;
	import laya.net.Socket;
	import laya.utils.Byte;
	import remotedebugtool.common.MsgConst;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ChromeSocket extends EventDispatcher {
		private var socket:Socket;
		public var userName:String;
		public var md5Pwd:String;
		public var isLogined:Boolean;
		private var _serverStr:String;
		public static const DataFromServer:String = "DataFromServer";
		public static const Logined:String = "Logined";
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
		}
		
		public function connect(serverStr:String):void {
			_serverStr = serverStr;
			socket.connectByUrl(serverStr);
		}
		
		private function onConnect():void {
			trace('socket connect');

		}
		
		private function onMessage(msg:String):void {
			trace('socket onMessage');
			trace("Msg:" + msg);
			var dataO:Object;
			//dataO = JSON.parse(msg);

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
		
		
		private function closeLater():void {
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