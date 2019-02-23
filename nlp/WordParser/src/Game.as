package  
{
	import laya.events.Event;
	import laya.net.Loader;
	import laya.utils.Handler;
	import nlp.dictools.TypeDicParser;
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
			loadList.push( { url:"data/CoreSynonym.txt", type:Loader.TEXT } );
			loadList.push({url:"data/CoreNatureDictionary.txt",type:Loader.TEXT });
			Laya.loader.load( loadList, new Handler(this, initGameView));
			
		}

		
		
		
		private function initGameView():void
		{
			//WordUtils.showChars(0, 1000);
			WordDicParser.I.loadDic("data/中文字典1.txt",Handler.create(this,onDicLoaded));
			var tUI:Main;
			tUI = new Main();
			Laya.stage.addChild(tUI);
		}
		
		private function onDicLoaded():void
		{
			
			var typeDic:TypeDicParser;
			typeDic = new TypeDicParser();
			typeDic.initByTxt(Loader.getRes("data/CoreNatureDictionary.txt"));
			trace(typeDic);
			WordDicParser.I.cutter.typeDic = typeDic;
			Laya.stage.on(Event.CLICK, this, testCut);
		}
		
		private function testCut():void
		{
			var testStrList:Array;
			testStrList = [];
			testStrList.push("你是笨蛋吗");
			testStrList.push("该剧改编自芦原妃名子的同名漫画，讲述了高中时代曾是同班同学的主人公和女主角，因以前的同学去世为契机而再相见，他们一边搜寻以前的同学曾秘密交往过的男性，一边面对自己的回忆的模样。");
			var testStr:String;
			
			var words:Array;
			
			var i:int, len:int;
			len = testStrList.length;
			for (i = 0; i < len; i++)
			{
				testStr = testStrList[i];
				words = WordDicParser.I.cut(testStr);
				trace("words:",words);
			}
			
		}
		
	}

}