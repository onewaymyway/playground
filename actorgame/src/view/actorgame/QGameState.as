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
		public var hiddenStates:Array;
		public var allStates:Array;
		public var roleDic:Object;
		public var day:int = 0;
		public var preActor:String = null;
		public function initByGameData(dataO:QGameDataManager):void
		{
			roleStates = [];
			hiddenStates = [];
			allStates = [];
			roleDic = { };
			preActor = null;
			var roles:Array;
			roles = dataO.roles;
			var i:int, len:int;
			len = roles.length;
			var tDataO:ActorData;
			var tRoleO:Object;
			for (i = 0; i < len; i++)
			{
				tRoleO = roles[i];
				tDataO = new ActorData();
				tDataO.label = tRoleO.props.label;
				tDataO.count = 5;
				tDataO.sign = tRoleO.props.icon;
				tDataO.lastOpCount = 0;
				roleDic[tDataO.label] = tDataO;
				allStates.push(tDataO);
				if (tRoleO.props.hidden)
				{
					hiddenStates.push(tDataO);
				}else
				{
					roleStates.push(tDataO);
				}
				
			}
			var questions:Array;
			questions = dataO.questions;
			len = questions.length;
			var tQuestion:Object;
			for (i = 0; i < len; i++)
			{
				tQuestion = questions[i];
				addQuestionToRole(tQuestion);
			}
			money = 800000;
			day = 0;
		}
		
		public function getQuestionByRole(role:String):Object
		{
			var tActor:ActorData;
			tActor = roleDic[role];
			if (tActor)
			{
				return tActor.getRandomQuestion();
			}
			return QGameDataManager.I.getRandomQuestion();
		}
		
		private function addQuestionToRole(questionO:Object):void
		{
			var tActor:ActorData;
			
			if (questionO.type == "low")
			{
				tActor = roleDic[questionO.actor];
				if (tActor)
				{
					tActor.lowActions.push(questionO);
				}
				return;
			}
			if (questionO.type == "high")
			{
				tActor = roleDic[questionO.actor];
				if (tActor)
				{
					tActor.highActions.push(questionO);
				}
				return;
			}
			if (questionO.type == "tooHigh")
			{
				tActor = roleDic[questionO.actor];
				if (tActor)
				{
					tActor.tooHighActions.push(questionO);
				}
				return;
			}
			var actorDic:Object;
			actorDic = questionO.actorDic;
			var key:String;
			
			for (key in actorDic)
			{
				tActor = roleDic[key];
				if (!tActor) continue;
				tActor.questions.push(questionO);
			}
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
			money += opCostMoney;
			money -= 10000;
			changedMoney = money - preMoney;
			//money = preMoney;
		}
		public function nextDay():void
		{
			day++;
			eventList.length = 0;
			var i:int, len:int;
			len = allStates.length;
			var tActor:ActorData;
			for (i = 0; i < len; i++)
			{
				tActor = allStates[i];
				tActor.next();
			}
			if (money <= 0)
			{
				addEvent("钱花完了，公司倒闭了！！", true);
			}
		}
		
		public function getTriggerAction():Object
		{
			var i:int, len:int;
			len = allStates.length;
			var tActor:ActorData;
			var tAction:Object;
			for (i = 0; i < len; i++)
			{
				tActor = allStates[i];
				tAction = tActor.getAction();
				if (tAction)
				{
					//tActor.clearState();
					return tAction;
				} 
			}
			return null;
		}
		public function addEvent(eventName:String, isOver:Boolean = false):void
		{
			var tEvent:Object;
			tEvent = { };
			tEvent.label = eventName;
			tEvent.isOver = isOver;
			eventList.push(tEvent);
		}
		
		private var opCostMoney:int = 0;
		public function updateRoleState(ops:Array):void
		{
			clearLastOp();
			opCostMoney = 0;
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
			if (opO.item == "money")
			{
				opCostMoney += opO.count;
				return;
			}
			var tRoleO:Object;
			tRoleO = roleDic[opO.item];
			if (!tRoleO)
			{
				trace("role not found:",opO.item,opO)
				debugger;
				return;
			} 
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