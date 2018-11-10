package extendui
{
	import extendui.focus.FocusItem;
	import extendui.layout.RelativePos;
	import laya.debug.tools.DisPool;
	import laya.display.Sprite;
	import laya.filters.ColorFilter;
	import laya.maths.Rectangle;
	
	/**
	 * 用于在对象上显示焦点框的工具类
	 * @author ww
	 */
	public class FocusManager
	{
		
		public function FocusManager()
		{
		
		}
		public static const focusWidth:int = 5;
		public static var useGetBounds:Boolean=false;
		/**
		 * 现实对象的边缘焦点 
		 * @param tar
		 * @param width
		 * @param clearPre
		 * 
		 */
		public static function showFocus(tar:Sprite,width:int=focusWidth,clearPre:Boolean=true):void
		{
//			trace("showFocus");
			var bounds:Rectangle;
			
			//bounds = tar.getSelfBounds();
			bounds=getTarBounds(tar);
			showBorder(tar, RelativePos.Up, clearPre, bounds,width);
			showBorder(tar, RelativePos.Down, false, bounds,width);
			showBorder(tar, RelativePos.Left, false, bounds,width);
			showBorder(tar, RelativePos.Right, false, bounds,width);
		}
		public static function getTarBounds(tar:Sprite):Rectangle
		{
			if(useGetBounds)
			{
				return  tar.getSelfBounds();
			}else
			{
				return new Rectangle().setTo(0,0,tar.width,tar.height);
			}
		}
		private static var _focusList:Array = [];
		
		/**
		 * 现实对象某一边缘的焦点 
		 * @param tar
		 * @param type
		 * @param clearPre
		 * @param rec
		 * @param width
		 * 
		 */
		public static function showBorder(tar:Sprite, type:String, clearPre:Boolean=true,rec:Rectangle=null,width:int=focusWidth):void
		{
			if (clearPre == true)
			{
				clearFocus();
			}
			var bounds:Rectangle;
			bounds = rec?rec:getTarBounds(tar);
			var tFocus:FocusItem;
			//tFocus = new FocusItem();
			tFocus = DisPool.getDis(FocusItem);
			switch (type)
			{
				case RelativePos.Left:
					tFocus.width = width;
					tFocus.height = bounds.height;
					tFocus.x = bounds.x;
					tFocus.y = bounds.y;
					break;
				case RelativePos.Right:
					tFocus.width = width;
					tFocus.height = bounds.height;
					tFocus.x = bounds.x+bounds.width-width;
					tFocus.y = bounds.y;
					break;
				case RelativePos.Up:
					tFocus.width = bounds.width;
					tFocus.height =width;
					tFocus.x = bounds.x;
					tFocus.y = bounds.y;
					break;
				case RelativePos.Down:
					tFocus.width = bounds.width;
					tFocus.height =width;
					tFocus.x = bounds.x;
					tFocus.y = bounds.y+bounds.height-width;
					break;
			}
			showFocusToTar(tar,tFocus);
		}
		
		/**
		 * 将焦点对象显示到对象上 
		 * @param tar
		 * @param focus
		 * 
		 */
		public static function showFocusToTar(tar:Sprite, focus:Sprite):void
		{
			_focusList.push(focus);
			tar.addChild(focus);
		}
		
		/**
		 * 清楚焦点 
		 * @param tar
		 * 
		 */
		public static function clearFocus(tar:Sprite = null):void
		{
			var i:int, len:int;
			len = _focusList.length;
			
			if (tar)
			{
				for (i = len-1; i >= 0; i--)
				{
					if (_focusList[i].parent == tar)
					{
						(_focusList[i] as Sprite).removeSelf();
						_focusList.splice(i, 1);
					}
					
				}
			}
			else
			{
				for (i = 0; i < len; i++)
				{
					(_focusList[i] as Sprite).removeSelf();
				}
				_focusList.length = 0;
			}
		
		}
		
		
		private static var _focusFilter:ColorFilter;
		public static function flashItem(item:Sprite,count:int=3,loopTime:int=200):void
		{
			if(!_focusFilter)
			{
				var mat:Array;
				mat=[1,0,0,0,100,
					0,1,0,0,100,
					0,0,1,0,100,
					0,0,0,1,200
				];
				_focusFilter=new ColorFilter(mat);
			}
			Laya.timer.once(loopTime,null,_flashItem,[item,count,loopTime],false);
		}
		
		private static function _flashItem(item:Sprite,leftCount:int,loopTime:int=200):void
		{
			if(!item.filters)
			{
				item.filters=[_focusFilter];
				Laya.timer.once(loopTime,null,_flashItem,[item,leftCount],false);
			}else
			{
				item.filters=null;
				leftCount--;
				if(leftCount>0)
				Laya.timer.once(loopTime,null,_flashItem,[item,leftCount],false);
			}
			
		}
	
	}

}