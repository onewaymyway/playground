///////////////////////////////////////////////////////////
//  InputSelect.as
//  Macromedia ActionScript Implementation of the Class InputSelect
//  Created on:      2016-11-25 下午3:24:13
//  Original author: ww
///////////////////////////////////////////////////////////

package commoncomponent
{
	import laya.display.Text;
	import laya.events.Event;
	import laya.ui.ComboBox;
	
	/**
	 * 带下拉框的输入框
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2016-11-25 下午3:24:13
	 */
	public class InputSelect extends ComboBox
	{
		private var _input:CommonInput;
		public function InputSelect()
		{
		}
		/**@inheritDoc */
		override protected function createChildren():void {
			super.createChildren();
			_input=new CommonInput();
//			_input.top=_input.bottom=2;
			_input.left=0;
			_input.right=20;
			_input.height = 24;
//			_input.padding = "0,0,0,5";
//			_input.sizeGrid = "0,4,0,4";
//			_input.overflow=Text.HIDDEN;
			_button["_text"].visible=false;
			addChild(_input);
			_input.on(Event.BLUR, this, onInputEvents, [Event.BLUR]);
			this.on(Event.CHANGE, this, onInputEvents, [Event.BLUR]);
		}
		
		private function onInputEvents(event:String):void
		{
			this.event(event);
		}
		public function get input():CommonInput
		{
			return _input;
		}
		
		public function set text(value:String):void
		{
			_input.text=value;
		}
		
		public function get text():String
		{
			return _input.text;
		}
		
		public function set color(value:String):void
		{
			_input.color = color;
		}
		
		override public function set selectedIndex(value:int):void {
			if (_selectedIndex != value) {
				_selectedIndex = value;
				
				if (_labels.length > 0) mchangeSelected();
				else callLater(mchangeSelected);
				
				event(Event.CHANGE, [Event.EMPTY.setTo(Event.CHANGE, this, this)]);
				_selectHandler && _selectHandler.runWith(_selectedIndex);
			}
		}
		private function mchangeSelected():void {
			_button.label = selectedLabel;
			_input.text=selectedLabel;
		}
		override public function set selectedLabel(value:String):void
		{
			// TODO Auto Generated method stub
			super.selectedLabel = value;
			_input.text = value;
			
//			trace("set input:",value);
		}
		
		override public function get labels():String 
		{
			return super.labels;
		}
		
		override public function set labels(value:String):void 
		{
			//if (_labels.length > 0) selectedIndex = -1;
			if (value) _labels = value.split(",");
			else _labels.length = 0;
			_itemChanged = true;
		}
//		
//		override public function get selectedLabel():String
//		{
//			return _input.text;
//		}
		
		
	}
}