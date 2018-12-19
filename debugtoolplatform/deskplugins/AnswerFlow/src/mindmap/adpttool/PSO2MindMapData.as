package mindmap.adpttool 
{
	/**
	 * ...
	 * @author ww
	 */
	public class PSO2MindMapData 
	{
		
		public function PSO2MindMapData() 
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
			if (!nodeO) return null;
			var rst:Object;
			rst = parseNode(nodeO);
			return rst;
		}
		
		public static function parseNode(node:Object):Object
		{
			var rst:Object;
			rst = { };
			rst.label = node.title;
			rst.childs = [];
			var cList:Array;
			cList = node.leftChildren;
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