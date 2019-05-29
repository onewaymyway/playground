package view.nlpplatform 
{
	import laya.debug.uicomps.ContextMenu;
	import laya.display.Sprite;
	import laya.events.Event;
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
			this.on(Event.RIGHT_CLICK, this, onRightClick);
		}
		
		private function onRightClick():void
		{
			var menu:ContextMenu;
			menu = ContextMenu.createMenuByArray(["打散", "属性"]);
			menu.on(Event.SELECT, this, onMenuSelect);
			menu.show();
		}
		
		private function onMenuSelect(dataO:Object):void
		{
			var label:String;
			label = dataO.target.data;
			switch(label)
			{
				case "打散":
					break;
				case "属性":
					WordProp.showWordProp(this);
					break;
			}
		}
		public var dataO:TaggingWord;
		public var id:int;

		
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
			
			id = dataO.id;
			
		}
		
		
		
	}

}