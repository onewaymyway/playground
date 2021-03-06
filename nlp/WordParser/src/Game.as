package  
{
	import laya.events.Event;
	import laya.events.Keyboard;
	import laya.net.Loader;
	import laya.utils.Browser;
	import laya.utils.Handler;
	import nlp.NLP;
	import nlp.bookutils.BookParser;
	import nlp.conll.ConllDesParser;
	import nlp.conll.ConllFileParser;
	import nlp.conll.ConllTreeAnalyse;
	import nlp.conll.ConllTreeBuilder;
	import nlp.dictools.TypeDicParser;
	import nlp.WordDicParser;
	import nlp.WordUtils;
	import ui.wordparser.MainUI;
	import view.Main;
	import view.WordListViewer;
	import view.WordTreeViewer;
	/**
	 * ...
	 * @author ww
	 */
	public class Game 
	{
		
		public function Game() 
		{
			Laya.init(Browser.width, 900);
			var loadList:Array;
			loadList = [];
			loadList.push( { url:"res/atlas/comp.json", type:Loader.ATLAS } );
			loadList.push( { url:"data/CoreSynonym.txt", type:Loader.TEXT } );
			loadList.push({url:"data/CoreNatureDictionary.txt", type:Loader.TEXT });
			loadList.push( { url:"books/qqst.txt", type:Loader.TEXT } );
			loadList.push({url:"data/text.train.conll", type:Loader.TEXT });
			loadList.push({url:"data/news.train.conll", type:Loader.TEXT });
			loadList.push( { url:"data/conlldes.txt", type:Loader.TEXT } );
			loadList.push({url:"data/中文字典1.txt",type:Loader.TEXT });
			Laya.loader.load( loadList, new Handler(this, initGameView));
			
		}

		
		
		public var wordView:WordListViewer;
		
		private function initGameView():void
		{
			//WordUtils.showChars(0, 1000);
			
			//startWordParserTest();
			
			testWordTree();
		}
		
		private function startWordParserTest():void
		{
			NLP.initWordCutter("data/中文字典1.txt", "data/CoreNatureDictionary.txt");
			NLP.initConllTreeParser("data/conlldes.txt", ["data/text.train.conll","data/news.train.conll"]);
			
			contreeBuilder = NLP.contreeBuilder;
			conllParser = NLP.conllParser;

			onDicLoaded();
	
		}
		
		private function onDicLoaded():void
		{
			
			testWordParser();
			//Laya.stage.on(Event.CLICK, this, testCut);		
			
			Laya.stage.graphics.fillText("ready", 10, 10, null, "#ff0000",null);
		}
		
		private function testWordParser():void
		{
			
			wordView = new WordListViewer();
			wordView.pos(20, 20);
			wordView.width = Laya.stage.width - 40;
			Laya.stage.addChild(wordView);
			
			wordTreeView2 = new WordTreeViewer();
			wordTreeView2.pos(20, 300);
			wordTreeView2.width = Laya.stage.width - 40;
			Laya.stage.addChild(wordTreeView2);
			
			wordTreeView3 = new WordTreeViewer();
			wordTreeView3.pos(20, 600);
			wordTreeView3.width = Laya.stage.width - 40;
			Laya.stage.addChild(wordTreeView3);
			
			
			WordDicParser.I.cutter.cutToMap("每个人的一生，都离不开金钱、离不开商业，但是，很多人从来没有试图好好地、认真地去走近它，了解它。它是一个我们每天都碰到的、陌生的朋友。");
			wordTreeView2.setTree(NLP.contreeBuilder.cutStringToTree("每个人的一生，都离不开金钱、离不开商业，但是，很多人从来没有试图好好地、认真地去走近它"));
			wordTreeView3.setTree(NLP.contreeBuilder.cutStringToTree("每个人的一生，都离不开金钱、离不开商业，但是，很多人从来没有试图好好地、认真地去走近它",true));
			testCut();
		}
		
		private var conllParser:ConllFileParser;
		private var wordTreeView:WordTreeViewer;
		private var wordTreeView2:WordTreeViewer;
		private var wordTreeView3:WordTreeViewer;
		private var contreeBuilder:ConllTreeBuilder;
		private function testWordTree():void
		{
			
			NLP.initWordCutter("data/中文字典1.txt", "data/CoreNatureDictionary.txt");
			
			NLP.initConllTreeParser("data/conlldes.txt", ["data/text.train.conll","data/news.train.conll"]);
			
			contreeBuilder = NLP.contreeBuilder;
			conllParser = NLP.conllParser;
			
			trace("contreeBuilder:",contreeBuilder);
			wordTreeView = new WordTreeViewer();
			wordTreeView.pos(20, 10);
			wordTreeView.width = Laya.stage.width - 40;
			Laya.stage.addChild(wordTreeView);
			//return;
			wordTreeView.setTree(conllParser.getCurLine());
			
			wordTreeView2 = new WordTreeViewer();
			wordTreeView2.pos(20, 300);
			wordTreeView2.width = Laya.stage.width - 40;
			Laya.stage.addChild(wordTreeView2);
			//return;
			wordTreeView2.setTree(contreeBuilder.rebuildConllTree(conllParser.getCurLine()));
			
			wordTreeView3 = new WordTreeViewer();
			wordTreeView3.pos(20, 600);
			wordTreeView3.width = Laya.stage.width - 40;
			Laya.stage.addChild(wordTreeView3);
			//return;
			wordTreeView3.setTree(contreeBuilder.rebuildConllTree(conllParser.getCurLine(),true));
			
			Laya.stage.on(Event.KEY_DOWN, this, onWordTreeKeyDown);
		}
		
		private function onWordTreeKeyDown(e:Event):void
		{
			switch(e.keyCode)
			{
				case Keyboard.UP:
					wordTreeView.setTree(conllParser.pre());
					wordTreeView2.setTree(contreeBuilder.rebuildConllTree(conllParser.getCurLine()));
					wordTreeView3.setTree(contreeBuilder.rebuildConllTree(conllParser.getCurLine(),true));
					break;
				case Keyboard.DOWN:
					wordTreeView.setTree(conllParser.next());
					wordTreeView2.setTree(contreeBuilder.rebuildConllTree(conllParser.getCurLine()));
					wordTreeView3.setTree(contreeBuilder.rebuildConllTree(conllParser.getCurLine(),true));
					break;
			}
		}
		
		private var book:BookParser;
		private function testCut():void
		{
			var testStrList:Array;
			testStrList = [];
			//testStrList.push("你是笨蛋吗");
			//testStrList.push("该剧改编自芦原妃名子的同名漫画，讲述了高中时代曾是同班同学的主人公和女主角，因以前的同学去世为契机而再相见，他们一边搜寻以前的同学曾秘密交往过的男性，一边面对自己的回忆的模样。");
			testStrList.push("每个人的一生，都离不开金钱、离不开商业，但是，很多人从来没有试图好好地、认真地去走近它，了解它。它是一个我们每天都碰到的、陌生的朋友。");
			var testStr:String;
			
			var words:Array;
			
			var i:int, len:int;
			len = testStrList.length;
			for (i = 0; i < len; i++)
			{
				testStr = testStrList[i];
				debugger;
				words = WordDicParser.I.cut(testStr);
				trace("words:",words);
			}
			
			wordView.setWordList(words);
			
			book = BookParser.createByTxt(Loader.getRes("books/qqst.txt"));
			Laya.stage.on(Event.KEY_DOWN, this, onKeyDown);
			showTxt("键盘上下控制段落切换显示");
		}
		public function showTxt(str:String):void
		{
			str = str || "no words";
			var words:Array;
			words = WordDicParser.I.cut(str);
			wordView.setWordList(words);
			wordTreeView2.setTree(NLP.contreeBuilder.cutStringToTree(str));
			wordTreeView3.setTree(NLP.contreeBuilder.cutStringToTree(str,true));
		}
		private function onKeyDown(e:Event):void
		{
			switch(e.keyCode)
			{
				case Keyboard.UP:
					showTxt(book.pre());
					break;
				case Keyboard.DOWN:
					showTxt(book.next());
					break;
			}
		}
		
	}

}