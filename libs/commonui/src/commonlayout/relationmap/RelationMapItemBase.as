package commonlayout.relationmap 
{
	import commonlayout.ItemDic;
	import commontools.EventTools;
	import laya.debug.tools.ClassTool;
	import laya.events.Event;
	import laya.ui.TextInput;
	import laya.ui.View;
	import laya.utils.ClassUtils;
	import laya.utils.Pool;
	import platform.tools.Notice;
	
	/**
	 * ...
	 * @author ww
	 */
	public class RelationMapItemBase extends View
	{
		public var itemDic:ItemDic;
		protected var _dataO:Object;
		public function RelationMapItemBase() 
		{
			reset();
		}
		
		public function getItemByID(id:int):*
		{
			if (!itemDic) return null;
			return itemDic.getItemByID(id);
		}
		
		protected function setUpTextInput(input:TextInput, key:String):void
		{
			input.on(Event.BLUR, this, onTextInputChange,[input,key]);
		}
		
		private function onTextInputChange(input:TextInput,key:String):void
		{
			if (_dataO.props[key] == input.text) return;
			_dataO.props[key] = input.text;
			//Notice.notify("DataChanged");
			if (input.isAutoSize)
			{
				updateMySize();
			}
			EventTools.sendEventOnTree(this, "DataChanged");
		}
		
		protected function updateMySize():void
		{
			
		}
		public function setLayoutPos(x:Number, y:Number):void
		{
			pos(x, y);
		}
		
		public function recover():void
		{
			reset();
			Pool.recover(ClassTool.getClassName(this),this);
		}
		
		public function get childNodes():Array
		{
			return _childNodes;
		}
		
		public function reset():void
		{
			_dataO = null;
			pos(0, 0);
		}
		
		public function setData(dataO:Object):void
		{
			_dataO = dataO;
			renderByData();
		}
		
		protected function renderByData():void
		{
			
		}
		
		public function getData():Object
		{
			return _dataO;
		}
		
		public function getID():int
		{
			if (!_dataO) return 0;
			return _dataO.id;
		}
	}

}