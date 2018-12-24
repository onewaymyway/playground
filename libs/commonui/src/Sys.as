package {
	import laya.debug.tools.StringTool;
	import laya.display.Input;
	import laya.utils.Browser;
	
	/**
	 * 编辑器全局静态入口
	 * @author yung
	 */
	public class Sys {
		
		
		public static var langPack:Object;
		public static function lang(body:String, ...args):String {
			var i:int, len:int;
			len = args.length;
			if(langPack&&langPack[body])
			{
				body=langPack[body];
			}
			for (i = 0; i < len; i++)
			{
				body = body.replace("{"+i+"}",args[i]);
			}
			return body;
		}
		
		public static function adptLangPack():void
		{
			if(!langPack) return;
			var key:String;
			var newKey:String;
			for(key in langPack)
			{
//				trace(key,key.indexOf("\\n"));
				if(key.indexOf("\\n")>=0)
				{
					newKey=StringTool.getReplace(key,"\\\\n","\n");
//					trace("newKey:",newKey,langPack[key]);
					langPack[newKey]=StringTool.getReplace(langPack[key],"\\\\n","\n");
				}
			}
		}
		
		public static function langArr(txtList:Array):Array
		{
			if(!langPack) return txtList;
			var i:int,len:int;
			len=txtList.length;
			var tTxt:String;
			for(i=0;i<len;i++)
			{
				tTxt=txtList[i];
				if(langPack[tTxt])
				{
					txtList[i]=langPack[tTxt];
				}
			}
			return txtList;
		}
	}
}