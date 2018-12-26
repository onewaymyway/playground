package answerflow 
{
	import laya.events.Event;
	import laya.ui.Label;
	import laya.utils.Handler;
	import platform.tools.Notice;
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
			actionList.selectEnable = true;
			actionList.on(Event.DOUBLE_CLICK, this, onDoubleClick);
			Notice.listen(AnswerFlowEvents.DataChanged, this, freshUI);
			saveBtn.on(Event.CLICK, this, onSaveBtn);
		}
		
		private function onSaveBtn():void
		{
			event("save");
		}
		private function itemRender(cell:*, index:int):void
		{
			var label:Label;
			label = cell.getChildByName("label");
			var dataO:Object;
			dataO = cell.dataSource;
			label.text = dataO.label;
			if (dataO.type == "Action")
			{
				label.text = dataO.data.props.label;
			}
		}
		
		private function onDoubleClick():void
		{
			if (actionList.selectedItem)
			{
				var dataO:Object;
				dataO = actionList.selectedItem;
				switch(dataO.type)
				{
					case "addnew":
						addNewAction();
						break;
					case "Action":
						onActionSelect(dataO);
						break;
				}
			}
		}
		
		private function addNewAction():void
		{
			dataO.actions.push(createActionData());
			setData(dataO);
		}
		
		private function onActionSelect(dataO:Object):void
		{
			actionEditor.setData(dataO.data);
		}
		
		
		public static function createActionData():Object
		{
			var rst:Object;
			rst = {};
			rst.type = "Action";
			rst.label = "actionData";
			var actionData:Object;
			actionData = {
				"type":"ActionRoot",
				"props":{"des":"描述信息","label":"操作名"},
				"childs":
					[
						{
							"type":"AddAbleNode",
							"props": {
								"label":"触发方式",
								"tpl": {
									"type":"ItemData",
									"props": { },
									"childs":[]
									}
								},
							"childs":[]
						},
						{
							"type":"SimpleNode",
							"props": {"label":"影响" },
							"childs":[
								{
								"type":"AddAbleNode",
								"props": {
									"label":"增加" ,
									"tpl": {
											"type":"ItemData",
											"props": { },
											"childs":[]
											}
									},
								"childs":[]
								},
								{
								"type":"AddAbleNode",
								"props": {
									"label":"减少",
									"tpl": {
											"type":"ItemData",
											"props": { },
											"childs":[]
											} 
									},
								"childs":[]
								}
							]
						}
					]
				};
			rst.data = actionData;
			return rst;
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
			freshUI();
		}
		
		public function freshUI():void
		{
			if (!dataO.actions)
			{
				dataO.actions = [createAddActionData()];
			}
			actionList.array = dataO.actions;
		}
	}

}