package relationmap 
{
	import laya.display.Graphics;
	import laya.renders.RenderContext;
	import ui.relationmap.RelationLineUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class RelationLine extends RelationLineUI 
	{
		
		public function RelationLine() 
		{
			input.isAutoSize = true;
			setUpTextInput(input, "label");
		}
		
		private var propO:Object;
		override protected function renderByData():void 
		{
			super.renderByData();
			
			propO = _dataO.props;
			var startNode:RelationNode;
			startNode = itemDic.getItemByID(_dataO.start);
			if (startNode)
			{
				propO.startX = startNode.x;
				propO.startY = startNode.y;
			}
			
			var endNode:RelationNode;
			endNode = itemDic.getItemByID(_dataO.end);
			if (endNode)
			{
				propO.endX = endNode.x;
				propO.endY = endNode.y;
			}
			
			var mX:Number, mY:Number;
			mX = (propO.startX + propO.endX) * 0.5;
			mY = (propO.startY + propO.endY) * 0.5;
			mX = mX || 0;
			mY = mY || 0;
			startPoint.visible = false;
			endPoint.visible = false;
			
			input.text = propO.label || "";
			
			
			updateMySize();
			
			this.pos(mX, mY);
		}
		
		override protected function updateMySize():void 
		{
			this.width = input.width;
			this.pivot(this.width*0.5,this.height*0.5);
		}
		
		public function drawLineToGraphics(g:Graphics):void
		{
			var startNode:RelationNode;
			startNode = itemDic.getItemByID(propO.start);	
			var endNode:RelationNode;
			endNode = itemDic.getItemByID(propO.end);
			
			propO.startX = startNode.x;
			propO.startY = startNode.y;
			
			propO.endX = endNode.x;
			propO.endY = endNode.y;
			
			var mX:Number, mY:Number;
			mX = (propO.startX + propO.endX) * 0.5;
			mY = (propO.startY + propO.endY) * 0.5;
			mX = mX || 0;
			mY = mY || 0;
			
			this.pos(mX, mY);
			
			if (startNode && endNode)
			{
				g.drawLine(startNode.x, startNode.y, endNode.x, endNode.y,"#ff0000");
			}
		}
	}

}