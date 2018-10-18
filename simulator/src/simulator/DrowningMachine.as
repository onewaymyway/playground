package simulator 
{
	import laya.net.Loader;
	import laya.utils.Handler;
	/**
	 * ...
	 * @author ww
	 */
	public class DrowningMachine 
	{
		
		public function DrowningMachine() 
		{
			
		}
		
		private var ruleUrl:String;
		private var complete:Handler;
		public function initByRules(ruleUrl:String,complete:Handler):void
		{
			this.ruleUrl = ruleUrl;
			this.complete = complete;
			Laya.loader.load(ruleUrl, new Handler(this, onRuleLoaded));
		}
		
		private function onRuleLoaded():void
		{
			initByRuleObject(Loader.getRes(ruleUrl));
			if (complete)
			{
				complete.run();
			}
		}
		
		private var actionDic:Object = { };
		private var availableActionDic:Object = { };
		private var itemDic:Object = { };
		private function initByRuleObject(ruleO:Object):void
		{
			//debugger;
			var rules:Array;
			rules = ruleO.rules;
			var i:int, len:int;
			len = rules.length;
			var tRuleO:Object;
			for (i = 0; i < len; i++)
			{
				tRuleO = rules[i];
				actionDic[tRuleO.name] = SolveItem.createByData(tRuleO);
			}
			trace("actionDic:",actionDic);
		}
		
		private function isAction(itemName:String):Boolean
		{
			return actionDic.hasOwnProperty(itemName);
		}
		
		public function getItemCount(itemName:String):int
		{
			if (isAction(itemName))
			{
				return availableActionDic.hasOwnProperty(itemName)?1:0;
			}
			if (!itemDic[itemName]) return 0;
			return itemDic[itemName].count;
		}
		public function addItem(itemName:String, itemCount:int = 1):void
		{
			if (isAction(itemName))
			{
				if (itemCount > 0)
				{
					availableActionDic[itemName] = actionDic[itemName];
				}else
				{
					delete availableActionDic[itemName];
				}
				
			}else
			{
				if (!itemDic.hasOwnProperty(itemName))
				{
					itemDic[itemName] = {count:0,name:itemName};
				}
				itemDic[itemName].count += itemCount;
			}
		}
		
		public function isActionCanSolve(action:String):Boolean
		{
			
		}
		
		private function doOpList(opList:Array,dir:int=1):void
		{
			var i:int, len:int;
			len = opList.length;
			var tOp:Object;
			for (i = 0; i < len; i++)
			{
				tOp = opList[i];
				addItem(tOp.name, dir * tOp.count);
			}
		}
		public function doAction(action:String):void
		{
			var actionItem:SolveItem;
			actionItem = availableActionDic[action];
			if (!actionItem)
			{
				trace("action not found:", action, availableActionDic);
				return;
			}
			trace("doAction:", action, actionItem);
		
			doOpList(actionItem.add, 1);
			doOpList(actionItem.sub, -1);
			trace("doAction success:",action);
		}
		public function getAvailableActionList():Array
		{
			var key:String;
			var rst:Array;
			rst = [];
			for (key in availableActionDic)
			{
				rst.push(availableActionDic[key]);
			}
			rst.sort(_sortName);
			return rst;
		}
		
		public function getItemList():Array
		{
			var key:String;
			var rst:Array;
			rst = [];
			for (key in itemDic)
			{
				rst.push(itemDic[key]);
			}
			rst.sort(_sortName);
			return rst;
		}
		
		private function _sortName(a:Object, b:Object):int
		{
			return a.name > b.name?1: -1;
		}
		
		public function traceState():void
		{
			trace("action:", getAvailableActionList());
			trace("items:", getItemList());
		}
		
	}

}