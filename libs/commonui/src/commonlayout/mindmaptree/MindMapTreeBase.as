package commonlayout.mindmaptree 
{
	import laya.debug.tools.ClassTool;
	import laya.ui.View;
	import laya.utils.ClassUtils;
	import laya.utils.Pool;
	
	/**
	 * ...
	 * @author ww
	 */
	public class MindMapTreeBase extends View implements IMindMapTreeItem
	{
		protected var _dataO:Object;
		protected var _childNodes:Array;
		public function MindMapTreeBase() 
		{
			reset();
		}
		
		public function setLayoutPos(x:Number, y:Number):void
		{
			pos(x, y);
		}
		
		public function recover():void
		{
			reset();
			Pool.recover(ClassTool.getClassName(this),this);
		}
		
		public function get childNodes():Array
		{
			return _childNodes;
		}
		
		public function reset():void
		{
			_childNodes = [];
			pos(0, 0);
		}
		
		public function setData(dataO:Object):void
		{
			_dataO = dataO;
			renderByData();
		}
		
		protected function renderByData():void
		{
			
		}
		
		public function getData():Object
		{
			return _dataO;
		}
	}

}