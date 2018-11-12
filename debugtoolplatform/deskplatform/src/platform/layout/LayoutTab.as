package platform.layout
{

	import configs.StyleConsts;
	import electrontools.drags.DragManager;
	import laya.events.Event;
	import platform.interfaces.PlatformVars;
	import platform.tools.ObjectUtils;
	import ui.layout.LayoutTabUI;


	import laya.ui.Box;
	import laya.ui.Clip;
	import laya.utils.Handler;
	
	/**
	 * 布局框标签
	 * @author ww
	 */
	public class LayoutTab extends LayoutTabUI
	{
		private var _ui:Box;
		
		public function LayoutTab(tabUI:Box)
		{
			super();
			this._ui = tabUI;
			_ui.left = _ui.right = _ui.bottom = 0;
			if(_ui is HtmlSprite)
			{
				_ui.left = _ui.right = _ui.bottom = 5;
			}
			_ui.top = 25;
		    if(!canMix)
			{
				_ui.top = 0;
			}
			_ui["layoutTab"]=this;
			btn.skin=tabSkin;
			close.on(Event.CLICK, this, onCloseClick);
			btn.on(Event.MOUSE_DOWN, this, onBtnDown);
			onTitleChange();
			if(!canClose)
			{
				close.visible=false;
			}
			
			if(PlatformVars.disableTabClose)
			{
				close.visible=false;
			}else
			{
				btn.labelAlign = "left";
				btn.labelPadding = "-2,5,0,5";
			}
			
			btn.labelColors = StyleConsts.LayoutTabTitleBtnColors;
			//cacheAsBitmap = true;
		}
		
		public function setTabSkin(skin:String):void
		{
			btn.skin=skin;
		}
		public var _rec:LayoutRec;
		private function onBtnDown(e:Event):void
		{
			if(LayoutRecManager.popLocked()) return;
			if(_rec&&!_rec.canDragMe) return;
			if(PlatformVars.disableTabDrag) return;
			var clip:Clip = new Clip(SkinDefines.LayoutTabDragIcon, 1, 3);
			clip.index = 2;
			var type:String = "LayoutTab";
			DragManager.I.doDrag(this , clip, {type: type, target:this._rec}, DragManager.dragOffset);
		}
		private function onCloseClick(e:Event):void
		{
			if(_rec)
			_rec.removeTab(this,true);
			
			clears();
		}
		public function get canClose():Boolean
		{
			if(!_ui) return true;
			return _ui["canClose"];
		}
		public function get canMix():Boolean
		{
			if(!_ui||!_ui.hasOwnProperty("canMix")) return true;
			
			return _ui["canMix"];
		}
		public function get freeSize():Boolean
		{
			if(!_ui||!_ui.hasOwnProperty("freeSize")) return false;
			
			return _ui["freeSize"];
		}
		public function onTitleChange(e:Event = null):void
		{
			var title:String;
			title = _ui["title"]?_ui["title"]:"我是标题啊";
			var len:Number = ObjectUtils.getTextField(null, "*" + title).width + 20;
			btn.width = len;
			close.x = len - close.displayWidth - 3;
			btn.label = title;
		}
		
		
		public function get hasTabSkin():Boolean
		{
			if(_ui&&_ui["recTabSkin"])
			{
				return true;
			}
			return false;
		}
		public function get tabSkin():String
		{
			if(_ui&&_ui["recTabSkin"])
			{
				return _ui["recTabSkin"];
			}
			return "view/tab_panel.png";
		}
		
		public function get recBarSkin():String
		{
			if(_ui&&_ui["recBarSkin"])
			{
				return _ui["recBarSkin"];
			}
			return "view/bg_panel_layoutrec.png";
		}
		
		public function get recLineSkin():String
		{
			if(_ui&&_ui["recLineSkin"])
			{
				return _ui["recLineSkin"];
			}
			return null;
		}
		
		public function get recActionType():String
		{
			if(_ui&&_ui["recActionType"])
			{
				return _ui["recActionType"];
			}
			return null;
		}
		
		public function get recActionPos():String
		{
			if(_ui&&_ui["recActionPos"])
			{
				return _ui["recActionPos"];
			}
			return null;
		}
		public override function get width():Number
		{
			return btn.width;
		}
		
		/**点击处理器(无默认参数)*/
		public function get clickHandler():Handler
		{
			return btn.clickHandler;
		}
		
		public function set clickHandler(value:Handler):void
		{
			btn.clickHandler = value;
		}
		
		/**是否是选择状态*/
		public function get selected():Boolean
		{
			return btn.selected;
		}
		
		public function set selected(value:Boolean):void
		{
			btn.selected = value;
		}
		
		public function get ui():Box
		{
			return _ui;
		}
		public function clears():void
		{
			_ui = null;
		}
	}

}