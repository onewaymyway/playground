package answerflow 
{
	import laya.debug.tools.ObjectTools;
	import laya.events.Event;
	import platform.tools.Notice;
	import ui.answerflow.AddAbleNodeUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class AddAbleNode extends AddAbleNodeUI 
	{
		
		public function AddAbleNode() 
		{
			addBtn.on(Event.CLICK, this, onAddBtn);
			setUpTextInput(txt, "label");
		}
		
		override protected function renderByData():void 
		{
			super.renderByData();
			txt.text = _dataO.props.label;
			txt.editable = _dataO.props.editable == true;
		}
		
		private function onAddBtn():void
		{
			if (!_dataO.props.tpl) return;
			
			_dataO.childs.push(ObjectTools.copyObjFast(_dataO.props.tpl));
			Notice.notify(AnswerFlowEvents.DataChanged);
		}
	}

}