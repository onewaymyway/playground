package view 
{
	import ui.wordparser.WordForTreeUI;
	/**
	 * ...
	 * @author ww
	 */
	public class WordForTree extends WordForTreeUI
	{
		
		public function WordForTree() 
		{
			
		}
		
		public var dataO:*;
		public function setData(dataO:*):void
		{
			this.dataO = dataO;
			txt.text = dataO.word;
			this.width = txt.width;
		}
	}

}