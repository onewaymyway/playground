package view 
{
	import laya.utils.Handler;
	import simulator.DrowningMachine;
	import ui.simulator.PlayMainViewUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class PlayMainView extends PlayMainViewUI 
	{
		
		public function PlayMainView() 
		{
			test();
		}
		private var drowningMachine:DrowningMachine;
		private function test():void
		{
			trace("hello Simulator");
			
			drowningMachine = new DrowningMachine();
			drowningMachine.initByRules("data/rules.json", new Handler(this, initDrowningMachine));
		}
		
		private function initDrowningMachine():void
		{
			debugger;
			drowningMachine.addItem("start");
			freshUI();
			drowningMachine.doAction("start");
			freshUI();
			drowningMachine.doAction("age0");
			freshUI();
		}
		
		private function freshUI() :void
		{
			drowningMachine.traceState();
			actionList.setData(drowningMachine.getAvailableActionList());
			itemList.setData(drowningMachine.getItemList());
		}
	}

}