package view 
{
	import commonlayout.WordLayout;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.utils.Pool;
	import nlp.conll.ConllRelation;
	import nlp.conll.ConllTree;
	import ui.wordparser.WordTreeViewerUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class WordTreeViewer extends WordTreeViewerUI 
	{
		public var layouter:WordLayout;
		private var relationLayer:Sprite;
		public function WordTreeViewer() 
		{
			layouter = new WordLayout();
			relationLayer = new Sprite();
			
			container.on(Event.RESIZE, this, freshUI);
		}
		
		private var wList:Array;
		private var wordItemList:Array;
		private function clearPre():void
		{
			if (!wordItemList) return;
			var i:int, len:int;
			len = wordItemList.length;
			var tItem:WordForTree;
			for (i = 0; i < len; i++)
			{
				tItem = wordItemList[i];
				tItem.removeSelf();
				Pool.recover("WordForTree", tItem);
			}
			wordItemList.length = 0;
		}
		
		private var tree:ConllTree;
		public function setTree(tree:ConllTree):void
		{
			this.tree = tree;
			tree.buildRelation();
			setWordList(tree.wordList);
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
				tWord = Pool.getItemByClass("WordForTree", WordForTree);
				tWord.setData(wList[i]);
				wordItemList.push(tWord);
				container.addChild(tWord);
			}
			freshUI();
			
		}
		
		private function freshUI():void
		{
			relationLayer.graphics.clear();
			container.addChild(relationLayer);
			if (!wordItemList) return;
			layouter.layout(wordItemList, container.width, container.height);
			drawRelations();
		}
		private var tYDic:Object;
		private function drawRelations():void
		{
			tYDic = { };
			var relations:Array;
			relations = tree.relations;
			var i:int, len:int;
			len = relations.length;
			for (i = 0; i < len; i++)
			{
				drawRelation(relations[i]);
			}
		}
		
		private function getYPos(id:int):Number
		{
			if (!tYDic[id])
			{
				tYDic[id] = 20;
			}
			return tYDic[id];
		}
		
		private function setYPos(id:int, value:int):void
		{
			tYDic[id]=value;
		}
		private function drawRelation(relation:ConllRelation):void
		{
			var start:WordForTree;
			var end:WordForTree;
			start = wordItemList[relation.start];
			end = wordItemList[relation.end];
			if (!start || !end) return;
			
			var pos:int;
			pos = Math.max(getYPos(relation.start),getYPos(relation.end));
			var startX:Number;
			startX = start.x + 0.5 * start.width;
			var endX:Number;
			endX = end.x + 0.5 * end.width;
			var tY:Number;
			tY = start.y + start.height + pos + 20;
			var eY:Number;
			eY = start.y + start.height + 5;
			
			setYPos(relation.start, pos + 20);
			setYPos(relation.end, pos + 20);
			
			relationLayer.graphics.drawLine(startX, tY, startX, eY, "#ff0000");
			relationLayer.graphics.drawLine(endX, tY, endX, eY, "#ff0000");
			relationLayer.graphics.drawLine(startX, tY, endX, tY, "#ff0000");
			
			relationLayer.graphics.fillText(relation.type, (startX + endX) * 0.5, tY, null, "#ff0000", "center");
			
			relationLayer.graphics.drawCircle(endX, tY, 2, "#00ff00");
		}
		
	}

}