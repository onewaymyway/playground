package commontools 
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.events.EventDispatcher;
	import laya.utils.Handler;
	/**
	 * ...
	 * @author ww
	 */
	public class SwitchGroup extends EventDispatcher
	{
		public var btnList:Array;
		public var signList:Array;
		
		public var selectTip:Sprite;
		public var textControl:TextTabControl;
		
		public function setItem(btnList:Array, signList:Array):void
		{
			this.btnList = btnList;
			this.signList = signList;
			var i:int, len:int;
			len = btnList.length;
			for (i = 0; i < len; i++)
			{
				btnList[i].on(Event.CLICK, this, onTabClick, [i]);
			}
			setSelect(0);
		}
		
		public function get selectBtn():*
		{
			return btnList[_index];
		}
		
		public function setItemEx(btnList:Array):void
		{
			var selects:Array;
			selects = [];
			var i:int, len:int;
			len = btnList.length;
			var tArr:Array;
			var tBtn:Sprite;
			for (i = 0; i < len; i++)
			{
				tBtn = btnList[i];
				tArr = [tBtn.getChildByName("state0"), tBtn.getChildByName("state1")];
				selects.push(tArr);
			}
			setItem(btnList, selects);
			
		}
		
		public function setKeySwitchItem(btnList:Array, keyDesList:Array,key:String="skin",values:Array=null):void
		{
			if (!values) values = ["0.png", "1.png"];
			var i:int, len:int;
			var desList:Array;
			desList = [];
			len = keyDesList.length;
			var tParam:Array;
			for (i = 0; i < len; i++)
			{
				tParam = keyDesList[i];
				desList.push(createSignObjectEx(tParam[0],key,tParam[1],values));
			}
			setItem(btnList, desList);
		}
		
		public var clickHandler:Handler;
		private function onTabClick(index:int):void
		{
			
			if (index == _index) return;
			var preIndex:int;
			preIndex = _index;
			setSelect(index);
			
			if (clickHandler)
			{
				clickHandler.runWith([index,preIndex]);
			}
		}
		
		
		
		public var _index:int=-1;
		public function get index():int
		{
			return _index;
		}
		
		public function get selectedIndex():int
		{
			return _index;
		}
		
		public function set selectedIndex(value:int):void
		{
			setSelect(value);
		}
		public static function createSignObject(tar:*, key:String, values:Array):Object
		{
			var rst:Object;
			rst = { };
			rst.tar = tar;
			rst.key = key;
			rst.values = values;
			rst.selectType = "switcher";
			return rst;
		}
		
		public static function createSignObjectEx(tar:*, key:String,preKey:String, values:Array):Object
		{
			var rst:Object;
			rst = { };
			rst.tar = tar;
			rst.key = key;
			var i:int, len:int;
			len = values.length;
			var valuseNew:Array;
			valuseNew = [];
			for (i = 0; i < len; i++)
			{
				valuseNew[i] = preKey + values[i];
			}
			rst.values = valuseNew;
			rst.selectType = "switcher";
			return rst;
		}
		public function setSelect(index:int):void
		{
			_index = index;
			var i:int, len:int;
			len = signList.length;
			var curVisible:Boolean;
			var tConfigO:Object;
			var tarO:String;
			var tarKey:String;
			for (i = 0; i < len; i++)
			{
				curVisible = index == i;
				if (signList[i] is Array)
				{
					signList[i][0].visible = !curVisible;
					signList[i][1].visible = curVisible;
				}else
				if (signList[i].selectType)
				{
					tConfigO = signList[i];
					tarO = tConfigO.tar;
					tarO[tConfigO.key] = tConfigO.values[curVisible?1:0];
				}else
				{
					signList[i].visible = curVisible;
				}
				
			}
			
			if (selectTip && selectBtn)
			{
				var tBtn:Sprite;
				tBtn = selectBtn;
				selectTip.x = tBtn.x + Math.round((tBtn.width - selectTip.width)*0.5);
			}
			if (textControl)
			{
				textControl.selectIndex = index;
			}
			
			event(Event.CHANGE);
			
		}
	}

}