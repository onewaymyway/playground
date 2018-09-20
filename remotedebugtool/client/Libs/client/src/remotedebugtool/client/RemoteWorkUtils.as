package remotedebugtool.client 
{
	import laya.display.Node;
	/**
	 * ...
	 * @author ww
	 */
	public class RemoteWorkUtils 
	{
		
		public function RemoteWorkUtils() 
		{
			
		}
		public static const ViewSign:String="__$fileRefer";
		public static function walkTargetEX(target:Node,fun:Function,_this:*=null,filterFun:Function=null):void
		{			
			if (filterFun != null && !filterFun(target)) return;
			fun.apply(_this,[target]);
			var i:int;
			var len:int;
			var tChild:Node;
			var childs:Array;
			childs = target._childs||target._children;
			len=childs.length;
			for(i=0;i<len;i++)
			{
				tChild=childs[i];
				//fun.apply(_this,[tChild]);
				walkTargetEX(tChild,fun,_this,filterFun);
			}
		}
		
		private static var _gidDic:Object = { };
		public static function findNodeByGid(gid:int):Object
		{
			if (_gidDic[gid]) return _gidDic[gid];
			var item:Object;

			function workChild(child:Object):void
			{
				_gidDic[child.$_GID] = child;
				if (child.$_GID == gid)
				{
					item = child;
				}
			}
			walkTargetEX(Laya.stage, workChild, null, null);
			return item;
		}
		public static function findNodeByCompId(compId:int, rootGid:int=-1):*
		{
			var root:Object;
			if (rootGid)
			{
				root = findNodeByGid(rootGid);
			}
			if (!root) root = Laya.stage;
			var item:Object;

			function workChild(child:Object):void
			{
				_gidDic[child.compId] = child;
				if (child.compId == compId)
				{
					item = child;
				}
			}
			walkTargetEX(root, workChild, null, null);
			return item;
		}
		public static function updateNodeProp(node:Object, props:Object):void
		{
			var key:String;
			for (key in props)
			{
				node[key] = props[key];
			}
		}
		public static function updateNodePropByGid(gid:int, props:Object):void
		{
			var node:Object;
			node = findNodeByGid(gid);
			if (node)
			{
				updateNodeProp(node, props);
			}
		}
		public static function getAllTargetView():Array
		{
			var viewList:Array;
			viewList = [];
			function workChild(child:Object):void
			{
				if (child[ViewSign])
				{
					var obj:Object;
					obj = { };
					obj.path = child[ViewSign];
					obj.gid = child.$_GID;
					obj.compId = child.compId;
					viewList.push(obj);
				}
			}
			walkTargetEX(Laya.stage, workChild, null, null);
			return viewList;
		}
		
	}

}