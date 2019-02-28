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
			this.graphics.clear();
			this.graphics.fillText(dataO.cpostag, this.width * 0.5, -10, null, "#ff0000", "center");
		}
		
		public function getCenterX():Number
		{
			return this.x + 0.5 * this.width;
		}
		public function getPos(i:int):Number
		{
			var tValue:Number;
			tValue = getCenterX();
			if (!this.dataO.refers) return tValue;
			var refres:Array;
			refres = this.dataO.refers;
			tValue = tValue-(refres.length* 0.5 - refres.indexOf(i) ) * 4;
			return tValue;
		}
	}

}