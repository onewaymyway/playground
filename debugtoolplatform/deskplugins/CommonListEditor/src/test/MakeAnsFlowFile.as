package test 
{
	import answerflow.AnswerFlowEditor;
	import laya.utils.Handler;
	import nodetools.devices.FileManager;
	/**
	 * ...
	 * @author ww
	 */
	public class MakeAnsFlowFile 
	{
		
		public function MakeAnsFlowFile() 
		{
			
		}
		
		
		public function test():void
		{
			Laya.loader.load("rules.json", Handler.create(this, onLoaded));
		}
		
		private function onLoaded(dataO:Object):void
		{
			debugger;
			parseRulesToAnsFlowFile(dataO);
		}
		
		private function parseRulesToAnsFlowFile(dataO:Object):void
		{
			var rules:Array;
			rules = dataO.rules;
			var i:int, len:int;
			len = rules.length;
			
			var actions:Array;
			actions = [];
			for (i = 0; i < len; i++)
			{
				actions.push(parseOneAction(rules[i]));
			}
			debugger;
			var dataStore:Object;
			dataStore = { };
			dataStore.type = "AutoCreate";
			dataStore.actions = actions;
			FileManager.createJSONFile(FileManager.getAppPath("files/Life.ansflow"),dataStore);
		}
		
		private function parseOneAction(actionO:Object):Object
		{
			var rst:Object;
			rst = AnswerFlowEditor.createActionData();
			var actionData:Object;
			actionData = rst.data;
			actionData.props.des = actionO.tip;
			actionData.props.label = actionO.name;
			
			parseItemsToArr(actionO.solve.add, actionData.childs[1].childs[0].childs);
			parseItemsToArr(actionO.solve.sub, actionData.childs[1].childs[1].childs);
			return rst;
		}
		private function parseItemsToArr(arr:Array, rstArr:Array):void
		{
			if (!arr) return;
			if (!rstArr) return;
			var i:int, len:int;
			len = arr.length;
			for (i = 0; i < len; i++)
			{
				rstArr.push(parseOneItem(arr[i]));
			}
		}
		
		private function createOneItem(name:int, count:int):void
		{
			var rst:Object;
			rst={
				"type":"ItemData",
				"props": {item:name,count:count },
				"childs":[]
				};
			return rst;
		}
		private function parseOneItem(item:*):Object
		{
			if (item is String)
			{
				return createOneItem(item, 1);
			}
			if (item is Array)
			{
				return createOneItem(item[0], item[1]?item[1]:1);
			}
		}
	}

}