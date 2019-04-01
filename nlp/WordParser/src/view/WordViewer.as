package view 
{
	import laya.display.Sprite;
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
		
		private function centerItem(item:Sprite):void
		{
			item.x = (this.width - item.width) * 0.5;
		}
		public function setData(dataO:WordPiece):void
		{
			this.dataO = dataO;
			txt.text = dataO.word;
			//txt.text = dataO.word + "(" + getWordTypeStr(dataO) + ")";
			typeTxt.text = "(" + getWordTypeStr(dataO) + ")";
			var maxWidth:int;
			maxWidth = Math.max(txt.width, typeTxt.width);
			this.width = maxWidth;
			centerItem(txt);
			centerItem(typeTxt);
			
		}
		
	}

}