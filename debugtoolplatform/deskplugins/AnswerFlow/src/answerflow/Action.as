package answerflow 
{
	import commonlayout.mindmaptree.MindMapViewer;
	import laya.events.Event;
	import laya.utils.Pool;
	import platform.tools.Notice;
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
			var clzList:Array;
			clzList = [ActionRoot, AddAbleNode, DataOperate, SimpleNode, ItemData];
			viewer.regItemClassList(clzList);
			addChild(viewer);
			viewer.centerY = 0;
			viewer.x = 100;
			this.on(Event.DISPLAY, this, onDisplayChange);
			this.on(Event.UNDISPLAY, this, onDisplayChange);
		}
		
		private function onDisplayChange():void
		{
			Notice.cancel(AnswerFlowEvents.DataChanged, this, freshUI);
			if (this.displayedInStage)
			{
				Notice.listen(AnswerFlowEvents.DataChanged, this, freshUI);
			}else
			{
				
			}
		}
		private var _dataO:Object;
		public function freshUI():void
		{
			viewer.setData(_dataO);
		}
		public function setData(dataO:Object):void
		{
			_dataO = dataO;
			freshUI();
		}
	}

}