package view.actorgame 
{
	/**
	 * ...
	 * @author ww
	 */
	public class QGameState 
	{
		public static var I:QGameState;
		public function QGameState() 
		{
			
		}
		public var money:int;
		public var roleStates:Array;
		public var roleDic:Object;
		public var day:int = 0;
		public function initByGameData(dataO:QGameDataManager):void
		{
			roleStates = [];
			roleDic = { };
			var roles:Array;
			roles = dataO.roles;
			var i:int, len:int;
			len = roles.length;
			var tDataO:Object;
			var tRoleO:Object;
			for (i = 0; i < len; i++)
			{
				tRoleO = roles[i];
				tDataO = new ActorData();
				tDataO.label = tRoleO.props.label;
				tDataO.count = 5;
				tDataO.lastOpCount = 0;
				roleDic[tDataO.label] = tDataO;
				roleStates.push(tDataO);
			}
			money = 500000;
			day = 0;
		}
		
		private function clearLastOp():void
		{
			var i:int, len:int;
			len = roleStates.length;
			for (i = 0; i < len; i++)
			{
				roleStates[i].lastOpCount = 0;
			}
		}
		public static function getSignedInt(value:int):String
		{
			if (value > 0) return "+" + value;
			return value;
		}
		public var eventList:Array = [];
		public var changedMoney:int;
		public function todayInfo():void
		{
			eventList.length = 0;
			var i:int, len:int;
			len = roleStates.length;
			var preMoney:Number;
			preMoney = money;
			changedMoney = 0;
			var tActor:ActorData;
			for (i = 0; i < len; i++)
			{
				tActor = roleStates[i];
				money += tActor.getChangeMoney();
			}
			money -= 10000;
			changedMoney = money - preMoney;
			//money = preMoney;
		}
		public function nextDay():void
		{
			day++;
			eventList.length = 0;
			var i:int, len:int;
			len = roleStates.length;
			var tActor:ActorData;
			for (i = 0; i < len; i++)
			{
				tActor = roleStates[i];
				tActor.next();
			}
			if (money <= 0)
			{
				addEvent("钱花完了，公司倒闭了！！", true);
			}
		}
		public function addEvent(eventName:String, isOver:Boolean = false):void
		{
			var tEvent:Object;
			tEvent = { };
			tEvent.label = eventName;
			tEvent.isOver = isOver;
			eventList.push(tEvent);
		}
		public function updateRoleState(ops:Array):void
		{
			clearLastOp();
			var i:int, len:int;
			var tOp:Object;
			len = ops.length;
			for (i = 0; i < len; i++)
			{
				excuteOp(ops[i]);
			}
		}
		private function excuteOp(opO:Object):void
		{
			var tRoleO:Object;
			tRoleO = roleDic[opO.item];
			if (!tRoleO) debugger;
			tRoleO.lastOpCount = opO.count;
			tRoleO.count += opO.count;
			if (tRoleO.count < 0) tRoleO.count = 0;
			if (tRoleO.count > 20) tRoleO.count = 20;
			
		}
		
		public static function initByData(dataO:QGameDataManager):void
		{
			I = new QGameState();
			I.initByGameData(dataO);
		}
		
	}

}