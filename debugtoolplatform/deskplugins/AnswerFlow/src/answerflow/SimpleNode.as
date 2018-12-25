package answerflow 
{
	import ui.answerflow.SimpleNodeUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class SimpleNode extends SimpleNodeUI 
	{
		
		public function SimpleNode() 
		{
			//this.graphics.drawRect(0, 0, 100, 100, "#ff0000");
		}
		
		override protected function renderByData():void 
		{
			super.renderByData();
			txt.text = _dataO.props.label;
		}
		
	}

}