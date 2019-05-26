package view.nlpplatform 
{
	import laya.display.Sprite;
	import nlp.cutwords.WordPiece;
	import nlp.tagging.TaggingWord;
	import ui.nlpplatform.WordViewerUI;

	
	/**
	 * ...
	 * @author ww
	 */
	public class WordViewer extends WordViewerUI 
	{
		
		public function WordViewer() 
		{
			
		}
		
		public var dataO:TaggingWord;

		
		private function centerItem(item:Sprite):void
		{
			item.x = (this.width - item.width) * 0.5;
		}
		public function setData(dataO:TaggingWord):void
		{
			this.dataO = dataO;
			txt.text = dataO.word;
			//txt.text = dataO.word + "(" + getWordTypeStr(dataO) + ")";
			typeTxt.text = "(" + dataO.type+ ")";
			var maxWidth:int;
			maxWidth = Math.max(txt.width, typeTxt.width);
			this.width = maxWidth;
			centerItem(txt);
			centerItem(typeTxt);
			
		}
		
	}

}