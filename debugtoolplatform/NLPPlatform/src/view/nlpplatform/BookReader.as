package view.nlpplatform 
{
	import commontools.SimpleGesture;
	import laya.events.Event;
	import laya.events.Keyboard;
	import laya.ui.Button;
	import nlp.WordDicParser;
	import nlp.bookutils.BookParser;
	import nlp.tagging.TaggingBook;
	import nodetools.devices.FileManager;
	import nodetools.devices.FileTools;
	import ui.nlpplatform.BookReaderUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class BookReader extends BookReaderUI 
	{
		public var book:TaggingBook;
		
		private var gesture:SimpleGesture;
		public function BookReader() 
		{
			Laya.stage.on(Event.KEY_DOWN, this, onKeyDown);
			buttonBox.on(Event.CLICK, this, onBtnClick);
			buttonBox.vScrollBar.autoHide = true;
			buttonBox.vScrollBar.touchScrollEnable = true;
			this.on("wordevent", this, onWordEvent);
			gesture = new SimpleGesture();
			gesture.setTarget(this);
			gesture.sendChildFirst = true;
			this.on(SimpleGesture.LEFT, this, onGesture, [SimpleGesture.LEFT]);
			this.on(SimpleGesture.RIGHT, this, onGesture, [SimpleGesture.RIGHT]);
			wordView.on(WordListViewer.ShowWords, this, onShowWord);
			
			go.on(Event.CLICK, this, onGo);
		}
		
		private function onGo():void
		{
			var tPage:int;
			tPage = parseInt(pageNum.text) || 0;
			wordView.goTo(tPage);
		}
		private function onShowWord():void
		{
			bookInfo.text = wordView.book.index + "/" + wordView.book.maxLine+"(" + ((wordView.book.index /wordView.book.maxLine)*100).toFixed(1)+"%)"+"\n"+"词:"+wordView.book.words.length;
		}
		
		private function onGesture(type:String):void
		{
			switch(type)
			{
				case SimpleGesture.LEFT:
					wordView.pre();
					break;
				case SimpleGesture.RIGHT:
					wordView.next();
					break;
			}
		}
		
		private function onWordEvent(type:String, word:WordViewer):void
		{
			switch(type)
			{
				case "打散":
					book.breakWord(word.dataO);
					wordView.showLine();
					break;
				case "合词":
					if (BookReaderState.startWord&&BookReaderState.endWord)
					{
						success = book.connectWord(BookReaderState.startWord.dataO, BookReaderState.endWord.dataO);
						wordView.showLine();
					}
					break;
				case "全文合词":
					if (BookReaderState.startWord&&BookReaderState.endWord)
					{
						success = book.connectWord(BookReaderState.startWord.dataO, BookReaderState.endWord.dataO,true);
						wordView.showLine();
					}
					break;
			}
		}
		private function onBtnClick(e:Event):void
		{
			var tButton:Button;
			tButton = e.target;
			trace("onBtnClick:", tButton.name);
			var success:Boolean;
			switch(tButton.name)
			{
				case "清空选择":
					BookReaderState.clearSelect();
					break;
				case "创建关系":
					if (BookReaderState.startWord&&BookReaderState.endWord)
					{
						success = book.createRelation(BookReaderState.startWord.dataO, BookReaderState.endWord.dataO);
						wordView.showLine();
					}else
					{
						if (BookReaderState.startWord)
						{
							success = book.deleteRelation(BookReaderState.startWord.dataO);
							wordView.showLine();
						}
					}
					break;
				case "重建关系":
					if (BookReaderState.startWord&&BookReaderState.endWord)
					{
						success = book.buildWordRelation(BookReaderState.startWord.dataO, BookReaderState.endWord.dataO);
						wordView.showLine();
					}
					break;
				case "打散":
					if (BookReaderState.startWord)
					{
						success = book.breakWord(BookReaderState.startWord.dataO);
						wordView.showLine();
					}
					break;
				case "全文打散":
					if (BookReaderState.startWord)
					{
						success = book.breakWord(BookReaderState.startWord.dataO,true);
						wordView.showLine();
					}
					break;
				case "合词":
					if (BookReaderState.startWord&&BookReaderState.endWord)
					{
						success = book.connectWord(BookReaderState.startWord.dataO, BookReaderState.endWord.dataO);
						wordView.showLine();
					}
					break;
				case "全文合词":
					if (BookReaderState.startWord&&BookReaderState.endWord)
					{
						success = book.connectWord(BookReaderState.startWord.dataO, BookReaderState.endWord.dataO,true);
						wordView.showLine();
					}
					break;
				case "重新分词":
					if (BookReaderState.startWord&&BookReaderState.endWord)
					{
						success = book.reCutWord(BookReaderState.startWord.dataO, BookReaderState.endWord.dataO,false);
						wordView.showLine();
					}
				case "广播标注":
					if (BookReaderState.startWord)
					{
						if (BookReaderState.endWord)
						{
							success = book.copyWordPropByWord(BookReaderState.startWord.dataO, BookReaderState.endWord.dataO,false);
						}else
						{
							success = book.copyWordPropByWord(BookReaderState.startWord.dataO, null,false);
						}
						
						wordView.showLine();
					}
					break;
				case "删除句中空格":
					
					success = book.removeNoUseEmpty();
					wordView.showLine();
					
					break;
				case "删除":
					if (BookReaderState.startWord)
					{
						if (BookReaderState.endWord)
						{
							success = book.deleteWords(BookReaderState.startWord.dataO, BookReaderState.endWord.dataO,false);
						}else
						{
							success = book.deleteWords(BookReaderState.startWord.dataO, null,false);
						}
						//success = book.deleteWords(BookReaderState.startWord.dataO, BookReaderState.endWord.dataO,false);
						wordView.showLine();
					}
					break;
					
			}
		}
		
		public function loadFile(filePath:String):void
		{
			book = new TaggingBook();
			var fileStr:String;
			var extension:String;
			extension = FileTools.getExtensionName(filePath);
			if (extension == NLPPlatFormConst.TaggingExtension)
			{
				book.initByData(FileManager.readJSONFile(filePath));
			}else
			{
				fileStr = FileTools.readFile(filePath);
			
				book.initByString(fileStr);
			}
			
			
			wordView.setBook(book);
			
		}
		
		private function onKeyDown(e:Event):void
		{
			switch(e.keyCode)
			{
				case Keyboard.UP:
					wordView.pre();
					break;
				case Keyboard.DOWN:
					wordView.next();
					break;
			}
		}
	}

}