package platform.layout
{
	import extendui.layout.RelativePos;
	import laya.debug.tools.ObjectTools;
	import laya.display.Graphics;
	import laya.maths.MathUtil;
	import laya.maths.Rectangle;
	import laya.ui.Component;
	import laya.utils.HitArea;
	import laya.utils.Utils;
	import platform.managers.CursorManager;
	
	/**
	 * 布局框的拖动条
	 * @author ww
	 */
	public class LayoutDragBar extends DragBar
	{
		public var type:int;
		public static var ID:int=1;
		public var mId:int;
		public function LayoutDragBar(mouseType:String = "R")
		{
			super(mouseType);
			mId=ID;
			ID++;
			hitArea=new HitArea();
			this.zOrder=99;
		}
		public var walked:Boolean=false;
		/**
		 * 获取可拖动范围 
		 * @return 
		 * 
		 */
		public function getDragArea():Rectangle
		{
			var area:Rectangle;
			area = new Rectangle();
			var borderVar:Number;
			switch (type)
			{
				case LayoutRecManager.Horizon: 
					area.y = this.y;
					area.height = 0;
					area.x = getBorderVar(RelativePos.Right, "left", 0, false) + minWidth;
					borderVar = this.x + getBorderVar(RelativePos.Left, "width", 999, true);
					borderVar -= minWidth;
					if (borderVar < this.x)
						borderVar = this.x;
					area.width = borderVar - area.x;
					break;
				case LayoutRecManager.Vertical: 
					area.y = getBorderVar(RelativePos.Down, "top", 0, false) + minWidth;
					borderVar = this.y + getBorderVar(RelativePos.Up, "height", 999, true);
					borderVar -= minWidth;
					if (borderVar < this.y)
						borderVar = this.y;
					area.height = borderVar - area.y;
					area.x = this.x;
					area.width = 0;
					break;
			
			}
			return area;
		}
		
		public static const debugMode:Boolean=true;
		public static const BarDragAreaLen:int=4;
		override protected function changeSize():void
		{
			super.changeSize();
			//cacheAsBitmap = false;
			var g:Graphics = graphics;
			g.clear();
//			g.drawRect(0, 0, width, height, "#ffff00");
			//cacheAsBitmap = true;
//			if(debugMode)
//			{
//				g.fillText(""+mId,this.width*0.5,this.height*0.5,"100px Arial","#ff0000","center");
//			}
			var hArea:HitArea;
			hArea=hitArea;
			hArea.hit.clear();
			if(this.width<this.height)
			{
				hArea.hit.drawRect(-BarDragAreaLen,0,BarDragAreaLen*2,height,"#ff0000");
			}else
			{
				hArea.hit.drawRect(0,-BarDragAreaLen,width,BarDragAreaLen*2,"#ff0000");
			}
			
			updates();
		}
		public var _updaters:Array = [];
		
		public function updates():void
		{
			var i:int, len:int;
			len = _updaters.length;
			for (i = 0; i < len; i++)
			{
				_updaters[i].update();
			}
		}
		
		public static const minWidth:int = 220;
		
		private function getBorderVar(type:String, sign:String, sValue:Number, isMin:Boolean = true):Number
		{
			
			var i:int, len:int;
			var uList:Array = _updaters;
			len = uList.length;
			var tValue:Number;
			tValue = sValue;
			var tUpdater:RelativePos;
			var tFun:Function;
			tFun = RelativePos.typeToFunO[type];
			if (isMin)
			{
				for (i = 0; i < len; i++)
				{
					tUpdater = uList[i];
					if (tUpdater._fun == tFun)
					{
						if (tUpdater.tar[sign] < tValue)
						{
							tValue = tUpdater.tar[sign];
						}
					}
				}
			}
			else
			{
				for (i = 0; i < len; i++)
				{
					tUpdater = uList[i];
					if (tUpdater._fun == tFun)
					{
						if (tUpdater.tar[sign] > tValue)
						{
							tValue = tUpdater.tar[sign];
						}
					}
				}
			}
			
			return tValue;
		}
		
		public function clear():void
		{
			_updaters.length = 0;
		}
		
		/**
		 *  
		 * @param tar
		 * 
		 */
		public function mergeUpdates(tar:LayoutDragBar):void
		{
			if (!tar)
				return;
			//Utils.concatArr(_updaters, tar._updaters);
			var i:int, len:int;
			var tarUpdaters:Array;
			tarUpdaters = tar._updaters;
			tarUpdaters = ObjectTools.setValueArr([], tarUpdaters);
			len = tarUpdaters.length;
			var tR:RelativePos;
			var tType:String;
			for (i = 0; i < len; i++)
			{
				tR = tarUpdaters[i];
				tType = RelativePos.getTypeByFun(tR._fun);
				//RelativePos.cancelRelative(tR.tar, tType);
				if(tR.tar==this||tR.to==this) continue;
				RelativePos.addRelative(tR.tar as Component, this, tType, tR.d);
			}
			updates();
		}
		
		public function copyUpdates(tar:LayoutDragBar,side:String):void
		{
			var i:int,len:int;
			var tarUpdaters:Array;
			tarUpdaters = tar._updaters;
			tarUpdaters = ObjectTools.setValueArr([], tarUpdaters);
			len = tarUpdaters.length;
			var tR:RelativePos;
			var tType:String;
			for (i = 0; i < len; i++)
			{
				tR = tarUpdaters[i];
				tType = RelativePos.getTypeByFun(tR._fun);
				//RelativePos.cancelRelative(tR.tar, tType);
				if(tR.tar==this||tR.to==this) continue;
				if(side==tType)
				{
					RelativePos.addRelative(tR.tar as Component, this, tType, tR.d);
				}
				
			}
			updates();

		}
		/**
		 *  
		 * @param tar
		 * 
		 */
		public function removeTarget(tar:Object):void
		{
			var i:int, len:int;
			len = _updaters.length;
			for (i = len - 1; i >= 0; i--)
			{
				if (_updaters[i].tar == tar)
				{
					_updaters.splice(i, 1);
				}
			}
		}
		
		public function findTarType(tar:*):Function
		{
			var i:int, len:int;
			len = _updaters.length;
			var tR:RelativePos;
			for (i = 0; i < len; i++)
			{
				tR = _updaters[i];
				if (tR.tar == tar)
				{
					return tR._fun;
				}
			}
			return null;
		}
		public static var canMoveO:Object = null;
		public function canMove(dirType:String, len:Number):Boolean
		{
			if (!canMoveO)
			{
				canMoveO = { };
				
				var tO:Object;
				tO = { };
				tO[RelativePos.Left] = true;
				tO[RelativePos.Right] = true;
				canMoveO[LayoutRecManager.Horizon] = tO;
				
				tO = { };
				tO[RelativePos.Up] = true;
				tO[RelativePos.Down] = true;
				canMoveO[LayoutRecManager.Vertical] = tO;
			}
			if (!canMoveO[type][dirType]) return false;
			
			
			return false;
		}
		/**
		 * 对象所在的方向是否只有它一个对象 
		 * @param tar
		 * @return 
		 * 
		 */
		public function isOnly(tar:*):Boolean
		{
			if (type == LayoutRecManager.Side)
				return false;
			var i:int, len:int;
			len = _updaters.length;
			var fun:Function = findTarType(tar);
			if (fun==null)
				return false;
			var tR:RelativePos;
			for (i = 0; i < len; i++)
			{
				tR = _updaters[i];
				if ((tR._fun == fun) && (tR.tar != tar))
				{
					return false;
				}
				if (tR.tar != tar)
				{
					if (tR.tar is LayoutRec)
					{
						if ((tR.tar as LayoutRec).disMode == LayoutRec.Min)
						{
							return false;
						}
					}
				}
			}
			return true;
		}
		
		public function get _dragX():Number
		{
			return this.x;
		}
		public function set _dragX(value:Number):void
		{
			this.x=value;
			this.left=value;
			updates();
		}
		
		public function get _dragY():Number
		{
			return this.y;
		}
		public function set _dragY(value:Number):void
		{
			this.y=value;
			this.top=value;
			updates();
		}
		
		public function getSideType():String
		{
			if(_updaters.length>0)
			{
				return RelativePos.getTypeByFun(_updaters[0]._fun);
			}
			return null;
		}
		public function addItem(tar:*, fun:Function, d:Number = 0):void
		{
			var updater:RelativePos;
			updater = new RelativePos(fun, tar, this, 0);
			_updaters.push(updater);
		}
		public var relativeO:Object = {};
		
		public function clears():void
		{
			clear();
			this.destroy(false);
		}
		public function getTarsByType(type:String):Array
		{
			var i:int, len:int;
			len = _updaters.length;
			var tR:RelativePos;
			var tFun:Function;
			tFun=tFun = RelativePos.typeToFunO[type];
			var rst:Array;
			rst=[];
			for (i = 0; i < len; i++)
			{
				tR = _updaters[i];
				if (tR._fun == tFun)
				{
					rst.push(tR.tar);
				}
			}
			return rst;
		}
		public static function hasFreeTar(items:Array):Boolean
		{
			var i:int, len:int;
			len = items.length;
			var tRec:LayoutRec;
			for (i = 0; i < len; i++)
			{
				tRec = items[i];
				if (tRec is LayoutRec)
				{
					if(tRec.sizeFree)
					{
						return true;
					}
				}
				
			}
			return false;
		}
		public function getDragBarInfo(type:String=null):String
		{
			var rsts:Array;
			rsts=[];
			var i:int, len:int;
			len = _updaters.length;
			
			var tR:RelativePos;
			var dragBarList:Array;
			dragBarList=[];
			var tDragBar:LayoutDragBar;
			for (i = len - 1; i >= 0; i--)
			{
				tR=_updaters[i];
				if(tR.tar is LayoutRec)
				{
					if(type&&type==RelativePos.getTypeByFun(tR._fun))
					rsts.push((tR.tar as LayoutRec).tTabTxt);
				}			
			}
			return "id:"+mId+"_"+rsts.join(",");
		}
		private var sortByXFun:Function=MathUtil.sortByKey("x",false,true);
		/**
		 * 调整垂直方向的拖动条 
		 * @param dis
		 * @return 
		 * 
		 */
		public function tryMoveRight(dis:Number):Boolean
		{
//			trace("tryMoveRight:",this,getDragBarInfo());
			if(this.walked) return false;
			this.walked=true;
			var i:int, len:int;
			len = _updaters.length;
		
			var tR:RelativePos;
			var dragBarList:Array;
			dragBarList=[];
			var tDragBar:LayoutDragBar;
			for (i = len - 1; i >= 0; i--)
			{
				tR=_updaters[i];
				if(tR.tar is LayoutDragBar)
				{
					tDragBar=tR.tar as LayoutDragBar;
					if(tDragBar.cusorType==CursorManager.HResize&&RelativePos.getTypeByFun(tR._fun)==RelativePos.Up)
					{
						dragBarList.push(tDragBar);
					}
				}			
			}
			if(dragBarList.length<2)
			{
				return false;
			}
			dragBarList.sort(sortByXFun);
			
			var tWidth:Number;
			tWidth=0;
			var maxWidth:Number;
			maxWidth=0;
			var tSelecteDragBar:LayoutDragBar;
			len=dragBarList.length;
			for(i=1;i<len;i++)
			{
				tWidth=dragBarList[i].x-dragBarList[i-1].x;
				if(tWidth>maxWidth)
				{
					maxWidth=tWidth;
					tSelecteDragBar=dragBarList[i];
				}
			}
			if(tSelecteDragBar)
			{
				tSelecteDragBar.moveRightWork(dis);
			}
			
			return true;
		}
		/**
		 * 调整水平方向的拖动条 
		 * @param dis
		 * 
		 */
		public function moveRightWork(dis:Number):void
		{
//			trace("moveRightWork:",this,getDragBarInfo());
			if(this.walked) return;
			this.walked=true;
			
			
			var i:int, len:int;
			len = _updaters.length;
			
			var tR:RelativePos;
			var dragBarList:Array;
			dragBarList=[];
			var tDragBar:LayoutDragBar;
			for (i = len - 1; i >= 0; i--)
			{
				tR=_updaters[i];
				if(tR.tar is LayoutDragBar)
				{
					tDragBar=tR.tar as LayoutDragBar;
					if(tDragBar.cusorType==CursorManager.VResize&&RelativePos.getTypeByFun(tR._fun)==RelativePos.Right)
					{
//						if(!tDragBar.walked)
						dragBarList.push(tDragBar);
					}
				}			
			}
			

			var tSelecteDragBar:LayoutDragBar;
			dragBarList.sort(sortByYFun);
			len=dragBarList.length;
			for(i=0;i<len;i++)
			{

				tSelecteDragBar=dragBarList[i];
				tSelecteDragBar.tryMoveRight(dis);
			}

			this.left+=dis;
			
		}
		
		
		private var sortByYFun:Function=MathUtil.sortByKey("y",false,true);
		/**
		 * 调整垂直方向的拖动条 
		 * @param dis
		 * @return 
		 * 
		 */
		public function tryMoveDown(dis:Number):Boolean
		{
			//			trace("tryMoveRight:",this,getDragBarInfo());
			var i:int, len:int;
			len = _updaters.length;
			
			var tR:RelativePos;
			var dragBarList:Array;
			dragBarList=[];
			var tDragBar:LayoutDragBar;
			for (i = len - 1; i >= 0; i--)
			{
				tR=_updaters[i];
				if(tR.tar is LayoutDragBar)
				{
					tDragBar=tR.tar as LayoutDragBar;
					if(tDragBar.cusorType==CursorManager.VResize)
					{
						dragBarList.push(tDragBar);
					}
				}			
			}
			if(dragBarList.length<2)
			{
				return false;
			}
			dragBarList.sort(sortByYFun);
			
			var tWidth:Number;
			tWidth=0;
			var maxWidth:Number;
			maxWidth=0;
			var tSelecteDragBar:LayoutDragBar;
			len=dragBarList.length;
			for(i=1;i<len;i++)
			{
				tWidth=dragBarList[i].y-dragBarList[i-1].y;
				if(tWidth>maxWidth)
				{
					maxWidth=tWidth;
					tSelecteDragBar=dragBarList[i];
				}
			}
			if(tSelecteDragBar)
			{
				tSelecteDragBar.moveDownWork(dis);
			}
			
			return true;
		}
		/**
		 * 调整水平方向的拖动条 
		 * @param dis
		 * 
		 */
		public function moveDownWork(dis:Number):void
		{
			//			trace("moveRightWork:",this,getDragBarInfo());
			if(this.walked) return;
			this.walked=true;
			
			
			var i:int, len:int;
			len = _updaters.length;
			
			var tR:RelativePos;
			var dragBarList:Array;
			dragBarList=[];
			var tDragBar:LayoutDragBar;
			for (i = len - 1; i >= 0; i--)
			{
				tR=_updaters[i];
				if(tR.tar is LayoutDragBar)
				{
					tDragBar=tR.tar as LayoutDragBar;
					if(tDragBar.cusorType==CursorManager.HResize&&RelativePos.getTypeByFun(tR._fun)==RelativePos.Down)
					{
						if(!tDragBar.walked)
							dragBarList.push(tDragBar);
					}
				}			
			}
			
			
			var tSelecteDragBar:LayoutDragBar;
			dragBarList.sort(sortByXFun);
			len=dragBarList.length;
			for(i=0;i<len;i++)
			{
				
				tSelecteDragBar=dragBarList[i];
				tSelecteDragBar.tryMoveDown(dis);
			}
			
			this.top+=dis;
			
		}
	
	}

}