package  
{
	import laya.net.Loader;
	import laya.utils.Handler;
	import nlp.WordDicParser;
	import nlp.WordUtils;
	import ui.wordparser.MainUI;
	import view.Main;
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
			//WordUtils.showChars(0, 1000);
			WordDicParser.I.loadDic("data/中文字典1.txt");
			var tUI:Main;
			tUI = new Main();
			Laya.stage.addChild(tUI);
		}
		
	}

}