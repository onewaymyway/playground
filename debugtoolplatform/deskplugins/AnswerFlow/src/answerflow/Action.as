package answerflow 
{
	import commonlayout.mindmaptree.MindMapViewer;
	import ui.answerflow.ActionUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class Action extends ActionUI 
	{
		private var viewer:MindMapViewer;
		public function Action() 
		{
			this.removeChildren();
			viewer = new MindMapViewer();
			addChild(viewer);
		}
		
		override protected function renderByData():void 
		{
			super.renderByData();
		}
	}

}