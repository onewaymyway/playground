package commonui.view.prop {
	import commonui.ui.prop.PropGroupUI;
	import laya.debug.tools.ClassTool;
	import laya.debug.tools.ObjectTools;
	import laya.debug.tools.layout.LayoutFuns;
	import laya.debug.tools.layout.Layouter;
	import laya.display.Input;
	import laya.display.Sprite;
	import laya.display.Text;
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.CheckBox;
	import laya.ui.ColorPicker;
	import laya.ui.ComboBox;
	import laya.ui.HSlider;
	import laya.ui.Label;
	import laya.ui.Slider;
	import laya.ui.TextArea;
	import laya.ui.TextInput;
	import laya.utils.Ease;
	import laya.utils.Handler;
	
	
	/**属性组
	 * @author ww
	 */
	public class PropGroup extends PropGroupUI {
		public static const Prop:String = "Prop";
		public static const Node:String = "Node";
		protected var _props:Array = [];
		protected var _isSettingValue:Boolean;
		public var type:String;
		public var layouter:Layouter;
		protected var _items:Array;
		public const ItemHeight:int = 60;
		public const ItemD:int = 5;
		private var nameTypeO:Object = {};
		private var _nameList:Array = [];
		public var labelDic:Object = {};
		public var labelInitLabel:Object = {};
		
		protected var _enableClickSwitch:Boolean = true;
		
		public function setClickSwitchEnable(value:Boolean):void
		{
			_enableClickSwitch=value;
			arrowClip.visible=value;
			if(value)
			{
				groupLabl.x=19;
				
			}else
			{
				groupLabl.x=x1;
			}
		}
		
		public function setGroupState(show:Boolean):void
		{
			if(show)
			{
				addChild(groupBox);
				arrowClip.index = 1;
			}else
			{
				groupBox.removeSelf();
				arrowClip.index = 0;
			}
			
			event(Event.RESIZE);
		}
		
		public function PropGroup(name:String = null, props:Array = null) {
			groupBar.on(Event.MOUSE_DOWN, this, onGroupBarClick);
			groupBox.y+=ItemD;
			groupBox.space=ItemD;
			if (!name) return;
			createBy(name, props);
		}
		public var groupData:Object;
		public var node:Object;
		private var _nameItemDic:Object={};

		protected function getItemByName(name:String):*
		{
			return _nameItemDic[name];
		}

		private var isSettingValue:Boolean = false;
		
		public static const LabelX:Number = 19;
		public function createBy(name:String, props:Array,groupData:Object = null):void {
			this.groupData = groupData;

			_props.length = 0;
			groupLabl.text = name;
			groupLabl.color = PropStyleConst.TreeFolderColor;
			groupLabl.bold = true;
			groupBox.removeChildren();
			arrowClip.index = 1;
			_items = [];

			var tY:Number;
			for (var i:int = 0, n:int = props.length; i < n; i++) {

				var prop:Object = PropUtils.getDisplayPropObject(props[i]);		
				
				tY = i * ItemHeight + ItemD;
				if (prop.type == "group") {
					createGroupProp(props[i], tY);
				} else {
					createPropUI(prop,DefaultLabelWidth,tY);
				}
				
			}
			
			
			var len:int;
			var lItems:Array;
			lItems = [];
			len = _items.length;
			var tLayout:Layouter;
			var items:Array;
			
			if (_items.length > 0) {
				layouter = LayoutFuns.getFullFillLayout(_items, 0, 20);
			}
			
		}
		
		public function reset():void {
			var childs:Array;
			childs = groupBox._children;
			var i:int, len:int;
			var tChild:Sprite;
			
			for (i = 0; i < len; i++) {
				tChild = childs[i];
				clearCurBox(tChild);
			}
			groupBox.removeChildren();
			_nameItemDic={};
			_nameList.length = 0;
			node = null;
		}
		
		
		override protected function changeSize():void 
		{
			super.changeSize();
			if (layouter) {
				layouter.width = this.width;
			}
		}

		
		public function freshMySize():void
		{
			if (layouter) {
				layouter.width = this.width;
			}
		}
		
		protected function onGroupBarClick(e:Event):void {
			if(!_enableClickSwitch) return;
			setGroupState(!groupBox.parent);
		}
		
		public static var x2:Number = 85;
		public static var x1:Number = 15;
		public static var rightD:Number = 15;
		public static const DefaultLabelWidth:int = 150;
		public static const typeTrans:Object = {"Boolean": "bool", "String": "string"};
		
		protected function createGroupProp(groupData:Object, tY:int):void {
			
			//			debugger;
			var tgLayout:Layouter;
			var props:Array;
			props = groupData.cList;
			var i:int, len:int;
			len = props.length;
			var nickName:String;
			var items:Array;
			items = [];
			var labelWidth:Number;
			labelWidth = DefaultLabelWidth*0.6;
			if (len > 2) {
				labelWidth = DefaultLabelWidth*0.5;
					//				debugger;
			}
			if (PropUtils.mParseInt(groupData["labelWidth"])) {
				labelWidth = PropUtils.mParseInt(groupData["labelWidth"]);
			}
			var propBox:PropItemBox;
			propBox = new PropItemBox();
			for (i = 0; i < len; i++) {
				var prop:Object = PropUtils.getDisplayPropObject(props[i]);
				
				var tLabelWidth:Number;
				tLabelWidth = PropUtils.mParseInt(prop["labelWidth"]);
				tLabelWidth = tLabelWidth ? tLabelWidth : labelWidth;		
				var tLayout:*;
				tLayout=createPropUI(prop,labelWidth,tY,propBox);
				if(tLayout)
				items.push(tLayout);
				
			}
			tgLayout = LayoutFuns.getSameWidthLayout(items, 5);
			_items.push(tgLayout);
		
		}
		
		private var _curBox:Box;
		public static const BBoxSign:String="BBoxSign";
		private var _boxOffsetY:Number=0;
		protected function get CurBox():Box
		{
			if(!_curBox)
			{
				_curBox=new Box();
				_curBox.left = _curBox.right = 0;
				_curBox.mouseEnabled = true;
				_boxOffsetY=0;
				_curBox[BBoxSign]=BBoxSign;
			}
			groupBox.addChild(_curBox);
			return _curBox;
		}
		
		protected function clearCurBox(box:Sprite):void
		{
			if(!box[BBoxSign]) return;
			var childs:Array;
			childs = box._children;
			var i:int, len:int;
			var tChild:Sprite;
			
			for (i = 0; i < len; i++) {
				tChild = childs[i];
				tChild.offAll();
			}
			box.removeChildren();
		}
	
		protected function adptAllChild(container:Sprite,dY:Number):void
		{
			var i:int,len:int;
			var childs:Array;
			childs=container._children;
			len=childs.length;
			for(i=0;i<len;i++)
			{
				childs[i].y+=dY;
			}
			
		}
		protected function addFixHeightItem(item:Sprite):void
		{
			CurBox.addChild(item);
			if(!_boxOffsetY)
			{
				_boxOffsetY=item.y;
				item.y=0;
			}else
			{
				item.y-=_boxOffsetY;
			}
			if(item.y<0)
			{
				_boxOffsetY+=item.y;
				adptAllChild(CurBox,-item.y);
				
			}
			
			if(item.name)
			{
				_nameItemDic[item.name]=item;
			}
		}
		protected function addNoFixHeightItem(item:Sprite):void
		{
			_curBox=null;
			if(item.name)
			{
				_nameItemDic[item.name]=item;
			}
			groupBox.addChild(item);
		}
		
		/**创建属性设置面板*/
		protected function createPropUI(data:Object, labelWidth:int = DefaultLabelWidth, y:Number = 0, propBox:PropItemBox = null):Layouter {
			if (!propBox)
			{
				propBox = new PropItemBox();
				
			}
			propBox.left = propBox.right=0;
			propBox.y = y;
			groupBox.addChild(propBox);
			var name:String;
			name = data.name;
			var type:String;
			type = data.type;
			var nickName:String;
			nickName = UIConfigManager.getNickNameFromPropConfig(data);
			_props.push(data);
			_nameList.push(name);
			
			if (typeTrans[type]) {
				type = typeTrans[type];
			}
			if (!type) type = "string";
			type = type.toLowerCase();
			var tItems:Array;
			tItems = [];
			
			var tLayout:Layouter;
			
			nameTypeO[name] = type;
			var label:Label;
			var propsInput:PropsInputBase;
			propsInput = PropPluginManager.createPluginByType(type);
			if(propsInput)
			{
				//if (propsInput is PropsBoolInput) debugger;
				_nameItemDic[name] = propsInput;
				if (!propsInput.selfAlign)
				{
					propsInput.right = rightD;
					//propsInput.right=10;
					propsInput.left=x1;
				}
				
				if(!propsInput.hasSide)
				{
					propsInput.right=0;
					propsInput.left=0;
				}
				propsInput.name=name;
				propsInput.valueKey=name;
				propsInput.initByConfig(data);
				propsInput.y = y;
				propsInput.y = 0;
				//groupBox.addChild(propsInput);
				if(propsInput.useIDELabel)
				{
					label = new Label();
					label.text = nickName;
					label.fontSize = PropStyleConst.PropPanelFontSize;
					label.height = label.fontSize+2;
					//label.pos(x1, y + (ItemHeight - label.height) * 0.5);
					label.pos(x1,(ItemHeight-label.height)*0.5);
					label.color = PropStyleConst.TreeItemColor;
					label.width = labelWidth;
					
					
					label.textField.overflow = Text.HIDDEN;
					labelDic[name] = label;
					labelInitLabel[name] = label.toolTip;
					
					x2 = label.width;
					if (!propsInput.selfAlign)
					{
						LayoutFuns.clearItemRelativeInfo(propsInput);
						propsInput.x = x2;
					}
					
					//addFixHeightItem(label);
					propBox.addChild(label);
				}
				
				propBox.addChild(propsInput);
				
				if(propsInput.isFixHeight)
				{
					propsInput.height = ItemHeight;
					//addFixHeightItem(propsInput);
				}else
				{
					//addNoFixHeightItem(propsInput);
				}
				
				//if(propsInput.isFixHeight)
				//{
					//propsInput.height = ItemHeight;
					//addFixHeightItem(propsInput);
				//}else
				//{
					//addNoFixHeightItem(propsInput);
				//}
				if (propsInput.useIDELabel&&!propsInput.selfAlign)
				{
					tItems.push(label);
					tItems.push(propsInput);
					LayoutFuns.clearItemsRelativeInfo(tItems);
					//var tLayout:Layouter;
					tLayout = LayoutFuns.getFixPos(tItems, 5, false);
					_items.push(tLayout);
					return tLayout;
				}
				return null;
			}
			
			return null;
		}

		public var _data:Object;
		public var itemType:String;
		
		
		
		public function setValueD(node:Object = null):void {
			this.itemType = itemType;
			_data = node.comXml;
			var data:Object;
			data = _data.props;
			this.node = node;
			var defaultData:Object;
			_isSettingValue = true;
			//遍历设置属性
			for (var i:int = 0, n:int = _props.length; i < n; i++) {
				var prop:Object = PropUtils.getDisplayPropObject(_props[i]);
				
				var name:String = prop.name;
				var dataName:String;
				dataName=prop.hasOwnProperty("_$dataName")?prop._$dataName:name;

				var value:String = "";

				if (!data.hasOwnProperty(dataName)) {
					if (defaultData && defaultData.hasOwnProperty(dataName)) {
						value = ObjectTools.getAutoValue(defaultData[dataName]);
						if (prop.type == "bool") {
							value = value ? "true" : "false";
						}
						//isDefault = true;
					}
				} else {
					value = data[dataName];
					if (prop.type == "bool") {
						value = value ? "true" : "false";
					}
				}
				
				//设置属性
				var target:PropsInputBase=getItemByName(name);
				target.isSettingValue = true;
				target.setTarget(node);
				target.isSettingValue = false;
					
			}
			_isSettingValue = false;
		}
	}
}