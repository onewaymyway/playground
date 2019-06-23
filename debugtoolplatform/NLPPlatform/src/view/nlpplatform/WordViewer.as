package view.nlpplatform 
{
	import commontools.EventTools;
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
			this.on(Event.CLICK, this, onMouseDown);
		}
		
		private function onMouseDown(e:Event):void
		{
			BookReaderState.onWordMouseDown(this);
		}
		public var selectColor:String="#ff0000";
		private var _isSelect:Boolean = false;
		public function set isSelected(value:Boolean):void
		{
			_isSelect = value;
			if (value)
			{
				txt.borderColor = selectColor;
			}else
			{
				txt.borderColor = null;
			}
		}
		
		public function reset():void
		{
			isSelected = false;
		}
		
		public function get isSelected():Boolean
		{
			return _isSelect;
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
					EventTools.sendEventOnTree(this, "wordevent",["打散",this]);
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