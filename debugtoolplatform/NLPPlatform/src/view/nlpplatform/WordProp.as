package view.nlpplatform 
{
	import commontools.EventTools;
	import laya.events.Event;
	import nlp.WordDicParser;
	import nlp.dictools.TypeDefine;
	import nlp.tagging.TaggingWord;
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
			wordType.labels = TypeDefine.SelectTypeList.join(",");
		}
		
		public var _dataO:WordViewer;
		public var wordO:TaggingWord;
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
		
		private function saveInfo():void
		{
			wordO.type = wordType.selectedLabel;
			EventTools.sendEventOnTree(_dataO, "wordchanged");
		}
		private function onAction(type:String):void
		{
			//debugger;
			switch(type)
			{
				case "sure":
					saveInfo();
					this.close();
					break;
				case "selectMeaning":
					break;
				case "close":
					saveInfo();
					this.close();
					break;
			}
		}
	}

}