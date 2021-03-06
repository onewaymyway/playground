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
		public static const AnswerFlow:String = "ansflow";
		public static const QGame:String = "qgame";
		public var dataO:Object;
		private var itemActionHandler:Handler;
		public function AnswerFlowEditor() 
		{
			actionList.renderHandler = new Handler(this, itemRender);
			actionList.selectEnable = true;
			actionList.on(Event.DOUBLE_CLICK, this, onDoubleClick);
			this.on(AnswerFlowEvents.DataChanged, this, freshUI);
			saveBtn.on(Event.CLICK, this, onSaveBtn);
			addItemBtn.on(Event.CLICK, this, onAddItemBtn);
			addActionBtn.on(Event.CLICK, this, addNewAction);
			
			itemList.renderHandler = new Handler(this, itemListItemRender);
			itemActionHandler = new Handler(this.onItemAction);
		}
		
		
		private function onAddItemBtn():void
		{
			if (!dataO.items)
			{
				dataO.items = [];
			}
			dataO.items.push( { "type":"Item", props: { "label":"new item" }} );
			freshUI();
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
		
		private function itemListItemRender(cell:ItemListItem, index:int):void
		{
			//var label:Label;
			//label = cell.getChildByName("label");
			//var dataO:Object;
			//dataO = cell.dataSource;
			//label.text = dataO;
			cell.actionHandler = itemActionHandler;
			cell.initByData(cell.dataSource);
		}
		
		private function onItemAction(type:String, item:ItemListItem):void
		{
			switch(type)
			{
				
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
			dataO.actions.push(createDefaultActionData());
			setData(dataO);
		}
		
		private function onActionSelect(dataO:Object):void
		{
			actionEditor.setData(dataO.data);
		}
		
		private function createDefaultActionData():Object
		{
			var rst:Object;
			switch(_type)
			{
				case AnswerFlow:
					rst=createActionData();
					break;
				case QGame:
					rst=createQGameActionData();
					break;
			}
			return rst;
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
		public static function createQGameActionData():Object
		{
			var rst:Object;
			rst = {};
			rst.type = "Action";
			rst.label = "actionData";
			var actionData:Object;
			actionData = {
				"type":"ActionRoot",
				"props":{"des":"描述信息","label":"问题"},
				"childs":
					[
						{
							"type":"AddAbleNode",
							"props": {
								"label":"选项",
								"tpl": {
									
									"type":"AddAbleNode",
									"props": {
										"label":"选项内容" ,
										"editable":true,
										"tpl": {
												"type":"ItemData",
												"props": {"count":"-1"},
												"childs":[]
												}
										},
									"childs":[]
									
									}
								},
							"childs":[]
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
		
		private var _type:String;
		public function setEditType(type:String):void
		{
			trace("setEditType:", type);
			_type = type;
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
			
			if (!dataO.items)
			{
				itemList.visible = false;
			}else
			{
				itemList.visible = true;
				itemList.array = dataO.items;
				initItemLabels(dataO.items);
				
			}
			actionTipTxt.text = "操作(" + dataO.actions.length+")";
			if(actionEditor.visible)
			actionEditor.freshLayout();
		}
		
		private function initItemLabels(items:Array):void
		{
			var i:int, len:int;
			len = items.length;
			var tList:Array;
			tList = [];
			var dataO:Object;
			for (i = 0; i < len; i++)
			{
				dataO = items[i];
				tList.push(dataO.props.label);
			}
			
			var itemLabels:String;
			itemLabels=tList.join(",");
			ItemData.itemLabels = itemLabels;
		}
	}

}