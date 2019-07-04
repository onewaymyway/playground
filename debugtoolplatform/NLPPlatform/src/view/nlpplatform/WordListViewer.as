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
			layouter.spaceY = 30;
			layouter.startY = 30;
			container.on(Event.RESIZE, this, freshUI);
			container.vScrollBar.autoHide = true;
			container.vScrollBar.touchScrollEnable = true;
			idWordDic = new IDDicTool();
			this.on("wordchanged", this, onEvent, ["wordchanged"]);
		}
		
		private function onEvent(type:String):void
		{
			switch(type)
			{
				case "wordchanged":
					showLine();
					break;
			}
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
			if(!book.index)
			book.line = 0;
			showLine();
		}
		
		public function goTo(index:int):void
		{
			book.goto(index);
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
			drawRelations();
		}
		private function drawRelations():void
		{
			container.graphics.clear();
			var i:int, len:int;
			len = wordItemList.length;
			var tWord:WordViewer;
			var headWord:WordViewer;
			for (i = 0; i < len; i++)
			{
				tWord = wordItemList[i];
				if (tWord.dataO.head)
				{
					headWord = idWordDic.getItem(tWord.dataO.head);
					if (headWord)
					{
						drawRelation(tWord, headWord);
					}
				}
			}
		}
		private function drawRelation(startWord:WordViewer, endWord:WordViewer):void
		{
			var startX:Number;
			var startY:Number;
			var endX:Number;
			var endY:Number;
			startX = startWord.getCenterX();
			startY = startWord.getCenterY();
			endX = endWord.getCenterX();
			endY = endWord.getCenterY();
			var midX:Number;
			var midy:Number;
			midX = (startX + endX) * 0.5;
			if (startY == endY)
			{
				midy = startY + Math.abs(startX-endX)*0.3;
			}else
			{
				midy = (startY + endY) * 0.5;
			}
			container.graphics.drawCurves(0, 0, [startX, startY, midX, midy, endX, endY], "#ff0000");
			container.graphics.fillText(startWord.dataO.deprel + "", midX, midy, null, "#ff0000", "center");
		}
	}

}