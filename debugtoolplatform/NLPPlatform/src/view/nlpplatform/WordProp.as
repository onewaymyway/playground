package view.nlpplatform 
{
	import laya.events.Event;
	import nlp.WordDicParser;
	import ui.nlpplatform.WordPropUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class WordProp extends WordPropUI 
	{
		private static var _i:WordProp;
		public static function get I():WordProp
		{
			if (!_i) _i = new WordProp();
			return _i;
		}
		public function WordProp() 
		{
			sureBtn.on(Event.CLICK, this, onAction, ["sure"]);
			selectMeaningBtn.on(Event.CLICK, this, onAction, ["selectMeaning"]);
			closeBtn.on(Event.CLICK, this, onAction, ["close"]);
		}
		
		public var _dataO:Object;
		public var wordO:Object;
		public function setData(dataO:Object):void
		{
			_dataO = dataO;
			
			wordO = dataO.dataO;
			wordTxt.text = wordO.word;
			wordType.selectedLabel = wordO.type;
			meaningInput.text = wordO.meaning || "";
			var wordData:Object;
			wordData = WordDicParser.I.cutter.trie.getWord(wordO.word);
			trace("word:",wordData);
		}
		
		public static function showWordProp(dataO:Object):void
		{
			I.setData(dataO);
			I.popup();
		}
		
		private function onAction(type:String):void
		{
			//debugger;
			switch(type)
			{
				case "sure":
					this.close();
					break;
				case "selectMeaning":
					break;
				case "close":
					this.close();
					break;
			}
		}
	}

}