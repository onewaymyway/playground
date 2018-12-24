package mindmap.adpttool 
{
	/**
	 * ...
	 * @author ww
	 */
	public class ZMap2MindMapData 
	{
		
		public function ZMap2MindMapData() 
		{
			
		}
		
		public static function parse(dataStr:String):Object
		{
			var nodeO:Object;
			try
			{
				nodeO = JSON.parse(dataStr);
			}catch (e:*)
			{
				alert("转换出错");
			}
			nodeO = nodeO[0];
			if (!nodeO) return null;
			var rst:Object;
			rst = parseNode(nodeO);
			return rst;
		}
		public static function getAdptTitle(text:String):String
		{
			text = text.replace(/<[^>]+>/g, "");
			text = text.replace(/&nbsp;/ig, "");
			return text;
		}
		public static function parseNode(node:Object):Object
		{
			var rst:Object;
			rst = { };
			rst.label = getAdptTitle(node.title);
			rst.childs = [];
			var cList:Array;
			cList = node.children;
			if (cList && cList.length)
			{
				var i:int, len:int;
				len = cList.length;
				var tChild:Object;
				for (i = 0; i < len; i++)
				{
					tChild = cList[i];

					rst.childs.push(parseNode(tChild));
					
				}
			}
			return rst;
		}
		
	}

}