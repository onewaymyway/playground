package mindmap.adpttool 
{
	import laya.debug.tools.XML2Object;
	import laya.utils.Utils;
	/**
	 * ...
	 * @author ww
	 */
	public class MM2MindMapData 
	{
		
		public function MM2MindMapData() 
		{
			
		}
		
		public static function parse(mmXML:*):Object
		{
			mmXML=Utils.parseXMLFromString(mmXML);
			var obj:Object;
			obj = XML2Object.parse(mmXML);
			var rootNode:Object;
			rootNode = obj["c"]["map"]["c"]["node"];
			
			var rst:Object;
			rst = parseNode(rootNode);
			return rst;
		}
		
		public static function parseNode(node:Object):Object
		{
			var rst:Object;
			rst = { };
			rst.label = node.p.TEXT;
			rst.childs = [];
			var cList:Array;
			cList = node.cList;
			if (cList && cList.length)
			{
				var i:int, len:int;
				len = cList.length;
				var tChild:Object;
				for (i = 0; i < len; i++)
				{
					tChild = cList[i];
					if (tChild.Name == "node")
					{
						rst.childs.push(parseNode(tChild));
					}
				}
			}
			return rst;
		}
		
	}

}