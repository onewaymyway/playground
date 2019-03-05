package view 
{
	import nlp.cutwords.WordPiece;
	import ui.wordparser.WordViewerUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class WordViewer extends WordViewerUI 
	{
		
		public function WordViewer() 
		{
			
		}
		
		public var dataO:WordPiece;
		public function getWordTypeStr(word:WordPiece):String
		{
			if (!word.typeO) return "unknow";
			return word.typeO.typecns.join(":");
		}
		public function setData(dataO:WordPiece):void
		{
			this.dataO = dataO;
			txt.text = dataO.word;
			txt.text = dataO.word+"("+getWordTypeStr(dataO)+")";
			this.width = txt.width;
		}
		
	}

}