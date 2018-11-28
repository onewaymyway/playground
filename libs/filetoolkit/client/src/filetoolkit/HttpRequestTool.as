package filetoolkit 
{
	import laya.events.Event;
	import laya.net.HttpRequest;
	import laya.utils.Handler;
	/**
	 * ...
	 * @author ww
	 */
	public class HttpRequestTool 
	{
		
		public function HttpRequestTool() 
		{
			
		}
		
		public static function request(url:String = null, data:Object = null, callback:Handler = null, method:String = "post", errHandler:Handler = null):void
		{
			var _http:FormSubmit = new FormSubmit();
			_http.on('complete', HttpRequestTool, function(t:*):void {
				var obj:Object = JSON.parse(t);
				trace("complete:",obj);
				callback && callback.runWith(obj);
			});
			
			_http.on(Event.ERROR, HttpRequestTool, function(msg:String):void {
				trace("error:",msg);
			});
			function sendMsg():void {
				var fullUrl:String = url;
				trace("发送消息" + fullUrl);
				//_http.send(fullUrl, data, method);
				_http.submit(fullUrl, data, method, "text");
			}
			sendMsg();
		}
	}

}