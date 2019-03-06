package commontools 
{
	import laya.events.Event;
	import laya.events.EventDispatcher;
	import laya.ui.List;
	/**
	 * ...
	 * @author ww
	 */
	public class ListDragTrigger extends EventDispatcher
	{
		public static const DragDown:String = "DragDown";
		public static const DragUp:String = "DragUp";
		public var isOn:Boolean = false;
		public function ListDragTrigger() 
		{
			
		}
		
		public var list:List;
		public var triggerLen:int = 250;
		public function setUp(list:List):void
		{
			this.list = list;
			list.scrollBar.on(Event.CHANGE, this, onListScrollBarChange);
			list.scrollBar.on(Event.START, this, onListScrollBarDragStart);
			list.scrollBar.on(Event.END, this, onListScrollBarDragEnd);
		}
		
		private var _isDragDown:Boolean = false;
		private var _isDragUp:Boolean = false;
		private function onListScrollBarDragStart():void
		{
			if (!isOn) return;
			_isDragDown = false;
			_isDragUp = false;
		}
		
		private function onListScrollBarChange():void
		{
			if (!isOn) return;
			//trace(list.scrollBar.value);
			if (list.scrollBar.value < -triggerLen)
			{
				_isDragDown = true;
				//trace("onListScrollBarChange:",list.scrollBar.value);
			}else
			{
				if (list.scrollBar.value > list.scrollBar.max + triggerLen)
				{
					_isDragUp = true;
				}
			}
		}
		
		private function onListScrollBarDragEnd():void
		{
			if (!isOn) return;
			//trace("onListScrollBarDragEnd");
			if (_isDragDown)
			{
				sendEventsLater(DragDown);
				//refreshPages();
			}else
			{
				if (_isDragUp)
				{
					sendEventsLater(DragUp);
				}
			}
			_isDragUp = false;
			_isDragDown = false;
		}
		
	
		
		private function sendEventsLater(type:String):void
		{
			if (!isOn) return;
			Laya.timer.callLater(this, event, [type]);
		}
		
	}

}