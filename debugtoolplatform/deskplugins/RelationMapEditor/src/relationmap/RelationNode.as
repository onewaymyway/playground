package relationmap 
{
	import commontools.EventTools;
	import laya.events.Event;
	import ui.relationmap.RelationNodeUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class RelationNode extends RelationNodeUI 
	{
		
		public function RelationNode() 
		{
			this.on(Event.MOUSE_DOWN, this, onMouseDown);
			this.on(Event.CLICK, this, onMouseClick);
			this.on(Event.DRAG_END, this, onEndDrag);
		}
		
		override protected function renderByData():void 
		{
			super.renderByData();
			this.pos(_dataO.props.x, _dataO.props.y);
		}
		
		private function onMouseClick():void
		{
			EventTools.sendEventOnTree(this, "ItemClicked",this);
		}
		
		private function onMouseDown():void
		{
			this.startDrag();
		}
		
		private function onEndDrag():void
		{
			_dataO.props.x = this.x;
			_dataO.props.y = this.y;
		}
	}

}