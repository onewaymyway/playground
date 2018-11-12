package platform.layout
{

	import configs.StyleConsts;
	import electrontools.drags.DragEvent;
	import electrontools.drags.DragManager;
	import extendui.FocusManager;
	import extendui.layout.RelativePos;
	import laya.debug.tools.ClassTool;
	import laya.debug.tools.DisControlTool;
	import laya.debug.tools.resizer.DisResizer;
	import laya.display.Graphics;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	import laya.ui.Box;
	import laya.ui.Clip;
	import laya.ui.ISelect;
	import laya.utils.Browser;
	import laya.utils.HitArea;
	import nodetools.devices.Sys;
	import platform.interfaces.PlatformEvents;
	import platform.interfaces.PlatformVars;
	import platform.interfaces.SkinDefines;
	import platform.managers.LayerManager;
	import platform.tools.Notice;
	import ui.layout.LayoutRecUI;
	
	/**
	 * 布局框
	 * @author ww
	 */
	public class LayoutRec extends LayoutRecUI
	{
		public static const Min:int = 1;
		public static const Normal:int = 2;
		public static const Max:int = 3;
		private var disList:Array;
		private static var preTipIcon:Sprite;
		public function LayoutRec()
		{
			super();
			tab.on(Event.CHANGE, this, onTabChange);
			//close.on(Event.CLICK, this, closeHandler);
			//_drag.visible = false;
			//_drag.on(Event.MOUSE_DOWN, this, onDragDown);
			//_drag.toolTip = "点击拖拽";
			//minBtn.on(Event.MOUSE_DOWN, this, onMinDown);
//			back.skin="";
			back.on(Event.MOUSE_DOWN, this, onBackDown);
			back.on(Event.DOUBLE_CLICK, this, onBackDoubleDown);
			//this.on(Event.MOUSE_DOWN, this, onThisDown);
			disList = [tab];
			_backHeight = back.height;
			//this.on(Event.MOUSE_OVER, this, onMouseOver);
			//this.on(Event.MOUSE_MOVE, this, onMouseOver);
			this.on(DragEvent.Draging_Hit,this,onMouseOver);
			//this.on(Event.ADDED, this, parentChange);
			this.on(Event.MOUSE_OVER, this, onMouseOverThis);
			this.on(Event.MOUSE_OUT, this, onMouseOutThis);
			updateUIState();	

			this.on(Event.ADDED,this,onAdded);
			Notice.listen(PlatformEvents.SHOW_LAYOUTTAB_BY_NAME,this,showTabByName);
//			visible=false;
			tab.labelColors=StyleConsts.TreeItemColor;
			tipIcon.on(Event.MOUSE_DOWN,this,onTipClick);
			tipIcon.toolTip=Sys.lang("点击打开帮助文档");
			
			var hArea:HitArea;
			hArea=new HitArea();
			actionIcon.hitArea=hArea;
			hArea.hit.clear();
			hArea.hit.drawRect(-10,-16,60,40,"#ff0000");
			actionIcon.on(Event.MOUSE_DOWN,this,onActionIconClick);
		}
		
		private function onActionIconClick(e:Event):void
		{
	
			e.stopPropagation();
			trace("onActionIconClick:",curActionType);
			switch(curActionType)
			{
				case "toBottom":
					
					LayoutRecManager.minToBottom(this);
					break;
				case "toLeft":
					LayoutRecManager.minToLeft(this);
					break;
				case "toRight":
					LayoutRecManager.minToRight(this);
					break;
			}
		}
		public static var PanelTips:Object=
			{
			};
		private function onTipClick():void
		{
			if(!_curUI) return;
			var className:String;
			className=ClassTool.getClassName(_curUI);
//			trace("tipClick:",className);
			var tUrl:String;
			tUrl=PanelTips[className];
			if(tUrl)
			{
				Browser.window.open(tUrl);
			}
		}
		
		public function getCurTipUrl():String
		{
			if(!_curUI) return null;
			var className:String;
			className=ClassTool.getClassName(_curUI);
			//			trace("tipClick:",className);
			var tUrl:String;
			tUrl=PanelTips[className];
			return tUrl;
		}
		
		private function onMouseOutThis():void
		{
			
		}
		private function onAdded():void
		{

		}
		private function updateUIState():void
		{
			//close.visible=canClose;
			back.visible=tab.visible=canAddTab;
			
		}

		
		private function onMouseOverThis(E:Event):void
		{
			if(this.isMinRecState) return;

			if(_curMenuBox)
			{
				_curMenuBox.visible=true;
			}
			if (this.parent == LayerManager.stage)
			{
				
				DisResizer.setUp(this, true);
			}
		}
		private function onThisDown(e:Event):void
		{
			if (this.parent == LayerManager.stage)
			{
				
				DisResizer.setUp(this, true);
			}
		}
		private var _backHeight:Number;
		
		private function onBackDown(e:Event):void
		{
			if (this.parent == LayerManager.stage)
			{
				this.startDrag();
				this.once(Event.DRAG_END, this, stopDrag);
//				startDragMe(true);
			}else
			{
				startDragMe();
			}
		}
		public var preWidth:int;
		public var preHeight:int;
		public var preMoveLen:int;
		private var _disMode:int = Normal;
		
		public function get isMinRecState():Boolean
		{
			return this.width<30||this.height<30;
		}
		private function updateUIMinStates():void
		{
			var isMinRec:Boolean=false;
			isMinRec=isMinRecState;
			
			if(isMinRec)
			{
				if(_curMenuBox)
				{
					_curMenuBox.visible=false;
				}
//				tab.visible=false;
				if(_curUI)
				{
					_curUI.visible=false;
				}
				tipIcon.visible=false;
			}else
			{
				if(_curMenuBox)
				{
//					_curMenuBox.visible=true;
				}
//				tab.visible=canAddTab;
				if(_curUI)
				{
					_curUI.visible=true;
				}
			}
			tab.visible=canAddTab&&(this.width>30);
		}
		
		private function updateActionIcon():void
		{
			if(_disMode==Min)
			{
				switch(curActionType)
				{
					case "toBottom":
						actionIcon.skin="view/arrow_up.png";
						break;
					case "toLeft":
						actionIcon.skin="view/arrow_right.png";
						break;
					case "toRight":
						actionIcon.skin="view/arrow_left.png";
						break;
					default:
						actionIcon.skin=null;
				}
			}else
			{
				switch(curActionType)
				{
					case "toBottom":
						actionIcon.skin="view/arrow_down.png";
						break;
					case "toLeft":
						actionIcon.skin="view/arrow_left.png";
						break;
					case "toRight":
						actionIcon.skin="view/arrow_right.png";
						break;
					default:
						actionIcon.skin=null;
				}
			}
		}
		public function set disMode(type:int):void
		{
//			trace("setDisMode:", type, "pre:", _disMode);
			if (_disMode != Min)
			{
				preWidth = width;
				preHeight = height;
			}
			if (_disMode == type)
				return;
			
			_disMode = type;
			updateActionIcon();
			return;
			switch (_disMode)
			{
				case Min: 
					goMinState();
					LayoutRecManager.minRec(this);
					back.off(Event.MOUSE_DOWN, this, onBackDown);
					back.on(Event.MOUSE_DOWN, this, onBackDown);
					
					break;
				default: 
					back.off(Event.MOUSE_DOWN, this, onBackDown);
					
					goMaxState();
					LayoutRecManager.recoverRec(this);
			
			}
		}
		
		public function get disMode():int
		{
			return _disMode;
		}
		
		private function onBackDoubleDown(e:Event):void
		{
			//disMode = Min;
			//LayoutRecManager.minRec(this);
			if(IDEVars.disableTabDrag) return;
			if (this.parent != LayerManager.stage)
			{
				LayoutRecManager.popRec(this);
			}
			else
			{
				//DisResizer.setUp(this);
			}
		
		}
		
		private function goMinState():void
		{
			DisControlTool.removeItems(disList);
			//back.bottom = 0;
		}
		
		private function goMaxState():void
		{
			DisControlTool.addItems(disList, this);
			//back.top = null;
			//back.bottom = null;
			//back.height = _backHeight;
			//Laya.timer.once(100, this, later);
		
		}
		
		private function later():void
		{
			back.height = _backHeight;
		}
		
		
		private function onMouseOver(e:Event):void
		{
			if (!DragManager.isDraging) return;
			if (!(DragManager.getDragType() == "LayoutRec" || DragManager.getDragType() == "LayoutTab")) return;
			//if (DragManager.getDragTarget == this) return;
//			trace("onMouseOver");
			var type:String = RelativePos.getDisMouseRelativePos(this);
			if(DragManager.getDragTarget()==this)
			{
				
				if(type==RelativePos.Up)
				{
					type=RelativePos.Center;
				}
			}
			if(DragManager.getDragType()=="LayoutTab")
			{
				if(type==RelativePos.Up)
				{
					type=RelativePos.Center;
				}
			}
			var focusWidth:Number;
			switch (type)
			{
				
				case RelativePos.Right: 
				case RelativePos.Left: 
					focusWidth=0.5*this.width;
					FocusManager.showBorder(this, type, true,null,focusWidth);
					break;
				case RelativePos.Up: 
				case RelativePos.Down:
					focusWidth=0.5*this.height;
					FocusManager.showBorder(this, type, true,null,focusWidth);
					break;
				case RelativePos.Center: 
				
					FocusManager.showFocus(this);
					break;
			}
			DisControlTool.setTop(this);
		
		}
		
		private function onMouseOut(e:Event):void
		{
		
		}
		
		private function onDragDown(e:Event):void
		{
			e.stopPropagation();
			startDragMe();

		}
		private function startDragMe(self:Boolean=false):void
		{
			if(LayoutRecManager.popLocked()) return;
			if(!canDragMe) return;
			if(PlatformVars.disableTabDrag) return;
			var clip:Clip = new Clip(SkinDefines.LayoutRecDragIcon, 1, 3);
			clip.index = 2;
			var type:String = "LayoutRec";
			DragManager.I.doDrag(this, self?null:clip, {type: type, target: this}, DragManager.dragOffset);
		}
		private function closeHandler(e:Event):void
		{
			LayoutRecManager.removeRec(this);
		}
		
		override protected function changeSize():void
		{
			super.changeSize();
			//cacheAsBitmap = false;
			//var g:Graphics = graphics;
			//g.clear();
			//g.drawRect(0, 0, width, height, "#000000");
			//g.fillRect(5, 5, width - 10, height - 10, "#22ff00");
			//cacheAsBitmap = true;
			if(tab)
			{
				var rec:Rectangle;
				rec=tab.scrollRect||new Rectangle();
				rec.setTo(0,0,this.width,25);
				tab.scrollRect=rec;
			}
			updateUIMinStates();
		}
		private var _curUI:Box;
		private var _curMenuBox:Box;
		public var tTabTxt:String;
		public var tTabHelpUrl:String;
		private var curActionType:String;
		public function getTabSkin():String
		{
			return getTabProp("recTabSkin");
		}
		
		public function getTabAction():String
		{
			return getTabProp("recActionType");
		}
		
		public function getTabActionPos():String
		{
			return getTabProp("recActionPos");
		}
		public function getTabProp(key:String):String
		{
			var tabList:Array;
			tabList=tab.items as Array;
			var i:int,len:int;
			len=tabList.length;
			for(i=0;i<len;i++)
			{
				if(tabList[i]&&tabList[i].ui&&tabList[i].ui[key]) return tabList[i].ui[key];
			}
			return null;
		}
		protected function onTabChange(e:Event):void
		{
			if (_curUI)
			{
				_curUI.removeSelf();
				if(_curMenuBox)
				{
					_curMenuBox.removeSelf();
				}
				_curUI = null;
			}
			if (tab.selectedIndex != -1)
			{
				_curUI = LayoutTab(tab.selection).ui;
				if(PlatformVars.enableTabMenu)
				{
					_curMenuBox=_curUI["menuBox"];
					if(_curMenuBox)
					{
						_curMenuBox.left=80;
						_curMenuBox.right=0;
						_curMenuBox.bottom=NaN;
						_curMenuBox.top=NaN;
						_curMenuBox.y=0;
						_curMenuBox.visible=false;
						addChild(_curMenuBox);
					}
				}
				if(_curUI["recBarSkin"])
				{
					back.skin=_curUI["recBarSkin"];
				}
//				if(_curUI["recLineSkin"])
//				{
//					line.skin=_curUI["recLineSkin"];
//				}else
//				{
//					line.skin=null;
//				}
//				curActionType=_curUI["recActionType"];
				curActionType=getTabAction();
				if(curActionType)
				{
					actionIcon.visible = true;
					switch(getTabActionPos())
					{
						case "right":
							tab.left = 0;
							actionIcon.right = 9;
							actionIcon.left = NaN;
							break;
						default:
							tab.left = actionIcon.x + actionIcon.displayWidth + 6;
							actionIcon.left = 5;
							actionIcon.right = NaN;
					}
					
					
					updateActionIcon();
				}else
				{
					actionIcon.visible=false;
					tab.left=0;
				}
				addChildAt(_curUI,0);
				tTabTxt = _curUI["title"];
				tTabHelpUrl=_curUI["helpUrl"];
				if(_curUI is UIPanel)
				{
					this.cacheAsBitmap=false;
					LayoutTab(tab.selection).cacheAsBitmap=false;
			    }
			}
		}
		
		public function addUI(ui:Box):void
		{
			var uiTab:LayoutTab = new LayoutTab(ui);
			if(!uiTab.hasTabSkin)
			{
//				debugger;
				if(getTabSkin())
				{
					uiTab.setTabSkin(getTabSkin());
				}
			}
			addTab(uiTab);
			
		}
		
		public function get canClose():Boolean
		{
			var tabList:Array;
	        tabList=tab.items as Array;
			var i:int,len:int;
			len=tabList.length;
			for(i=0;i<len;i++)
			{
				if(!tabList[i].canClose) return false;
			}
			return true;
		}
		public function get canAddTab():Boolean
		{
			var tabList:Array;
			tabList=tab.items as Array;
			var i:int,len:int;
			len=tabList.length;
			for(i=0;i<len;i++)
			{
				if(!tabList[i].canMix) return false;
			}
			return true;
		}
		public function get hasFree():Boolean
		{
			var tabList:Array;
			tabList=tab.items as Array;
			var i:int,len:int;
			len=tabList.length;
			for(i=0;i<len;i++)
			{
				if(tabList[i].freeSize) return true;
			}
			return false;
		}
		public function get canDragMe():Boolean
		{
			return canAddTab;
		}
		public function get sizeFree():Boolean
		{
			if(hasFree)
			{
				return true;
			} 
			return !canAddTab;
		}
		public function addTab(uiTab:LayoutTab):void
		{
			var index:int;
			index = tab.addItem(uiTab as ISelect);
			tab.selectedIndex = index;
			uiTab._rec = this;
			updateUIState();
		}
		
		public function removeTab(uiTab:LayoutTab,autoRemove:Boolean=false):void
		{
			tab.delItem(uiTab as ISelect);
			uiTab._rec = null;
			updateUIState();
			if(autoRemove&&tab.items.length<1)
			{
				LayoutRecManager.removeRec(this);
			}
//			onTabChange(null);
		}
		public function removeUI(ui:Sprite,autoRemove:Boolean=false):void
		{
			var tabList:Array;
			tabList=tab.items as Array;
			var i:int,len:int;
			len=tabList.length;
			for(i=0;i<len;i++)
			{
				if(tabList[i].ui==ui)
				{
					removeTab(tabList[i],autoRemove);
					return;
				}
			}
		}
		public function getUIs():Array
		{
			var i:int, len:int;
			var items:Array;
			items = tab.items as Array;
			len = items.length;
			var rst:Array;
			rst = [];
			for (i = 0; i < len; i++)
			{
				rst.push((items[i] as LayoutTab).ui);
			}
			return rst;
		}
		public var relativeO:Object = {};
		
		public function clearRelative():void
		{
			RelativePos.clearBar(this);
		}
		public function showTabByName(tabName:String):void
		{
			if(_curUI&&_curUI["title"]==tabName) return;
			var tabList:Array;
			tabList=tab.items as Array;
			var i:int,len:int;
			len=tabList.length;
			for(i=0;i<len;i++)
			{
				if(tabList[i].ui&&tabList[i].ui["title"]==tabName)
				{
					tab.selectedIndex=i;
					return;
				}
			}
	    }
		public function clears():void
		{
			Notice.cancel(PlatformEvents.SHOW_LAYOUTTAB_BY_NAME,this,showTabByName);
			clearRelative();
			tab.destroy();
			this.destroy(false);
		}
	
	}

}