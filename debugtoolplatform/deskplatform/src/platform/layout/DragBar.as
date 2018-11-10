package platform.layout {
	import laya.display.Graphics;
	import laya.events.Event;
	import laya.ui.Component;
	import laya.ui.Image;
	import platform.interfaces.PlatformVars;
	import platform.managers.CursorManager;

	
	/**拖动条
	 * @author ww
	 */
	public class DragBar extends Component {
		private var _bitmap:Image=new Image();
		private var _map:Object = {"R": "WE", "L": "WE", "T": "NS", "B": "NS", "BL": "NESW", "BR": "NWSE"}
		
		private var _cursorType:String;
		public function get cusorType():String
		{
			return _cursorType;
		}
		public function DragBar(mouseType:String = "R") {
			switch(mouseType)
			{
				case "R":
					_cursorType = CursorManager.HResize;
					break;
				case "T":
					_cursorType = CursorManager.VResize;
					break;
				default:
					_cursorType = CursorManager.Auto;
			}
			on(Event.MOUSE_OVER, this,onRollOver);
			on(Event.MOUSE_OUT, this, onRollOut);
			this.mouseEnabled = true;

			Laya.stage.on(Event.MOUSE_OUT, this, onRollOut);
			on(Event.DRAG_START, this, dragingBegin);
			on(Event.DRAG_END, this, dragingEnd);
		}
		private var isDraging:Boolean = false;
		private function dragingBegin(e:Event):void
		{
//			trace("draging begin");
			isDraging = true;
			PlatformVars.isDragingLayout=true;
			LayoutRecManager.containerBox.mouseEnabled=false;
			onRollOver(null);
		}
		private function dragingEnd(e:Event):void
		{
//			trace("dragingEnd");
			isDraging = false;
			CursorManager.setType(CursorManager.Auto);
			PlatformVars.isDragingLayout=false;
			LayoutRecManager.containerBox.mouseEnabled=true;
		}
		private function onStageMouseLeave(e:Event):void {
			onRollOut();
		}
		
		
		private function onRollOut(e:Event=null):void {
			if (isDraging) return;
			CursorManager.setType(CursorManager.Auto);
		}
		
		private function onRollOver(e:Event):void {
			CursorManager.setType(_cursorType);

		}
		
		//以下代码调试用
		//override protected function changeSize():void {
			//super.changeSize();
			////cacheAsBitmap = false;
			////var g:Graphics = graphics;
			////g.clear();
			////g.fillRect(0, 0, width, height, "#111111");
			////cacheAsBitmap = true;
		//}
	}
}