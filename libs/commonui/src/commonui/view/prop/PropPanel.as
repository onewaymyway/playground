package commonui.view.prop {
	
	import commonui.ui.prop.PropPanelUI;
	import laya.debug.tools.ObjectTools;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.MathUtil;
	import laya.maths.Point;
	import laya.ui.Panel;
	import laya.ui.TextInput;
	import laya.utils.Handler;
	import laya.utils.Pool;
	import laya.utils.Utils;
	
	/**属性面板
	 * @author ww
	 */
	public class PropPanel extends PropPanelUI {
		private static var _instance:PropPanel;
		
		public static function get instance():PropPanel {
			return _instance ? _instance : _instance = new PropPanel();
		}
		//public var title:String = "属性";
		protected var _panel:Panel;
		protected var _panelMap:Object = {};
		
		
		public function PropPanel() {
			initStaticDatas();
			this.width = 400;
			this.height = 600;
			cancelBtn.on(Event.CLICK, this, onCloseBtn);
			clear();

		}
		
	
		private function onCloseBtn():void
		{
			hide();
		}
		
		public function hide():void
		{
			clear();
			this.removeSelf();

		}

		
		
		private var scrollValueDic:Object={};
		/**清理*/
		public function clear():void {
			//			_preParam.length=0;
			
			if (_panel) {
				recordPrePanelScroll();
				_panel.removeSelf();
				_panel=null;
			}
			node = null;
			
			typeLbl.text = "";
			
			propFootBox.removeSelf();
			
		}
		
		
		private var _preCompID:int;
		private var _preCompScrollValue:Number;
		private function recordPrePanelScroll():void
		{
			if (_panel) {
				scrollValueDic[_panel.contentHeight] = _panel.vScrollBar.value;
				if (node)
				{
					_preCompID = UIConfigManager.getNodeIDFromNode(node);
					_preCompScrollValue=_panel.vScrollBar.value;
				}else
				{
					_preCompID = -1;
				}
			}
		}
		
		private var node:*;
		public function initByObj(node:Object = null):void {
			
			clear();
			this.node = node;
			if (node)
			{
				UIConfigManager.loadConfigByNode(node,Handler.create(this,onUIConfigLoaded));
			}
	
		}
		
		public static function showPropPanel(node:Object):void
		{
			instance.initByObj(node);
			Laya.stage.addChild(instance);
			//instance.y = Laya.stage.height - instance.height;
			instance.x = Laya.stage.width - instance.width;
			instance.y=(Laya.stage.height - instance.height)*0.5;
			//TweenUtils.tweenToShow(instance);
		}
		
		private function onUIConfigLoaded():void
		{
			if (node) {
				var type:String = UIConfigManager.getTypeFromNode(node);
				//typeLbl.text = type != "UIView" ? type : type + ":" + xml.@source;
				typeLbl.text = type;
				typeLbl.color = PropStyleConst.PropPanelTitleColor;
				
				//显示图标
				//typeIcon.skin = UIConfigManager.getCompTreeIcon(type);
				
				
				
				
				_panel = createPanel(node);
				
				
				addChild(_panel);

				refreshGroupsPosition();
				var dataO:Object;
				dataO = node.comXml;
				var propO:Object;
				propO = dataO;
				
				
				//遍历设置值
				for (var i:int = 0, n:int = _panel.numChildren; i < n; i++) {
					var propGroup:PropGroup = _panel.getChildAt(i) as PropGroup;
					if (!(propGroup is PropGroup)) continue;
					if (propGroup.type != PropGroup.Node)
						propGroup.setValueD(node);
				}
				
				if(scrollValueDic[_panel.contentHeight])
				{
					_panel.vScrollBar.value=scrollValueDic[_panel.contentHeight];
				}else
				{
					if (propO && propO.compId == _preCompID)
					{
						_panel.vScrollBar.value = _preCompScrollValue;
					}
				}
			}
		}
		
		
		public function refresh():void {

		}
		
		
		private static function initStaticDatas():void {

		
		}
		
		public function clearPanelCache(type:String):void {
			delete _panelMap[type];
		}
		
		protected function createPanel(node:*):Panel {
			var type:String;
			type = UIConfigManager.getTypeFromNode(node);
			var cacheKey:String;
			cacheKey = type;
			var isSameType:Boolean=false;
			
			var panel:Panel = _panelMap[cacheKey];
			if (panel == null) {
				panel = new Panel();
				panel.mouseEnabled = true;
				panel.content.mouseEnabled = true;
				panel.vScrollBarSkin = PropStyleConst.PropPanelScrollBar;
				panel.left = panel.right = 0;
				panel.bottom = 2;
				panel.top = 50;
				var props:Object = UIConfigManager.getCompConfig(type);

				if (props) {
					//对属性进行分组
					var labels:String = props.groups;
					var groupLabels:Array = labels ? labels.split(",") : [];
					groupLabels = Sys.langArr(groupLabels);
					
					groupLabels.push(Sys.lang("其他"));
					
					
					var groups:Array = [];
					for (var j:int = 0, m:int = groupLabels.length; j < m; j++) {
						groups.push([]);
					}
					//其他属性索引ID
					var otherGroupIndex:int = groupLabels.indexOf(Sys.lang("其他"));
					
					var list:Array = props.prop;
					for (var i:int = 0, n:int = list.length; i < n; i++) {
						var prop:Object = list[i];
						var group:String = Sys.lang(prop.group);


						if (!Boolean(group)) {
							var index:int = otherGroupIndex;
						} else {
							index = groupLabels.indexOf(group);
							if (index == -1) {
								index = otherGroupIndex;
							}
						}
						groups[index].push(prop);
					}
					
					//添加renderType属性
					index = groupLabels.indexOf(Sys.lang("公用"));
					if (index == -1) {
						index = otherGroupIndex;
					}
					
					//对其他属性按照名称进行排序
					var otherGroup:Array = groups[otherGroupIndex];
					
					otherGroup.sort(sortByNameHH);
					//创建属性组
					for (var k:int = 0, t:int = groups.length; k < t; k++) {
						var arr:Array = groups[k];
						if (arr.length > 0) {
							var propGroup:PropGroup = new PropGroup(groupLabels[k], arr);
							propGroup.left = 0;
							propGroup.right = 1;
							propGroup.on(Event.RESIZE, this, freshPositionsLater);
							if(groupLabels[k]==Sys.lang("其他"))
							{
								propGroup.setGroupState(false);
							}
							panel.addChild(propGroup);
						}
					}
				}
				_panelMap[cacheKey] = panel;
			}
			return panel;
		}
		
		private static function sortByNameHH(obj0:Object, obj1:Object):int {
			return obj0.p.name < obj1.p.name ? -1 : 1;
		}
		
		public static const spaceY:Number = 10;
		public static function refreshPanelChilds(panel:Panel,propFootBox:Sprite=null):int
		{
			var y:Number = 0;
			if(!panel) return 0;
			for (var i:int = 0, n:int = panel.numChildren; i < n; i++) {
				var propGroup:PropGroup = panel.getChildAt(i) as PropGroup;
				if (propGroup == propFootBox) continue;
				if (propGroup) {
					propGroup.y = y;
					y = y + propGroup.height + spaceY;
				}
			}
			if(propFootBox)
			{
				propFootBox.y = y;
			}
			
			panel.refresh();
			return y;
		}
		
		public function freshPositionsLater():void
		{
			Laya.timer.callLater(this, refreshGroupsPosition);
		}
		
		/**刷新属性面板位置*/
		public function refreshGroupsPosition():void {
			refreshPanelChilds(_panel, propFootBox);
		}
	}
}