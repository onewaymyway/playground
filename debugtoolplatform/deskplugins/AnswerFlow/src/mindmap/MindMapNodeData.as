package mindmap 
{
	/**
	 * ...
	 * @author ww
	 */
	public class MindMapNodeData 
	{
		public var id:int;
		public var label:String;
		public var parent:int;
		public var childs:Array=[];
		public var isOpen:Boolean = false;
		public function MindMapNodeData() 
		{
			
		}
		public function moveChild(child:MindMapNodeData,d:int=1):void
		{
			var index:int;
			index = childs.indexOf(child);
			if (index >= 0)
			{
				var tarIndex:int;
				tarIndex = index+d;
				var temp:MindMapNodeData;
				if (childs[tarIndex])
				{
					temp = child;
					childs[index] = childs[tarIndex];
					childs[tarIndex]=temp;
				}
			}
		}
		public function addChild(child:MindMapNodeData):void
		{
			childs.push(child);
			child.parent = this.id;
		}
		public function removeChild(child:Object):void
		{
			var i:int, len:int;
			len = childs.length;
			for (i = 0; i < len; i++)
			{
				if (childs[i] == child)
				{
					childs.splice(i, 1);
					return;
				}
			}
		}
		
		public function initByObject(obj:Object):MindMapNodeData
		{
			this.id = obj.id;
			this.label = obj.label;
			this.childs = obj.childs||[];
			this.parent = obj.parent;
			this.isOpen = obj.isOpen;
			return this;	
		}
		
		public static function createByObj(obj:Object,createChild:Boolean=false):MindMapNodeData
		{
			if (obj is MindMapNodeData) return obj as MindMapNodeData;
			var rst:MindMapNodeData;
			rst = new MindMapNodeData();
			rst.initByObject(obj);
			if (createChild)
			{
				var i:int, len:int;
				var childs:Array;
				childs = rst.childs;
				len = childs.length;
				for (i = 0; i < len; i++)
				{
					childs[i] = createByObj(childs[i], true);
				}
			}
			return rst;
		}
		
		public static function createByLabel(label:String):MindMapNodeData
		{
			var rst:MindMapNodeData;
			rst = new MindMapNodeData();
			rst.label = label;
			return rst;
		}
	}

}