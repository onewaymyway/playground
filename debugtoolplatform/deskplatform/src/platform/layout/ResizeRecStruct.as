///////////////////////////////////////////////////////////
//  ResizeRecStruct.as
//  Macromedia ActionScript Implementation of the Class ResizeRecStruct
//  Created on:      2016-6-27 上午10:10:36
//  Original author: ww
///////////////////////////////////////////////////////////

package platform.layout
{
	import extendui.layout.RelativePos;
	import laya.editor.comonents.LayoutDragBar;
	import laya.editor.view.LayoutRec;
	import laya.maths.MathUtil;
	import platform.managers.CursorManager;
	
	/**
	 * 调整布局的功能
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2016-6-27 上午10:10:36
	 */
	public class ResizeRecStruct
	{
		public function ResizeRecStruct()
		{
		}
		
		public var upSide:LayoutDragBar;
		public var downSide:LayoutDragBar;
		public var leftSide:LayoutDragBar;
		public var rightSide:LayoutDragBar;
		public var isRoot:Boolean=false;
		public var resizeItems:Array;
		public function reset():void
		{
			upSide=null;
			downSide=null;
			leftSide=null;
			rightSide=null;
		}
		public function setBars(left:LayoutDragBar,right:LayoutDragBar,up:LayoutDragBar,down:LayoutDragBar):void
		{
			upSide=up;
			downSide=down;
			leftSide=left;
			rightSide=right;
		}
		public function isSame(left:LayoutDragBar,right:LayoutDragBar,up:LayoutDragBar,down:LayoutDragBar):Boolean
		{
			return upSide==up&&downSide==down&&leftSide==left&&rightSide==right;
		}
		public function isSameStruct(st:ResizeRecStruct):Boolean
		{
			return upSide==st.upSide&&downSide==st.downSide&&leftSide==st.leftSide&&rightSide==st.rightSide;
		}
		
		public function traceMyInfo():void
		{
			trace("up:",upSide.getDragBarInfo(RelativePos.Up));
			
			trace("down:",downSide.getDragBarInfo(RelativePos.Down));
			
			trace("left:",leftSide.getDragBarInfo(RelativePos.Left));
			
			trace("right:",rightSide.getDragBarInfo(RelativePos.Right));
			
			
		}
		private var sortByXFun:Function=MathUtil.sortByKey("x",false,true);
		public var mDis:Number;
		/**
		 * 调整垂直方向的拖动条 
		 * @param dis
		 * @return 
		 * 
		 */
		public function tryMoveRight(dis:Number):Boolean
		{

//			trace("tryMoveRight");
//			traceMyInfo();
			
			mDis=dis;
			var i:int, len:int;
			var _updaters:Array;
			_updaters=upSide._updaters;
			
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
						if(downSide.findTarType(tDragBar)!=null)
						{
							if(tDragBar.x>=leftSide.x&&tDragBar.x<=rightSide.x)
							dragBarList.push(tDragBar);
						}				
					}
				}			
			}
			
			dragBarList.sort(sortByXFun);
			if(dragBarList[0]!=leftSide)
			{
				dragBarList.unshift(leftSide);
			}
			if(dragBarList[dragBarList.length-1]!=rightSide)
			{
				dragBarList.push(rightSide);
			}
//			trace("barLength:",dragBarList.length);
			if(dragBarList.length<2)
			{
				return false;
			}
			
			
			var tWidth:Number;
			tWidth=0;
			var maxWidth:Number;
			maxWidth=0;
			var tSelecteDragBar:LayoutDragBar;
			len=dragBarList.length;
//			trace("widths:");
			for(i=1;i<len;i++)
			{
				tWidth=dragBarList[i].x-dragBarList[i-1].x;
//				trace(tWidth);
				if(tWidth>maxWidth)
				{
					maxWidth=tWidth;
					tSelecteDragBar=dragBarList[i];
				}
				if(tWidth+dis>150&&LayoutDragBar.hasFreeTar((dragBarList[i] as LayoutDragBar).getTarsByType(RelativePos.Right)))
				{
					tSelecteDragBar=dragBarList[i];
					break;
				}
			}
			if(tSelecteDragBar)
			{
				moveRightWork(tSelecteDragBar,dragBarList,dis)
			}else
			{
				debugger;
			}
			
			return true;
		}
		/**
		 * 调整水平方向的拖动条 
		 * @param dis
		 * 
		 */
		public function moveRightWork(selectBar:LayoutDragBar,barList:Array,dis:Number):void
		{
			//			trace("moveRightWork:",this,getDragBarInfo());
//			if(this.walked) return;
//			this.walked=true;
			
			
			var i:int, len:int;

			var rightIndex:int;
			rightIndex=barList.indexOf(selectBar);
//			trace("moveRightWork:",rightIndex,barList.length);
			var tLeftBar:LayoutDragBar;
			var tRightBar:LayoutDragBar;
			if(rightIndex>=1)
			{
				tLeftBar=barList[rightIndex-1];
				tRightBar=barList[rightIndex];
				if(tLeftBar==leftSide&&tRightBar==rightSide)
				{
					
				}else
				{
					
				}
				resizeSmallRec(tLeftBar,tRightBar);
			}
			
			
			len=barList.length;
//			trace("final resize");
			
			
			if(isRoot)
			{
				len=resizeItems.length;
				for(i=0;i<len;i++)
				{
					if(!resizeItems[i].walked)
					{
						resizeItems[i].left+=dis;
						resizeItems[i].walked=true;
						
					}
				}
			}else
			{
				for(i=rightIndex;i<len;i++)
				{
					
					resizeItems.push(barList[i]);
				}
			}
			
			
		}
		public function resizeSmallRec(tLeftBar:LayoutDragBar,tRightBar:LayoutDragBar):void
		{
			var i:int, len:int;
			var _updaters:Array;
			_updaters=tRightBar._updaters;
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
						if(leftSide.findTarType(tDragBar)!=null)
						{
							if(tDragBar.y>=upSide.y&&tDragBar.y<=downSide.y)
							dragBarList.push(tDragBar);
						}			
					}
				}			
			}
			var tSelecteDragBar:LayoutDragBar;
			dragBarList.sort(sortByYFun);
			if(dragBarList[0]!=upSide)
			{
				dragBarList.unshift(upSide);
			}
			if(dragBarList[dragBarList.length-1]!=downSide)
			{
				dragBarList.push(downSide);
			}
			len=dragBarList.length;
			var resizeRec:ResizeRecStruct;
//			if(len<=2)
//			{
//				trace("noSmallRec");
//				return;
//			}
//			trace("resizeSmall:___________");
			for(i=1;i<len;i++)
			{
//				trace("resizeSmall:___________"+"id:",i);
				resizeRec=new ResizeRecStruct();
				resizeRec.resizeItems=this.resizeItems;
				resizeRec.setBars(tLeftBar,tRightBar,dragBarList[i-1],dragBarList[i]);
				if(isSameStruct(resizeRec))
				{
				}else
				{
					resizeRec.tryMoveRight(mDis);
				}
				
			}
//			trace("resizeSmallEnd:___________");
		}
		
		private var sortByYFun:Function=MathUtil.sortByKey("y",false,true);
	}
}