package view.nlpplatform 
{
	/**
	 * ...
	 * @author ww
	 */
	public class BookReaderState 
	{
		public static const StartColor:String = "#ff0000";
		public static const EndColor:String = "#ffff00";
		public function BookReaderState() 
		{
			
		}
		
		private static var _startWord:WordViewer;
		private static var _endWord:WordViewer;
		
		static public function get startWord():WordViewer 
		{
			return _startWord;
		}
		
		static public function set startWord(value:WordViewer):void 
		{
			if (_startWord)
			{
				_startWord.isSelected = false;
			}
			_startWord = value;
			if (value)
			{
				value.selectColor = StartColor;
				value.isSelected = true;
			}
		}
		
		static public function get endWord():WordViewer 
		{
			return _endWord;
		}
		
		static public function set endWord(value:WordViewer):void 
		{
			if (_endWord)
			{
				_endWord.isSelected = false;
			}
			_endWord = value;
			if (value)
			{
				value.selectColor = EndColor;
				value.isSelected = true;
			}
		}
		
		public static function clearSelect():void
		{
			startWord = null;
			endWord = null;
		}
		
		public static function onWordMouseDown(word:WordViewer):void
		{
			var tmpWord:WordViewer;
			if (word == _startWord)
			{
				startWord = null;
				if (_endWord)
				{
					
					tmpWord = _endWord;
					endWord = null;
					startWord = tmpWord;
				}else
				{
					
				}
				
				
			}else
			if (word == _endWord)
			{
				tmpWord = _endWord;
				endWord = null;
				startWord = tmpWord;
			}else
			{
				if (_startWord)
				{
					endWord = word;
				}else
				{
					startWord = word;
				}
			}
		}
	}

}