///////////////////////////////////////////////////////////
//  TabEx2.as
//  Macromedia ActionScript Implementation of the Class TabEx2
//  Created on:      2018-4-10 下午2:28:19
//  Original author: ww
///////////////////////////////////////////////////////////

package extendui.ui
{
	import laya.display.Sprite;
	import laya.ui.Button;
	import laya.ui.Tab;
	
	/**
	 * 
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2018-4-10 下午2:28:19
	 */
	public class TabEx2 extends Tab
	{
		public function TabEx2()
		{
		}
		private var _buttonSizeGrid:String;
		public function set buttonSizeGrid(value:String):void
		{
			_buttonSizeGrid=value;
			if(_items)
			{
				var i:int,len:int;
				len=_items.length;
				for(i=0;i<len;i++)
				{
					(_items[i] as Button).sizeGrid=_buttonSizeGrid;
				}
			}
		}
		override protected function createItem(skin:String, label:String):Sprite
		{
			// TODO Auto Generated method stub
			var rst:Button;
			rst=super.createItem(skin, label) as Button;
			if(_buttonWidth>0) rst.width=_buttonWidth;
			if(_buttonHeight>0) rst.height=_buttonHeight;
			if(_buttonSizeGrid) rst.sizeGrid=_buttonSizeGrid;
			return rst;
		}
		private var _buttonWidth:int=0;
		public function set buttonWidth(value:int):void
		{
			value=Math.floor(value);
			_buttonWidth=value;
			if(_buttonWidth<=0) return;
			if(_items)
			{
				var i:int,len:int;
				len=_items.length;
				for(i=0;i<len;i++)
				{
					(_items[i] as Sprite).width=_buttonWidth;
				}
			}
		}
		
		private var _buttonHeight:int=0;
		
		public function set buttonHeight(value:int):void
		{
			value=Math.floor(value);
			_buttonHeight=value;
			if(_buttonHeight<=0) return;
			if(_items)
			{
				var i:int,len:int;
				len=_items.length;
				for(i=0;i<len;i++)
				{
					(_items[i] as Sprite).height=_buttonHeight;
				}
			}
		}
	}
}