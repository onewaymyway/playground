package  
{
	import carotutils.CarotDataManager;
	import laya.display.Stage;
	import laya.net.Loader;
	import laya.utils.Handler;
	import simulator.DrowningMachine;
	import view.actorgame.GameMain;
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
			Laya.init(720, 1280);
			Laya.stage.scaleMode = Stage.SCALE_SHOWALL;
			Laya.stage.alignH = Stage.ALIGN_CENTER;
			Laya.stage.alignV = Stage.ALIGN_MIDDLE;
			var loadList:Array;
			loadList = [];
			loadList.push( { url:"res/atlas/comp.json", type:Loader.ATLAS } );
			loadList.push({url:"data/cardconfig.json",type:Loader.JSON });
			Laya.loader.load( loadList, new Handler(this, initGameView));
			
		}

		
		
		
		private function initGameView():void
		{
			//CarotDataManager.initByCardDatas(Loader.getRes("data/cardconfig.json"));
			var mainView:GameMain;
			mainView = new GameMain();
			mainView.pos(50, 50);
			mainView.top = 0;
			mainView.bottom = 0;
			Laya.stage.addChild(mainView);
		}
		
	}

}