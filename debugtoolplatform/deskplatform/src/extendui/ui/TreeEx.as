package extendui.ui 
{
	import electrontools.drags.DragEvent;
	import electrontools.drags.DragManager;
	import extendui.FocusManager;
	import extendui.layout.RelativePos;
	import laya.events.Event;
	import laya.ui.Box;
	import laya.utils.Handler;
	
	/**
	 * ...
	 * @author ww
	 */
	public class TreeEx extends NodeTree 
	{
		
		public function TreeEx() 
		{
			super();
			enableDragingAuto();
			this.on(Event.MOUSE_OUT,this,stopDragUpdate);
			this.on(Event.MOUSE_UP,this,stopDragUpdate);
		}
		public function get mList():ListEx
		{
			return _list as ListEx;
		}
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			//super.createChildren();
			addChild(_list = new ListEx());
			_list.renderHandler = Handler.create(this, renderItem, null, false);
			_list.repeatX = 1;
			_list.on(Event.CHANGE, this, onListChange);
		}
		public function enableDragingAuto():void
		{
			this.on(DragEvent.Draging_Hit,this,onDragHit);
	    }
		private function onDragHit():void
		{
			if (!DragManager.isDraging) return;
			
			if (DragManager.getDragType() == "LayoutRec" || DragManager.getDragType() == "LayoutTab") return;
			var mouseY:Number;
			mouseY=this.mouseY;
			if(!scrollBar) return;
			startDragUpdate();
		}
		
		private var _isDragUpdate:Boolean=false;
		private function stopDragUpdate():void
		{
			_isDragUpdate=false;
			Laya.timer.clear(this,_dragUpdateLoop);
		}
		private function startDragUpdate():void
		{
			if(_isDragUpdate) return;
			_isDragUpdate=true;
			Laya.timer.loop(50,this,_dragUpdateLoop);
		}

		private function _dragUpdateLoop():void
		{
			if(!scrollBar) return;
			var mouseY:Number;
			mouseY=this.mouseY;
			if(mouseY<20)
			{
				scrollBar.value-=10;	
				return;
			}
			if(mouseY>this.height-20)
			{
				scrollBar.value+=10;
				return;
			}
			stopDragUpdate();
		}
		/**
		 * 更新项列表，显示指定键名的数据项。
		 * @param	key 键名。
		 */
		override public function filter(key:String):void {
			if (Boolean(key)) {
				var result:Array = [];
				__getFilterSource(_source, result, key);
				_list.array = result;
			} else {
				_list.array = getArray();
			}
		}
		
		/**
		 * @private
		 * 获取数据源中指定键名的值。
		 */
		private function __getFilterSource(array:Array, result:Array, key:String):void {
			key = key.toLocaleLowerCase();
			for each (var item:Object in array) {
				if ((item.compId||!item.isDirectory) && (String(item.label).toLowerCase().indexOf(key) > -1||(item.searchKey&&item.searchKey.toLowerCase().indexOf(key)))) {
					item.x = 0;
					if(result.indexOf(item)<0)
					result.push(item);
				}
				if (item.child && item.child.length > 0) {
					__getFilterSource(item.child, result, key);
				}
			}
		}
		
		public static function onItemCellMouseOver(index:int,cell:Box,tree:TreeEx,filterFun:Function=null):void
		{
			//			return;
			FocusManager.clearFocus();
			if (tree.mList.isIDSelected(index)) {
//				FocusManager.clearFocus();
				return;
			}
			if (!DragManager.isDraging) return;
			if(filterFun!=null)
			{
				if(!filterFun(DragManager.getDragData())) return;
			}
			var dataO:Object;
			dataO=cell.dataSource;
			if(dataO.isDirectory)
			{
				FocusManager.showFocus(cell, 1, true);
			}else
			{
				var type:String = RelativePos.getDisMouseRelativePos(cell, 0.2);
				var target:Box=cell;
				
				switch (type) {
					
					case RelativePos.Up: 
					case RelativePos.Down:
						
						FocusManager.showBorder(target, type, true, null, 1);
						
						break;
					case RelativePos.Center: 
					case RelativePos.Left: 
					case RelativePos.Right: 
						FocusManager.showBorder(target, RelativePos.Down, true, null, 1);
						
						break;
				}
				var parentIndex:int;
				parentIndex=tree.getParentIndex(dataO);
				if(parentIndex>0)
				{
					var parentCell:Box;
					parentCell=tree.list.getCell(parentIndex);
					if(parentCell)
					{
						FocusManager.showFocus(parentCell, 1,false);
					}
				}
			}
			
		}
		
	}

}