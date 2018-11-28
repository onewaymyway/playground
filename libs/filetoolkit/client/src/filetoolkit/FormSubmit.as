package filetoolkit 
{
	import laya.net.HttpRequest;
	import laya.events.Event;
	/**
	 * ...
	 * @author ww
	 */
	public class FormSubmit extends HttpRequest
	{
		
		public function FormSubmit() 
		{
			
		}
		public static function getFormData(data:Object):Object
		{
			var rst:Object;
			__JS__("rst=new FormData()");
			var key:String;
			for (key in data)
			{
				trace("addKey:",key,data[key]);
				rst.append(key, data[key]);
			}
			return rst;
		}
		public function submit(url:String, data:* = null, method:String = "post", responseType:String = "text"):void
		{
			send(url, getFormData(data), method, responseType,[]);
		}
	}

}