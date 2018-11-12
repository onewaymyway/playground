package platform.editzone {
	
	import configs.StyleConsts;
	import electrontools.menus.ContextMenu;
	import extendui.ui.TabEx;
	import laya.debug.tools.ClassTool;
	import laya.debug.tools.DisControlTool;
	import laya.display.Node;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Rectangle;
	import laya.ui.Box;
	import laya.ui.ISelect;
	import laya.ui.Image;
	import laya.utils.Browser;
	import laya.utils.Handler;
	import nodetools.devices.FileManager;
	import platform.interfaces.PlatformEvents;
	import platform.managers.EditRenderManager;
	import platform.managers.StateManager;
	import platform.tools.Notice;
	import ui.edit.EditZoneUI;
	
	/**编辑区分页管理器
	 * @author ww
	 */
	public class EditZone extends EditZoneUI {
		private static var _instance:EditZone;
		
		public static function get instance():EditZone {
			return _instance ? _instance : _instance = new EditZone();
		}
		
		//public var title:String = "UI";
		public var _currViewer:IEditViewer;
		private var _copyTemp:Array;
		
		private var _container:Box=new Box();
		
		private static const borderWidth:int=1;
		public static const topLen:int=25;
		public var tabEx:TabEx;
		public function EditZone() {
//			tabChildren = tabEnabled = false
			init();
			this.canClose=false;
			this.canMix=false;
			tabEx=tab as TabEx;
			_container.width=100;
			_container.height=100;
			_container.top=topLen;
			_container.bottom=0;
			_container.left=0;
			_container.right=0;
			_container.mouseEnabled=true;
			tab.labelColors=StyleConsts.LayoutTabTitleBtnColors;
			addChild(_container);
			on(Event.MOUSE_WHEEL,this,mouseWheel);
		}
		private function mouseWheel(e:Event):void
		{
			
			EditZone.instance.setScale(2*e.delta/100);
		
		}
		public function initListener():void
		{
			Notice.listen(PlatformEvents.CLOSE_PAGE, this, closePage);
			Notice.listen(PlatformEvents.OPEN_PAGE, this, openPage);
			Notice.listen(PlatformEvents.FOCUS_DESIGN, this, focusDesign);
			Notice.listen(PlatformEvents.FRESH_CURVIEW, this, refreshCurrView);
			
		}
		private function init():void {
			tab.on(Event.CHANGE, this,onTabChange);
//			tab.doubleClickEnabled = true;
			tab.on(Event.DOUBLE_CLICK,this, onTabDoubleClick);
			on(Event.ROLL_OVER, this,onRollOver);
			initTabMenu();
		}
		public  function hasPageOpen():Boolean
		{
			return tabEx.items.length>0;
		}
		private var _mScrollRec:Rectangle=new Rectangle();
		override protected function changeSize():void
		{
			super.changeSize();
		
			tabEx.maxLen=this.width;
			tabEx.updateUI();
			_mScrollRec.setTo(0,0,_container.width,_container.height);
			_container.scrollRect=_mScrollRec;
		}
		private function onRollOver(e:Event):void {

		}
		
		/**双击关闭页面*/
		protected function onTabDoubleClick(e:Event):void {
			if (_currViewer) {
				tryToClose(_currViewer);
			}
		}
		
		/**如果内容没有保存，提示保存*/
		public function tryToClose(uiViewer:IEditViewer):void {
			trace("tryToClose");
			if (uiViewer.hasChange) {
			
			} else {
				closeBack(uiViewer);
			}
		}
		
		/**保存后关闭*/
		private function saveBack(uiViewer:IEditViewer):void {
			uiViewer.save();
			closePage(uiViewer.pagePath);
		}
		
		/**处理页面关闭*/
		private function closeBack(uiViewer:IEditViewer):void {
			if(uiViewer==_currViewer)
			{
				clearPanelsData();
		    }
			closePage(uiViewer.pagePath);
		}
		
		private function clearPanelsData():void
		{

		}
		/**切换标签时刷新页面*/
		protected function onTabChange(e:Event):void {
			if (_currViewer) {
				_currViewer.removeSelf();
				_currViewer = null;
			}
			clearPanelsData();
			
			if (tab.selectedIndex != -1) {
				_currViewer = EditTab(tab.selection).uiViewer;
				if(_currViewer)
				{

					_container.addChild(_currViewer as Sprite);
					_currViewer.onActive();
				}
				

				
			}
		}
		
		private var _menu:ContextMenu;
		/**初始化右键菜单*/
		private function initTabMenu():void {
			var menu:ContextMenu = ContextMenu.createMenu("关闭", "关闭其他", "关闭全部");
			menu.on(Event.SELECT, this,onEmunSelect);
			//tab.contextMenu = menu;
			_menu=menu;
			tab.on(Event.RIGHT_MOUSE_DOWN, this,onTabRightMouseDown);
		}
		
		protected function onTabRightMouseDown(e:Event):void {
			
			for (var i:int = 0, n:int = tab.numChildren; i < n; i++) {
				var viewTab:EditTab = tab.getChildAt(i) as EditTab;
				if (viewTab && e.target.parent == viewTab)
				{
					if(tab.selectedIndex!=i)
					tab.selectedIndex = i;
					_menu.show();
					break;
				}
			}
		}
		
		protected function onEmunSelect(name:String):void {
			//var name:String = ContextMenuItem(e.target).name as String;
			switch (name) {
				case "关闭": 
					closePage(_currViewer.pagePath);
					break;
				case "关闭其他": 
					closeAll(null,null, tab.selectedIndex);
					break;
				case "关闭全部": 
					closeAll();
					break;
			}
		}
		

		/**关闭页面*/
		public function closePage(pagePath:String):Boolean {
			pagePath=FileManager.adptToCommonUrl(pagePath);
			StateManager.removeState(pagePath);
			StateManager.setChangeState(pagePath,false);
			var index:int = getTabIndex(pagePath);
			if (index != -1) {
				if(tab.items[index])
				{
					var viewTab:EditTab = tab.items[index] as EditTab;
					if(viewTab&&viewTab.uiViewer&&viewTab.uiViewer.clears!=null)
					{
						viewTab.uiViewer.clears();
					}
				}
				tab.delItem(tab.items[index]);
			
				onTabChange(null);
				if (tab.items.length == 0) {

				}
				return true;
			}
			return false;
		}
		
		/**获得页面索引*/
		private function getTabIndex(pagePath:String):int {
			for (var i:int = 0, n:int = tab.items.length; i < n; i++) {
				var viewTab:EditTab = tab.items[i] as EditTab;
				if (pagePath == viewTab.uiViewer.pagePath) {
					return i;
				}
			}
			return -1;
		}
		
		/**显示页面*/
		public function openPage(pagePath:String,title:String=null):void {
			
			pagePath=FileManager.adptToCommonUrl(pagePath);
			var index:int = getTabIndex(pagePath);
			var viewTab:EditTab;
			var viewer:IEditViewer;
			if (index == -1) {
				//if(FileTools.getExtensionName(pagePath)=="json")
				if(EditRenderManager.hasCustomRenderByPath(pagePath))
				{
					var customIFrameRender:IEditViewer;
					customIFrameRender=EditRenderManager.createCustomRenderByPath(pagePath);
					viewer=customIFrameRender;
					viewer.pagePath=pagePath;
					viewTab = new EditTab(viewer);
					index = tab.addItem(viewTab as ISelect);
				}else
				{
					return;
				}
				
			}
			_currViewer = viewer;
			tab.selectedIndex = index;
		}
		
		/**保存当前页面*/
		public function save():void {
			if (_currViewer != null) {
				_currViewer.save();
				
			}
		}

		/**刷新当前视图*/
		public function refreshCurrView():void {

			if (_currViewer != null) {
				stage.focus = _currViewer.design;
				//_currViewer.design.refresh();
				_currViewer.dealAction("refresh");
			}
		}
		
		/**恢复*/
		public function goBack():void {
//			trace("goBack");
			if (_currViewer != null) {
				//_currViewer.design.goBack();
				_currViewer.dealAction("goBack");
			}
		}
		
		/**重置*/
		public function goForward():void {
//			trace("goForward");
			if (_currViewer != null) {
				//_currViewer.design.goForward();
				_currViewer.dealAction("goForward");
			}
		}
		

		

		/**是否有变化*/
		public function get hasChange():Boolean {
			for each (var viewTab:EditTab in tab.items) {
				if (viewTab.uiViewer.design&&viewTab.uiViewer.design.hasChange) {
					return true;
				}
			}
			return false;
		}
		
		/**保存所有*/
		public function saveAll():void {
			for each (var viewTab:ViewTab in tab.items) {
				viewTab.uiViewer.save();
			}
		}
		
		public function hasNotSavedFile():Boolean
		{
			for (var j:int = 0; j < tab.items.length; j++) {
					var viewTab:EditTab = tab.items[j] as EditTab;
					if (viewTab.uiViewer.hasChange) {
						return true;
					
				}
			}
			return false;
	    }
		/**关闭所有*/
		public function closeAll(complete:Function = null,args:Array=null, exceptIndex:int = -1):void {
			for (var j:int = 0; j < tab.items.length; j++) {
				if (j != exceptIndex) {
					var viewTab:EditTab = tab.items[j] as EditTab;
					if (viewTab.uiViewer.hasChange) {

						return;
					}
				}
			}
			
			closeAllBack();
			
			function saveAllBack():void {
				saveAll();
				closeAllBack();
			}
			
			function closeAllBack():void {
				for (var i:int = tab.items.length - 1; i > -1; i--) {
					if (i != exceptIndex) {
						var view:IEditViewer = ViewTab(tab.items[i]).uiViewer;
						closePage(view.pagePath);
					}
				}
				if (complete != null) {
					complete.apply(null, args);
				}
			}
		}
		
		/**关闭当前页面*/
		public function closeCurrPage():void {
			onTabDoubleClick(null);
		}
		
		
		/**更改同层先后顺序*/
		public function sortComp(up:Boolean = true):void {
			if (_currViewer != null) {
				//_currViewer.design.sortComp(up);
				_currViewer.dealAction("sortComp",[up]);
			}
		}
		
		/**改变层*/
		public function moveLayer(up:Boolean = true):void {
			if (_currViewer != null) {
				//_currViewer.design.moveLayer(up);
				_currViewer.dealAction("moveLayer",[up]);
			}
		}
		
		/**打开的页面*/
		public function get openPages():Array {
			var arr:Array = [];
			for each (var viewTab:EditTab in tab.items) {
				arr.push(viewTab.uiViewer.pagePath);
			}
			return arr;
		}
		
		public function get currViewer():IEditViewer {
			return _currViewer;
		}
		
		/**获得ui视图*/
		public function getUIViewer(pagePath:String):IEditViewer {
			pagePath=FileManager.adptToCommonUrl(pagePath);
			for each (var viewTab:EditTab in tab.items) {
				if (viewTab.uiViewer.pagePath == pagePath) {
					return viewTab.uiViewer;
				}
			}
			return null;
		}
		
		/**设置焦点*/
		public function focusDesign():void {
			if (_currViewer != null) {
				if(!_currViewer is Sprite)
				{
					Laya.stage.focus=this;
				}
				_currViewer.focusDesign();
			}
		}
	}
}