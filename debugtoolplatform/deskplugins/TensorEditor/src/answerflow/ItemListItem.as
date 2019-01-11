package answerflow 
{
	import laya.events.Event;
	import laya.ui.TextInput;
	import laya.utils.Handler;
	import ui.answerflow.ItemListItemUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ItemListItem extends ItemListItemUI 
	{
		
		public function ItemListItem() 
		{
			setUpTextInput(label, "label");
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