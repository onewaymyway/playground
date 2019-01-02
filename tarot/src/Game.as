package  
{
	import carotutils.CarotDataManager;
	import laya.net.Loader;
	import laya.utils.Handler;
	import simulator.DrowningMachine;
	import view.PlayMainView;
	import view.tarot.TarotMain;
	/**
	 * ...
	 * @author ww
	 */
	public class Game 
	{
		
		public function Game() 
		{
			Laya.init(1000, 900);
			var loadList:Array;
			loadList = [];
			loadList.push( { url:"res/atlas/comp.json", type:Loader.ATLAS } );
			loadList.push({url:"data/cardconfig.json",type:Loader.JSON });
			Laya.loader.load( loadList, new Handler(this, initGameView));
			
		}

		
		
		
		private function initGameView():void
		{
			CarotDataManager.initByCardDatas(Loader.getRes("data/cardconfig.json"));
			var mainView:TarotMain;
			mainView = new TarotMain();
			mainView.pos(50, 50);
			mainView.top = 0;
			mainView.bottom = 0;
			Laya.stage.addChild(mainView);
		}
		
	}

}