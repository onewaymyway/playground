package view.actionlist 
{
	import laya.events.Event;
	import laya.utils.Handler;
	import simulator.DrowningMachine;
	import simulator.SolveItem;
	import ui.simulator.ActionItemUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ActionItem extends ActionItemUI 
	{
		public var clickHandler:Handler;
		public function ActionItem() 
		{
			actionBtn.on(Event.CLICK, this, onActionClick);
		}
		
		private function onActionClick():void
		{
			if (clickHandler)
			{
				clickHandler.runWith(dataO);
			}
		}
		
		private var dataO:SolveItem;
		public function initByData(dataO:Object):void
		{
			this.dataO = dataO;
			actionText.text = dataO.tip+" "+createActionTip();
			actionBtn.x = actionText.x + actionText.width + 5;
			if (DrowningMachine.I.isActionCanSolve(dataO.name))
			{
				actionBtn.label = "Do";
			}else
			{
				actionBtn.label = "Wait";
			}
			
		}
		
		private function createActionTip():String
		{
			var strList:Array;
			strList = [];
			getStrByOpList(dataO.sub, "-", strList);
			getStrByOpList(dataO.add, "+", strList);
			return strList.join(" ");
		}
		
		private function getStrByOpList(opList:Array,sign:String,arr:Array):void
		{
			var i:int, len:int;
			len = opList.length;
			var tOp:Object;
			for (i = 0; i < len; i++)
			{
				tOp = opList[i];
				if(!DrowningMachine.I.isAction(tOp.name))
				arr.push(getStrByOp(tOp, sign));
			}
		}
		
		private function getStrByOp(op:Object, sign:String):String
		{
			var rst:String;
			if (op.count > 1)
			{
				rst=sign + " " +op.count + op.name;
			}else
			{
				rst=sign + op.name;
			}
			return rst;
		}

	}

}