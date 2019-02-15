package answerflow 
{
	import laya.events.Event;
	import ui.answerflow.PropDataUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class PropData extends PropDataUI 
	{
		
		public function PropData() 
		{
			setUpTextInput(keyInput, "key");
			setUpTextInput(valueInput, "value");
			removeBtn.on(Event.CLICK, this, removeFromParent);
		}
		
		override protected function renderByData():void 
		{
			super.renderByData();
			keyInput.text = _dataO.props["key"] || "";
			valueInput.text = _dataO.props["value"] || "";
		}
		
	}

}