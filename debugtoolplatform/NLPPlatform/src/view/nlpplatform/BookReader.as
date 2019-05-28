package view.nlpplatform 
{
	import laya.events.Event;
	import laya.events.Keyboard;
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
		
		
		public function BookReader() 
		{
			Laya.stage.on(Event.KEY_DOWN, this, onKeyDown);
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