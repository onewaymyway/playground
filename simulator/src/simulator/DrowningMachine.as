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
				actionDic[tRuleO.name] = tRuleO;
			}
			trace("actionDic:",actionDic);
		}
		
		private function isAction(itemName:String):Boolean
		{
			return actionDic.hasOwnProperty(itemName);
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
		public function doAction(action:String):void
		{
			var actionItem:Object;
			actionItem = availableActionDic[action];
			if (!actionItem)
			{
				trace("action not found:", action, availableActionDic);
				return;
			}
			trace("doAction:", action, actionItem);
			var solveO:Object;
			solveO = actionItem.solve;
			if (!solveO)
			{
				trace("solveO not found:",actionItem);
			}
			
			var i:int, len:int;
			var adds:Array;
			adds = solveO.add;
			var tSolveItem:*;
			if (adds && adds.length)
			{
				len = adds.length;
				for (i = 0; i < len; i++)
				{
					tSolveItem = adds[i];
					if (tSolveItem is String)
					{
						addItem(tSolveItem,1);
					}else
					if (tSolveItem is Array)
					{
						if (tSolveItem.length >1)
						{
							addItem(tSolveItem[0],1);
						}else
						{
							addItem(tSolveItem[0],tSolveItem[1]);
						}
					}
				}
			}
			var subs:Array;
			subs = solveO.sub;
			if (subs && subs.length)
			{
				len = subs.length;
				for (i = 0; i < len; i++)
				{
					tSolveItem = subs[i];
					if (tSolveItem is String)
					{
						addItem(tSolveItem,-1);
					}else
					if (tSolveItem is Array)
					{
						if (tSolveItem.length >1)
						{
							addItem(tSolveItem[0],-1);
						}else
						{
							addItem(tSolveItem[0],-tSolveItem[1]);
						}
					}
				}
			}
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