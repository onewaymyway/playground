package answerflow 
{
	import laya.events.Event;
	import laya.ui.Label;
	import laya.utils.Handler;
	import ui.answerflow.AnswerFlowEditorUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class AnswerFlowEditor extends AnswerFlowEditorUI 
	{
		public var dataO:Object;
		public function AnswerFlowEditor() 
		{
			actionList.renderHandler = new Handler(this, itemRender);
			actionList.on(Event.DOUBLE_CLICK, this, onDoubleClick);
		}
		
		private function itemRender(cell:*, index:int):void
		{
			var label:Label;
			label = cell.getChildByName("label");
			var dataO:Object;
			dataO = cell.dataSource;
			label.text = dataO.label;
		}
		
		private function onDoubleClick():void
		{
			if (actionList.selectedItem)
			{
				debugger;
			}
		}
		
		private function createAddActionData():Object
		{
			var rst:Object;
			rst = {};
			rst.type = "addnew";
			rst.label = "addNew";
			return rst;
		}
		public function setData(dataO:Object):void
		{
			this.dataO = dataO;
			if (!dataO.actions)
			{
				dataO.actions = [createAddActionData()];
			}
			actionList.array = dataO.actions;
		}
	}

}