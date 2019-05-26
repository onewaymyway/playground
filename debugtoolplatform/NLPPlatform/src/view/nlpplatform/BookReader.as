package view.nlpplatform 
{
	import laya.events.Event;
	import laya.events.Keyboard;
	import nlp.WordDicParser;
	import nlp.bookutils.BookParser;
	import nodetools.devices.FileTools;
	import ui.nlpplatform.BookReaderUI;
	
	/**
	 * ...
	 * @ww
	 */
	public class BookReader extends BookReaderUI 
	{
		public var book:BookParser;
		
		
		public function BookReader() 
		{
			Laya.stage.on(Event.KEY_DOWN, this, onKeyDown);
		}
		
		public function loadFile(filePath:String):void
		{
			var fileStr:String;
			fileStr = FileTools.readFile(filePath);
			book = BookParser.createByTxt(fileStr);
			showTxt(book.getCurLine());
			
		}
		public function showTxt(str:String):void
		{
			str = str || "no words";
			var words:Array;
			words = WordDicParser.I.cut(str);
			wordView.setWordList(words);
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