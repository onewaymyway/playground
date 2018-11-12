package platform.editzone {
	import configs.StyleConsts;
	import laya.editor.view.UIPanel;
	import laya.events.Event;
	import laya.ui.Component;
	import laya.utils.Handler;
	import nodetools.devices.FileManager;
	import nodetools.devices.SystemSetting;
	import platform.interfaces.PlatformEvents;
	import platform.tools.ObjectUtils;
	import ui.edit.EditTabUI;
	
	/**视图标签
	 * @author ww
	 */
	public class EditTab extends EditTabUI {
		private var _uiViewer:IEditViewer;
		
		public function EditTab(viewer:IEditViewer,tip:String=null) {
			_uiViewer = viewer;
			var comp:Component;
			comp=viewer as Component;
			comp.left = comp.right = comp.bottom = 0;
			comp.top = 0;
			if (viewer.useDesignChangeEvent)
			{
				viewer.design.on(Event.CHANGE,this, onDesignChange);
			}else
			{
				Laya.stage.on(PlatformEvents.PAGE_CHANGED, this, onDesignChange);
			}
			
			onDesignChange(null);
			close.on(Event.CLICK, this, onCloseClick);
			btn.labelAlign = "left";
			btn.labelPadding = "-2,5,0,5"
			btn.labelColors=StyleConsts.LayoutTabTitleBtnColors;
			
			toolTip = tip?tip:FileManager.getRelativePath(SystemSetting.assetsPath, viewer.pagePath);
		}
		
		private function onCloseClick(e:Event):void {
			EditZone.instance.tryToClose(_uiViewer);
			//e.stopPropagation();
		}
		
		public function onDesignChange(e:Event):void {
			var len:Number = ObjectUtils.getTextField(null, "*" + _uiViewer.title).width + 25;
			btn.width = len;
			close.x = len - close.displayWidth-8;
			btn.label = (_uiViewer.hasChange ? "*" : "") + _uiViewer.title;
		}
		
		public override function get width():Number
		{
			return btn.width;
		}
		/**点击处理器(无默认参数)*/
		public function get clickHandler():Handler {
			return btn.clickHandler;
		}
		
		public function set clickHandler(value:Handler):void {
			btn.clickHandler = value;
		}
		
		/**是否是选择状态*/
		public function get selected():Boolean {
			return btn.selected;
		}
		
		public function set selected(value:Boolean):void {
			btn.selected = value;
		}
		
		public function get uiViewer():IEditViewer {
			return _uiViewer;
		}
	}
}