package commontools 
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ui.List;
	import laya.ui.Panel;
	import laya.ui.ScrollBar;
	import laya.utils.Utils;
	/**
	 * ...
	 * @author ww
	 */
	public class NestScrollControl 
	{
		
		public function NestScrollControl() 
		{
			
		}
		
		public var containerSp:Panel;
		public var childSp:List;
		private var scrollBarContainer:ScrollBar;
		private var scrollBarChild:ScrollBar;
		public var isOn:Boolean = false;
		public function setUp(panel:Panel, list:List):void
		{
			isOn = true;
			this.containerSp = panel;
			this.childSp = list;
			
			scrollBarContainer = panel.vScrollBar;
			
			scrollBarChild = list.scrollBar;
			
			scrollBarContainer.isLockedFun = Utils.bind(isPanelCanDragFun, this);
			scrollBarContainer.triggerUpDragLimit = Utils.bind(panelUpDragTrigger, this);
			scrollBarChild.isLockedFun = Utils.bind(isListCanDragFun, this);
			scrollBarChild.triggerDownDragLimit = Utils.bind(listDownDragTrigger, this);
		}
		
		public function setUpByPanelPanel(panel:Panel, panel1:Panel):void
		{
			isOn = true;
			this.containerSp = panel;
			this.childSp = panel1;
			
			scrollBarContainer = panel.vScrollBar;
			
			scrollBarChild = panel1.vScrollBar;
			
			scrollBarContainer.isLockedFun = Utils.bind(isPanelCanDragFun, this);
			scrollBarContainer.triggerUpDragLimit = Utils.bind(panelUpDragTrigger, this);
			scrollBarChild.isLockedFun = Utils.bind(isListCanDragFun, this);
			scrollBarChild.triggerDownDragLimit = Utils.bind(listDownDragTrigger, this);
		}
		
		public function setSwitchItem(item0:Sprite, item1:Sprite):void
		{
			ScrollBarSwitch.createSwitch(scrollBarContainer, item0, item1);
		}
		

		
		private function listDownDragTrigger(isTweenMove:Boolean=false):Boolean
		{
			if (!isOn) return false;
			
			if (isTweenMove)
			{
				scrollBarContainer.startTweenMoveForce(scrollBarChild.lastOffset);
			}else
			{
				scrollBarContainer.startDragForce();
			}
			
			return true;
		}
		private function isPanelCanDragFun(e:Event):Boolean
		{
			if (!isOn) return true;
			
			if (scrollBarContainer.value < scrollBarContainer.max) return true;
			if (scrollBarChild.max <= 0) return true;
			if (childSp.contains(e.target)) return false;
			return true;
		}
		
		private function panelUpDragTrigger(isTweenMove:Boolean=false):Boolean
		{
			if (!isOn) return false;
			if (isTweenMove)
			{
				//if(list.scrollBar.max>0)
				scrollBarChild.startTweenMoveForce(scrollBarContainer.lastOffset);
			}else
			{
				//if(list.scrollBar.max>0)
				scrollBarChild.startDragForce();
			}
			
			return true;
		}
		private function isListCanDragFun(e:Event):Boolean
		{
			if (!isOn) return true;
			if (scrollBarChild.max <= 0) return false;
			if (scrollBarContainer.value < scrollBarContainer.max) return false;
			return true;
		}
	}

}