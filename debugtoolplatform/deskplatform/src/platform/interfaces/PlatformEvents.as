package platform.interfaces 
{
	/**
	 * ...
	 * @author ww
	 */
	public class PlatformEvents 
	{
		
		public function PlatformEvents() 
		{
			
		}
		/**
		 * 渲染器数据改变
		 */
		public static const PAGE_CHANGED:String = "pageChanged";
		/**
		 * 关闭标签页 [pagePath:String]
		 */
		public static const CLOSE_PAGE:String="closePage";
		/**
		 * 打开标签页 [pagePath:String]
		 */
		public static const OPEN_PAGE:String="openPAGE";
		
		/**
		 * 将design面板设为焦点 
		 */
		public static const FOCUS_DESIGN:String="Focus_design";
		
		
		/**
		 * 通知design数据已经变化
		 */
		public static const DESIGN_DATACHANGED:String = "DESIGN_DATACHANGED";
		
		/**
		 * 刷新当前打开页面 
		 */
		public static const FRESH_CURVIEW:String="FRESH_CurView";
		
		/**
		 * 显示某个标签页 
		 */
		public static const SHOW_LAYOUTTAB_BY_NAME:String = "SHOW_LayoutTab_By_Name";
		
		public static const WebViewReady:String="WebViewReady";
	}

}