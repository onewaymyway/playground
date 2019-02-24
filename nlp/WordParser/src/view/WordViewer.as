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
		public function setData(dataO:WordPiece):void
		{
			this.dataO = dataO;
			txt.text = dataO.word;
			this.width = txt.width;
		}
		
	}

}