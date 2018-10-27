///////////////////////////////////////////////////////////
//  HtmlSprite.as
//  Macromedia ActionScript Implementation of the Class HtmlSprite
//  Created on:      2016-8-9 上午11:59:23
//  Original author: ww
///////////////////////////////////////////////////////////

package platform.extenddisplay
{
	
	import laya.debug.tools.DisControlTool;
	import laya.debug.tools.JSTools;
	import laya.debug.view.nodeInfo.NodeUtils;
	import laya.display.Input;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.events.MouseManager;
	import laya.maths.Point;
	import laya.renders.RenderContext;
	import laya.ui.Box;
	import laya.utils.Browser;
	
	
	/**
	 * 
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2016-8-9 上午11:59:23
	 */
	public class HtmlSprite extends Box
	{
		public var canClose:Boolean=true;
		public var disableAutoControl:Boolean=true;
		public function HtmlSprite()
		{
			super();
			
			parentNode=Browser.container;
			this.mouseEnabled=true;
//			testDiv=FileManager.readTxtFile(FileManager.getAppPath("h5/plugins/testplugin/ui.div"));
			createHtml();
			size(100,100);
//			JSTools.noMouseEvent(div);
			on(Event.DISPLAY, this, _onDisplay);
			on(Event.UNDISPLAY, this, _onDisplay);
//			setHtmlTxt(testDiv);
			setZIndex(101);
			this.on(Event.MOUSE_OVER,this,renderMouseHandler);
			this.on(Event.MOUSE_DOWN,this,onMyMouseDown);
			JSTools.setMouseEnable(div,false);
			div.addEventListener("mouseout", function(e:*):void {
				divMouseOut();
			})
		}
		private function onMyMouseDown():void
		{
			if(!JSTools.getMouseEnable(div))
			{
				JSTools.setMouseEnable(div,true);
			}
	    }
		private function divMouseOut():void
		{
			JSTools.setMouseEnable(div,false);
		}
		private  function renderMouseHandler(e:Event):void
		{
			//			trace("mouseOver");
			if(Input.isInputting)
			{
				HtmlZIndexManager.isMouseDown=false;
			}
			if(HtmlZIndexManager.isMouseDown) return;
			JSTools.setMouseEnable(div,true);
		}
		public function createHtml():void
		{
			div=Browser.createElement("div");
		}
		public static var testDiv:String="";
		public function setHtmlTxt(html:String):void
		{
			div.innerHTML=html;
		}
		public var div:*;
		public function setZIndex(zIndex:int=101):void
		{
			JSTools.setZIndex(div,zIndex);
		}
		/**@private */
		private function _onDisplay():void {

			if(displayedInStage)
			{
				Laya.timer.frameLoop(1,this,updateMyPos);
				if(!disableAutoControl)
				HtmlZIndexManager.addHtml(div);
			}else
			{
				Laya.timer.clear(this,updateMyPos);
				JSTools.removeElement(div);
				HtmlZIndexManager.removeHtml(div);
			}
		}
		
		public var prePoint:Point=new Point();
		public static var parentNode:Object;
		override public function render(context:RenderContext, x:Number, y:Number):void
		{

			super.render(context, x, y);
//			updateMyPos();
		}
		public function updateMyPos():void
		{
			if(displayedInStage&&visible)
			{
				
				var point:Point;
				point=NodeUtils.getGPos(this);
				if(!JSTools.isElementInDom(div))
				{
					//					JSTools.addToBody(canvas.source);
					//					JSTools.showToBody(canvas.source,point.x,point.y);
					JSTools.showToParent(div,point.x,point.y,parentNode);
					prePoint.setTo(point.x,point.y);
				}else
				{
					if(prePoint.x!=point.x||prePoint.y!=point.y)
					{
						JSTools.setPos(div,point.x,point.y);
						prePoint.setTo(point.x,point.y);
					}
				}
//				if(!DisControlTool.isChildE(this,MouseManager.instance._target))
//				{
//					JSTools.setMouseEnable(div,false);
//				}else
//				{
//					JSTools.setMouseEnable(div,true);
//				}
				
				
			}else
			{
				JSTools.removeElement(div);
			}
		}
		
		override protected function changeSize():void
		{
			super.changeSize();
			JSTools.setSize(div,width,height);
		}
		
		
	}
}