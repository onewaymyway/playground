package extendui.layout
{
	import laya.display.Sprite;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	import laya.ui.Component;
	
	import laya.debug.tools.DisControlTool;
	import laya.debug.tools.IDTools;
	
	/**
	 * 本类用于处理对象之间的排版关系
	 * @author ww
	 */
	public class RelativePos
	{
		public static const Right:String = "right";
		public static const Left:String = "left";
		public static const Down:String = "down";
		public static const Up:String = "up";
		public static const Center:String = "center";
		public static const Out:String = "out";
		
		public static const EdgePercent:Number=0.1;
		public static function getDisMouseRelativePos(tTarget:Sprite,edgePercent:Number=EdgePercent):String
		{
			var pos:Point;
			pos = DisControlTool.getMousePoint(tTarget);
			if (pos.x < 0 || pos.x > tTarget.width || pos.y < 0 || pos.y > tTarget.height) return Out;
			if (pos.y < tTarget.height * edgePercent)
			{
				return Up;
			}
			else if (pos.y > tTarget.height * (1-edgePercent))
			{
				return Down;
			}
			else if (pos.x > tTarget.width *(1-edgePercent))
			{
				return Right;
			}else  if (pos.x < tTarget.width * edgePercent)
			{
				return Left;
			}else
			{
				return Center;
			}
			return Center;
		}
		
		public function RelativePos(fun:Function, tar:Sprite, to:Sprite, d:Number)
		{
			this.tar = tar;
			this.to = to;
			this.d = d;
			this._fun = fun;
		}
		/**
		 * 要处理的对象
		 */
		public var tar:Sprite;
		/**
		 * 参照的对象
		 */
		public var to:Sprite;
		/**
		 * 偏移值
		 */
		public var d:Number;
		/**
		 * 使用的排版 函数
		 */
		public var _fun:Function;
		
		/**
		 * 更新排版
		 *
		 */
		public function update():void
		{
			_fun(tar, to, d);
		}
		
		/**
		 * 右边对齐到
		 * @param tar
		 * @param to
		 * @param d
		 *
		 */
		public static function rightTo(tar:Component, to:Sprite, d:Number = 0):void
		{
			if (!to.parent)
				return;
			tar.right = Math.ceil((to.parent as Component).width - to.x + d);
		}
		
		/**
		 * 左边对齐到
		 * @param tar
		 * @param to
		 * @param d
		 *
		 */
		public static function leftTo(tar:Component, to:Sprite, d:Number = 0):void
		{
			tar.left = Math.ceil(to.x + to.width + d);
		}
		
		/**
		 * 下方对齐到
		 * @param tar
		 * @param to
		 * @param d
		 *
		 */
		public static function downTo(tar:Component, to:Sprite, d:Number = 0):void
		{
			if (!to.parent)
				return;
			tar.bottom = Math.ceil((to.parent as Component).height - to.y + d);
		}
		
		/**
		 * 上方对齐到
		 * @param tar
		 * @param to
		 * @param d
		 *
		 */
		public static function upTo(tar:Component, to:Sprite, d:Number = 0):void
		{
			tar.top = Math.ceil(to.y + to.height + d);
		}
		
		/**
		 * 获取节点保存用的关系数据
		 * @param tar
		 * @return
		 *
		 */
		public static function saveRelative(tar:Component):Object
		{
			var relativeO:Object;
			relativeO = tar["relativeO"];
			if (!relativeO)
				return {};
			var key:String;
			var rst:Object = {};
			for (key in relativeO)
			{
				rst[key] = IDTools.getObjID(relativeO[key]);
			}
			return rst;
		}
		public static const typeToFunO:Object = {"right": RelativePos.rightTo, "left": RelativePos.leftTo, "up": RelativePos.upTo, "down": RelativePos.downTo};
		
		/**
		 * 根据类型获取排版函数
		 * @param fun
		 * @return
		 *
		 */
		public static function getTypeByFun(fun:Function):String
		{
			var key:String;
			for (key in typeToFunO)
			{
				if (typeToFunO[key] == fun)
					return key;
			}
			return null;
		}
		public static const otherSideO:Object = {"right": "left", "left": "right", "up": "down", "down": "up"};
		
		public static function getOtherSide(type:String):String
		{
			return otherSideO[type];
		}
		
		/**
		 * 获取某一边只有该对象的拖动条
		 * @param o
		 * @return
		 *
		 */
		public static function getOnlySide(o:Component):String
		{
			var relativeO:Object;
			relativeO = o["relativeO"];
			if (!relativeO)
				return null;
			var type:String;
			var tBar:LayoutDragBar;
			var tRst:String;
			var tArea:Number = 0;
			var tRstBar:*;
//			trace("finding only side");
			for (type in relativeO)
			{
				tBar = relativeO[type];
				if (tBar)
				{
//					trace("has side:",type);
					if (tBar.isOnly(o))
					{
//						trace("onlySide:",type," value:",getBarWeight(tBar));
						if (!tRst || getBarWeight(tBar) > tArea)
						{
							tRst = type;
							tRstBar = tBar;
							tArea = getBarWeight(tBar);
//							trace("tArea:", tArea);
						}
							//return type;
					}
				}
			}
			return tRst;
		}
		
		private static function getBarWeight(bar:LayoutDragBar):Number
		{
			var tRec:Rectangle;
			tRec = bar.getDragArea();
			return tRec.width + tRec.height;
		}
		
		//public static function updateRelative(o:Component, dragBar:LayoutDragBar, type:String, d:Number = 0):void
		//{
		//
		//}
		/**
		 * 添加相对关系
		 * @param o
		 * @param dragBar
		 * @param type
		 * @param d
		 *
		 */
		public static function addRelative(o:Component, dragBar:*, type:String, d:Number = 0):void
		{
			if (!dragBar)
				return;
			
			cancelRelative(o, type);
			dragBar.addItem(o, typeToFunO[type]);
			var relativeO:Object;
			if (!o["relativeO"])
				o["relativeO"] = {};
			relativeO = o["relativeO"];
			relativeO[type] = dragBar;
		}
		
		/**
		 * 拷贝相对关系
		 * @param o
		 * @param tar
		 * @param type
		 *
		 */
		public static function copyRelative(o:Component, tar:Component, type:String):void
		{
			addRelative(o, getBar(tar, type), type);
		}
		
		/**
		 * 取消相对关系
		 * @param o
		 * @param sign
		 *
		 */
		public static function cancelRelative(o:Component, sign:String):void
		{
			var relativeO:Object;
			relativeO = o["relativeO"];
			if (!relativeO)
				return;
			
			if (relativeO[sign])
			{
				(relativeO[sign]).removeTarget(o);
			}
			delete relativeO[sign];
		}
		
		/**
		 * 获取对象某一方向的拖动条
		 * @param o
		 * @param sign
		 * @return
		 *
		 */
		public static function getBar(o:Component, sign:String):*
		{
			var relativeO:Object;
			relativeO = o["relativeO"];
			if (!relativeO)
				return null;
			
			return relativeO[sign];
		}
		
		/**
		 * 清楚对象的相对关系
		 * @param o
		 *
		 */
		public static function clearBar(o:Component):void
		{
			cancelRelative(o, RelativePos.Left);
			cancelRelative(o, RelativePos.Right);
			cancelRelative(o, RelativePos.Up);
			cancelRelative(o, RelativePos.Down);
		}
	}

}