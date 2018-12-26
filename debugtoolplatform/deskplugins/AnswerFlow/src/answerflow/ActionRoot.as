package answerflow 
{
	import ui.answerflow.ActionRootUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ActionRoot extends ActionRootUI 
	{
		
		public function ActionRoot() 
		{
			setUpTextInput(desTxt,"des");
			setUpTextInput(actionTxt,"label");
		}
		
		override protected function renderByData():void 
		{
			super.renderByData();
			desTxt.text = _dataO.props.des;
			actionTxt.text = _dataO.props.label;
		}
	}

}