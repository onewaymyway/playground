package code 
{
	import laya.debug.tools.StringTool;
	/**
	 * ...
	 * @author ww
	 */
	public class CodeCreateTool 
	{
		
		public function CodeCreateTool() 
		{
			
		}
		/**
		 * 根据代码模板和数据生成代码
		 * @param tplStr
		 * @param data
		 * @return
		 *
		 */
		public static function createExportCode(tplStr:String, data:Object,trans:Object=null):String {
			var rst:String;
			var key:String;
			rst = tplStr;
			var tTar:String;
			for (key in data) {
				tTar = data[key];
				if (trans && trans[tTar]) tTar = trans[tTar];
				rst = StringTool.getReplace(rst, "{#@" + key + "#}", tTar);
			}
			return rst;
		}
		
		public static function addPreToStr(str:String, pre:String):String
		{
			var lines:Array;
			lines = str.split("\n");
			var i:int, len:int;
			len = lines.length;
			for (i = 0; i < len; i++)
			{
				lines[i] = pre + lines[i];
			}
			return lines.join("\n");
		}
		
		public static function createImportStr(importDic:Object):String
		{
			var importStrs:Array;
			importStrs = [];
			var key:String;
			for (key in importDic)
			{
				importStrs.push("	import " + key+";" );
			}
			return importStrs.join("\n");
		}
		
		public static function createDocStr(funO:Object,paramTpl:String="{#@name#} {#type#} {#@doc#}"):void
		{
			var docStrs:Array;
			docStrs = [];
			docStrs.push("	/**");
			docStrs.push("	 * " + funO.name);
			if (funO.des)
			{
				docStrs.push("	 * " + funO.des);
			}
			if (funO.description)
			{
				docStrs.push("	 * " + funO.description);
			}
			
			var params:Array;
			params = funO.params;
			if (params && params.length > 0)
			{
				var i:int, len:int;
				len = params.length;
				var paramO:Object;
				for (i = 0; i < len; i++) {
					paramO = params[i];
					docStrs.push("	 * @param " +createExportCode(paramTpl,paramO));
				}
			}
			

			docStrs.push("	 * @return "+funO["return"]||"");
			
			docStrs.push("	 */");
			return docStrs.join("\n");
		}
	}

}