package view.nlpplatform 
{
	import commonlayout.WordLayout;
	import commontoolkit.IDDicTool;
	import laya.events.Event;
	import laya.utils.Pool;
	import nlp.tagging.TaggingBook;
	import ui.nlpplatform.WordListViewerUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class WordListViewer extends WordListViewerUI 
	{
		public static const ShowWords:String = "ShowWords";
		public var layouter:WordLayout;
		public function WordListViewer() 
		{
			layouter = new WordLayout();
			container.on(Event.RESIZE, this, freshUI);
			idWordDic = new IDDicTool();
		}
		
		private var wList:Array;
		private var wordItemList:Array;
		private var idWordDic:IDDicTool;
		private function clearPre():void
		{
			BookReaderState.clearSelect();
			if (!wordItemList) return;
			var i:int, len:int;
			len = wordItemList.length;
			var tItem:WordViewer;
			for (i = 0; i < len; i++)
			{
				tItem = wordItemList[i];
				tItem.reset();
				tItem.removeSelf();
				Pool.recover("WordViewer", tItem);
			}
			wordItemList.length = 0;
		}
		
		public var lines:Array;
		public var book:TaggingBook;
		public function setBook(book:TaggingBook):void
		{
			this.book = book;
			book.line = 0;
			showLine();
		}
		
		public function pre():void
		{
			book.pre();
			showLine();
		}
		
		public function next():void
		{
			book.next();
			showLine();
		}
		public function showLine():void
		{
			var lineInfo:Object;
			lineInfo = book.getCurLineInfo();
			if (!lineInfo) return;
			
			setWordList(book.words, lineInfo.start, lineInfo.end);
			event(ShowWords);
		}
		public function setWordList(wList:Array,start:int,end:int):void
		{
			this.wList = wList;
			clearPre();
			wordItemList = [];
			var i:int, len:int;
			var tWord:WordViewer;
			for (i = start; i <= end; i++)
			{
				tWord = Pool.getItemByClass("WordViewer", WordViewer);
				tWord.setData(wList[i]);
				wordItemList.push(tWord);
				container.addChild(tWord);
			}
			idWordDic.initByItems(wordItemList);
			freshUI();
			
		}
		
		private function freshUI():void
		{
			if (!wordItemList) return;
			layouter.layout(wordItemList, container.width, container.height);
		}
		
	}

}