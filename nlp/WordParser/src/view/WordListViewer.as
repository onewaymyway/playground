package view 
{
	import commonlayout.WordLayout;
	import laya.events.Event;
	import laya.utils.Pool;
	import ui.wordparser.WordListViewerUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class WordListViewer extends WordListViewerUI 
	{
		public var layouter:WordLayout;
		public function WordListViewer() 
		{
			layouter = new WordLayout();
			container.on(Event.RESIZE, this, freshUI);
		}
		
		private var wList:Array;
		private var wordItemList:Array;
		private function clearPre():void
		{
			if (!wordItemList) return;
			var i:int, len:int;
			len = wordItemList.length;
			var tItem:WordViewer;
			for (i = 0; i < len; i++)
			{
				tItem = wordItemList[i];
				tItem.removeSelf();
				Pool.recover("WordViewer", tItem);
			}
			wordItemList.length = 0;
		}
		public function setWordList(wList:Array):void
		{
			this.wList = wList;
			clearPre();
			wordItemList = [];
			var i:int, len:int;
			var tWord:WordViewer;
			len = wList.length;
			for (i = 0; i < len; i++)
			{
				tWord = Pool.getItemByClass("WordViewer", WordViewer);
				tWord.setData(wList[i]);
				wordItemList.push(tWord);
				container.addChild(tWord);
			}
			freshUI();
			
		}
		
		private function freshUI():void
		{
			if (!wordItemList) return;
			layouter.layout(wordItemList, container.width, container.height);
		}
		
	}

}