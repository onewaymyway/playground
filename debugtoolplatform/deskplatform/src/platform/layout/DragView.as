package platform.layout 
{
	import laya.editor.comonents.LayoutTab;
	import laya.ui.View;
	
	/**
	 * 可拖动布局框的基类
	 * @author ww
	 */
	public class DragView extends View 
	{
		
		public function DragView() 
		{
			super();
		}
		public var minWidth:Number = 50;
		public var minHeight:Number = 50;
		public var defaultWidth:Number = 100;
		public var defaultHeight:Number = 100;
		
		/**
		 * 标题 
		 */
		public var title:String = "";
		public var helpUrl:String="";
		/**
		 * 是否可关闭 
		 */
		public var canClose:Boolean=true;
		/**
		 * 是否可与其他面板共用布局框 
		 */
		public var canMix:Boolean=true;
		
		public var freeSize:Boolean=false;
		
		public var layoutTab:LayoutTab;
		
	}

}