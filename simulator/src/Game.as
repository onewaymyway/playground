package  
{
	import laya.net.Loader;
	import laya.utils.Handler;
	import simulator.DrowningMachine;
	import view.PlayMainView;
	/**
	 * ...
	 * @author ww
	 */
	public class Game 
	{
		
		public function Game() 
		{
			Laya.init(1000, 900);
			Laya.loader.load( [{url:"res/atlas/comp.json",type:Loader.ATLAS }], new Handler(this, initGameView));
			
		}
		
		private var drowningMachine:DrowningMachine;
		private function test():void
		{
			trace("hello Simulator");
			initGameView();
			return;
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
		
		
		private function initGameView():void
		{
			var mainView:PlayMainView;
			mainView = new PlayMainView();
			mainView.pos(50, 50);
			mainView.top = 0;
			mainView.bottom = 0;
			Laya.stage.addChild(mainView);
		}
		
	}

}