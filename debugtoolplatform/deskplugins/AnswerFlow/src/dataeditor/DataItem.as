package dataeditor 
{
	import answerflow.SimpleJsonEditor;
	import ui.dataeditor.DataItemUI;
	import laya.events.Event;
	import laya.ui.TextInput;
	import laya.utils.Handler;
	
	/**
	 * ...
	 * @author ww
	 */
	public class DataItem extends DataItemUI 
	{
		
		public function DataItem() 
		{
			setUpTextInput(label, "label");
			this.on(Event.RIGHT_MOUSE_DOWN, this, onTextMouseDown);
		}
		
		private function onTextMouseDown():void
		{
			SimpleJsonEditor.I.start(_dataO.props, Handler.create(this, onJsonBack));
		}
		
		private function onJsonBack(dataO:Object):void
		{
			trace("onJsonBack:", dataO);
			_dataO.props = dataO;
		}
		
		public var actionHandler:Handler;
		private var _dataO:Object;
		public function initByData(dataO:Object):void
		{
			_dataO = dataO;
			label.text = dataO.props.label;
		}
		
		protected function setUpTextInput(input:TextInput, key:String):void
		{
			input.on(Event.BLUR, this, onTextInputChange,[input,key]);
		}
		
		private function onTextInputChange(input:TextInput,key:String):void
		{
			if (_dataO.props[key] == input.text) return;
			_dataO.props[key] = input.text;
			//EventTools.sendEventOnTree(this, "DataChanged");
		}
		
	}

}