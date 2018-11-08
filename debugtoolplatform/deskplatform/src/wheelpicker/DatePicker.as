package wheelpicker 
{
	import laya.events.Event;
	import laya.ui.Box;
	
	/**
	 * ...
	 * @author ww
	 */
	public class DatePicker extends Box 
	{
		
		public function DatePicker() 
		{
			
		}
		
		private var _inited:Boolean = false;
		private var _year:WheelPicker;
		private var _month:WheelPicker;
		private var _day:WheelPicker;
		public var space:int = 5;
		public var itemSpace:int = 3;
		public var labelColor:String = "#ff0000";
		public var labelFontSize:int = 24;
		public var maskLineColor:String = null;
		
		private function createAPicker():WheelPicker
		{
			var rst:WheelPicker;
			rst = new WheelPicker();
			rst.size(pickerWidth, this.height);
			rst.labelColor = labelColor;
			rst.labelFontSize = labelFontSize;
			rst.maskColor = maskColor;
			rst.itemSpace = itemSpace;
			rst.maskLineColor = maskLineColor;
			return rst;
		}
		
		private function get pickerWidth():Number
		{
			return Math.round( (this.width - 2 * space) / 3);
		}
		public static const startYear:int = 1900;
		public var maskColor:String = "#000000";
		public function initUI():void
		{
			if (_inited) return;
			
			var pickerWidth:Number;
			pickerWidth =this.pickerWidth;
			_year = createAPicker();
			
			_year.setItems(createNumArr(startYear, 2018,"年"));
			_year.on(Event.CHANGE, this, onYearChange);
			
			addChild(_year);
			
			_month = createAPicker();
			_month.setItems(createNumArr(1, 12,"月"));
			_month.on(Event.CHANGE, this, onMonthChange);
			_month.x = pickerWidth + space;
			addChild(_month);
			
			_day = createAPicker();
			_day.setItems(createNumArr(1, 31,"日"));
			_day.x = (pickerWidth + space)*2;
			addChild(_day);
		}
		
		public function getShowRecTop():Number
		{
			return _year.getShowRecTop()+_year.y;
		}
		
		public function getShowRecBottom():Number
		{
			return _year.getShowRecBottom()+_year.y;
		}
		
		private function onYearChange():void
		{
			updateDayItems();
		}
		
		private function onMonthChange():void
		{
			updateDayItems();
		}
		
		public function get year():int
		{
			return _year.selectIndex+startYear;
		}
		
		public function set year(value:int):void
		{
			_year.selectIndex = value-startYear;
		}
		
		
		
		public function get month():int
		{
			return _month.selectIndex + 1;
		}
		
		public function set month(value:int):void
		{
			_month.selectIndex = value-1;
		}
		
		public function get day():int
		{
			return _day.selectIndex + 1;
		}
		
		public function set day(value:int):void
		{
			_day.selectIndex = value-1;
		}
		
		public static function getDateNums(dateStr:String):Array
		{
			var nums:Array;
			nums = dateStr.split("-");
			var i:int, len:int;
			len = nums.length;
			for (i = 0; i < len; i++)
			{
				nums[i] = parseInt(nums[i]);
			}
			return nums;
		}
		public static function isDateStrOK(str:String):Boolean
		{
			if (str == "") return false;
			var nums:Array;
			nums = str.split("-");
			if (nums.length != 3) return false;
			var date:*;
			date = new Date(str);
			if (date.toString() == "Invalid Date")
			{
				return false;
			}
			if (getStrFromDate(date) != str) return false;
			var now:*;
			now = new Date();
			var dTime:Number;
			dTime = now.getTime() - date.getTime();
			if (dTime < 0) return false;
			return true;
			
		}
		
		private static function getOkWidthStr(num:int):String
		{
			if (num < 10) return "0" + num;
			return num + "";
		}
		
		public static function getDateStr(year:int, month:int, day:int):String
		{
			return year + "-" + getOkWidthStr(month) + "-" + getOkWidthStr(day);
		}
		public static function isDateOK(year:int, month:int, day:int):Boolean
		{
			return isDateStrOK(year + "-" + getOkWidthStr(month) + "-" + getOkWidthStr(day));
		}
		public static function getStrFromDate(date:Date):String
		{
			return getDateStr(date.getFullYear() , date.getMonth() + 1 , date.getDate());
		}
		public static const MonthDayDic:Object = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		private static function isLeapYear(year:int):Boolean 
		{  
			return (year % 4 == 0) && (year % 100 != 0 || year % 400 == 0);  
		}
		private function getCurDayCount():int
		{
			if (month == 2)
			{
				if (isLeapYear(year))
				{
					return 29;
				}
				return 28;
			}
			return MonthDayDic[month-1];
		}
		private function updateDayItems():void
		{
			var preCount:int;
			preCount = _day.itemCount;
			var curCount:int;
			curCount = getCurDayCount();
			if (preCount == curCount) return;
			var preDay:int;
			preDay = day;
			_day.setItems(createNumArr(1, curCount,"日"));
			if (preDay > _day.itemCount) preDay = _day.itemCount;
			_day.selectIndex = (preDay - 1);
		}
		
		private function createNumArr(start:int, end:int,sign:String=""):Array
		{
			var rst:Array;
			rst = [];
			var i:int;
			var tObject:Object;
			for (i = start; i <= end; i++)
			{
				tObject = { };
				tObject.label = i + ""+sign;
				rst.push(tObject);
			}
			return rst;
		}
		
		public function set dateStr(value:String):void
		{
			if (!isDateStrOK(value))
			{
				value = "1980-01-01";
			}
			var nums:Array;
			nums = getDateNums(value);
			year = nums[0];
			month = nums[1];
			updateDayItems();
			day = nums[2];
		}
		
		public function get dateStr():String
		{
			return getDateStr(year, month, day);
		}
	}

}