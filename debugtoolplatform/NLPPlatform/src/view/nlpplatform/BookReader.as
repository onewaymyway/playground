package view.nlpplatform 
{
	import laya.events.Event;
	import laya.events.Keyboard;
	import nlp.WordDicParser;
	import nlp.bookutils.BookParser;
	import nlp.tagging.TaggingBook;
	import nodetools.devices.FileTools;
	import ui.nlpplatform.BookReaderUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class BookReader extends BookReaderUI 
	{
		public var book:TaggingBook;
		
		
		public function BookReader() 
		{
			Laya.stage.on(Event.KEY_DOWN, this, onKeyDown);
		}
		
		public function loadFile(filePath:String):void
		{
			var fileStr:String;
			fileStr = FileTools.readFile(filePath);
			book = new TaggingBook();
			book.initByString(fileStr);
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