package  
{
	import laya.utils.Handler;
	import simulator.DrowningMachine;
	/**
	 * ...
	 * @author ww
	 */
	public class Game 
	{
		
		public function Game() 
		{
			Laya.init(1000, 900);
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
			drowningMachine.traceState();
			drowningMachine.doAction("start");
			drowningMachine.traceState();
			drowningMachine.doAction("age0");
			drowningMachine.traceState();
		}
		
	}

}