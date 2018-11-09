package view {
	
	import extendui.KeyManager;
	import laya.events.Event;
	import laya.events.Keyboard;
	import laya.utils.Handler;
	import ui.deskplatform.ConfirmUI;
	
	/**确认框
	 * @author yung
	 */
	final public class Confirm extends ConfirmUI {
		private static var _instance:Confirm;
		
		public function Confirm()
		{
			on(Event.KEY_DOWN, this,onKeyDown);
		}
		public static function get instance():Confirm {
			return _instance ? _instance : _instance = new Confirm();
		}
		
		public var _handler:*;
		public var _args:Array;
		
		public static function show(msg:String, title:String, handler:*,args:Array=null,okName:String=null,cancelName:String=null):void {
			if(!okName) okName=Sys.lang("确定");
			if(!cancelName) cancelName=Sys.lang("取消");
			instance.okBtn.label=okName;
			instance.cancelBtn.label=cancelName;
			instance.start(msg, title, handler,args);
		}
		
		public function start(msg:String, title:String, handler:Function,args:Array=null):void {
			titleLbl.text = title;
			msgLbl.text = msg;
			_handler = handler;
			_args = args;
			popup();
//			Laya.stage.focus=this;
			KeyManager.setNewFocus(this);
		}
		
		override public function close(type:String = null):void {
			super.close(type);
			if (_handler != null) {
				var data:Array = [type == "sure",type];
				if(_handler is Handler)
				{
					(_handler as Handler).runWith(data);
				}else
				_handler.apply(null, _args ? _args.concat(data) : data);
			}
			KeyManager.restoreFocus();
		}
		protected function onKeyDown(e:*):void {
		
			switch(e.keyCode)
			{
				case Keyboard.ENTER:
					close("sure");
					break;
				case Keyboard.ESCAPE:
					close("cancel");
					break;
			}
		}
	}
}