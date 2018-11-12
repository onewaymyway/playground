///////////////////////////////////////////////////////////
//  IFrameRenderItem.as
//  Macromedia ActionScript Implementation of the Class IFrameRenderItem
//  Created on:      2018-6-13 上午11:49:38
//  Original author: ww
///////////////////////////////////////////////////////////

package platform.viewers
{
	import electrontools.drags.DragEvent;
	import laya.debug.tools.DisControlTool;
	import laya.display.Graphics;
	import laya.display.Input;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.events.EventDispatcher;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	import laya.renders.Render;
	import laya.utils.Browser;
	import nodetools.devices.SystemSetting;
	import platform.tools.Notice;
	import platform.tools.Notices;
	import viewRender.EditorRenderBase;

	/**
	 * 
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2018-6-13 上午11:49:38
	 */
	public class IFrameRenderItem
	{
		
		public var renderFrame:*;
		public var render:EditorRenderBase;
		public var style:Object;
		public var iframeWindow:*;
		
		public var eDispatcher:EventDispatcher;
		
		public var renderHit:Sprite;
		
		private var hitBounds:Rectangle;
		
		private static var offPos:Point;
		public var isLoaded:Boolean=false;
		
		public function IFrameRenderItem()
		{
			eDispatcher=new EventDispatcher();
			renderHit=new Sprite();
			hitBounds=new Rectangle(0,0);
			offPos=new Point();
			init();
			adpt();
		}
		
		
		
		private function onRenderHitDown():void
		{
			Laya.stage.focus=renderHit;
		}
		
		private function onRenderHitMouseOver():void
		{
			if(SystemSetting.autoFocsEditRect)
			Laya.stage.focus=renderHit;
		}
		private function init():void
		{
			if (renderFrame) return;
			
			renderHit.name="renderHit";
			renderHit.mouseEnabled=true;
			renderHit.on(DragEvent.DRAG_DROP, this, renderDragDrop);
			renderFrame = Browser.createElement("iframe");
			renderHit.on(Event.MOUSE_DOWN, this, onRenderHitDown);
			renderHit.on(Event.RIGHT_MOUSE_DOWN,this,onRenderHitDown);
			renderHit.on(Event.MOUSE_OVER,this,onRenderHitMouseOver);
			renderFrame.id = "viewrender";
			renderFrame.width = "400";
			renderFrame.height = "300";
			renderFrame.left = "400";
			renderFrame.top = "400";
			//renderFrame.frameborder = "no";
			
			style = renderFrame.style;
			style.position = "absolute";
			style.top = "100px";
			style.left = "220px";
			style["z-index"] = 101;
			style.border = "0";
			render = renderFrame.contentWindow;
			var passEventList:Array=["mousedown","mousemove","mouseup","keydown","keypress","keyup"];
			renderFrame.addEventListener("load", onRenderFrameloaded, false)
				
			function onRenderFrameloaded():void
			{
				//代码能执行到这里说明已经载入成功完毕了
				render = renderFrame.contentWindow.renderBinds;
				iframeWindow=renderFrame.contentWindow;
				var i:int,len:int;
				len=passEventList.length;
				for(i=0;i<len;i++)
				{
					iframeWindow.document.removeEventListener(passEventList[i], passEvent);
					iframeWindow.document.addEventListener(passEventList[i], passEvent);
				}
				
				loaded();
				//这里是回调函数
			}
			
			
			var idePassEventList:Array=["keydown","keypress","keyup"];
			var i:int,len:int;
			len=idePassEventList.length;
			for(i=0;i<len;i++)
			{
				Laya.stage.on(idePassEventList[i],this,passEvent2);
			}
		}
		public function passEvent(e:*):void
		{
			var evt:*;
			evt = Browser.document.createEvent("Events");
			evt.initEvent(e.type, true, true);
			var key:String;
			for(key in e)
			{
				if(!(e[key] is Function))
				{
					evt[key]=e[key];
				}
			}
			evt.isFromIDE=true;
			evt.clientX+=offPos.x;
			evt.clientY+=offPos.y;
			evt.pageX=0;
			evt.pageY=0;
//			debugger;
			if(e.type=="mousedown")
			{
				if(Browser.window.uicodeMenuDiv)
				{
					Browser.window.uicodeMenuDiv.hide();
				}
			}
			if(!isFromMe)
				Render.canvas.dispatchEvent(evt);
			
		}
		public static var isFromMe:Boolean=false;
		
		public function passEvent2(e:*):void
		{
			if(!iframeWindow) return;
			if(Input.isInputting) return;
			e=e.nativeEvent;
			if(e.isFromIDE) return;
			var evt:*;
			evt = Browser.document.createEvent("Events");
			evt.initEvent(e.type, true, true);
			var key:String;
			for(key in e)
			{
				if(!(e[key] is Function))
				{
					evt[key]=e[key];
				}
			}

			isFromMe=true;
			iframeWindow.document.dispatchEvent(evt);
			isFromMe=false;
			
		}
		
		public function insertClassList(clsList:Array,tarWindow:*=null):void
		{
			if(!tarWindow) tarWindow=iframeWindow;
			var i:int,len:int;
			len=clsList.length;
			var tClz:*;
			for(i=0;i<len;i++)
			{
				tClz=clsList[i];
				insertClass(tClz,tarWindow);
			}
		}
		
		public function insertClass(clz:Object,tarWindow:*=null):void
		{
			if(!tarWindow) tarWindow=iframeWindow;
			var tName:String;
			tName=clz.__className;
			var pathList:Array
			pathList=tName.split(".");
			var i:int,len:int;
			len=pathList.length;
			var tPath:String;
			var tO:Object;
			tO=tarWindow;
			for(i=0;i<len-1;i++)
			{
				tPath=pathList[i];
				if(!tO[tPath]) tO[tPath]={};
				tO=tO[tPath];
			}
			tO[pathList[len-1]]=clz;
		}
		
		private function renderDragDrop(e:DragEvent):void
		{
			Laya.stage.focus=renderHit;
			//			trace("renderDragDrop");
			var point:Point=DisControlTool.getMousePoint(renderHit);
			//			trace("render mouse:",point.x,point.y);
			e.data.dropX=point.x;
			e.data.dropY=point.y;
			Notice.notify(Notices.DROP_RENDER,[e]);
		}
		
		private function renderMouseHandler(e:Event):void
		{
			if(!iframeWindow) return;
			var point:Point;
			point = DisControlTool.getMousePoint(renderHit);
			//evt.clientX = point.x;
			//evt.clientY = point.y;
			var evt:*;
			evt = Browser.document.createEvent("MouseEvents");
			evt.initMouseEvent(
				e.type, 
				true, 
				true,
				Browser.document.defaultView,
				0,
				point.x,
				point.y,
				point.x,
				point.y
			);
			
			//window.document.dispatchEvent(evt);
			iframeWindow.dispatchEvent(evt);
			//			trace("re patch event:",evt,point.x,point.y);
		}
		private function loaded():void
		{
			trace("IFrameRenderItem loaded");
//			debugger;
			Notice.listen(Notices.RENDER_INITED,null,renderInited);
			if(render)
				render.setNotice(Notice.I);
			
			eDispatcher.event(Event.COMPLETE);
			adpt();
			Laya.stage.event(Event.FOCUS);
			isLoaded=true;
		}
		private function renderInited():void
		{
			trace("renderInited");
		}
		
		public var targetParent:Sprite;
		/**
		 * 调整iframe位置 
		 * 
		 */
		public function adpt():void
		{
			if (renderFrame)
			{

				var pos:Point = new Point();
				pos = targetParent.localToGlobal(pos);
				
				var dLen:int;
				dLen=25;
				renderHit.width=targetParent.width;
				renderHit.height=targetParent.height-dLen;
		
				
				renderHit.x=targetParent.x;
				renderHit.y = targetParent.y + dLen;
				
							
				var style:Object;
				style=renderFrame.style;
				offPos.setTo(pos.x,pos.y+dLen);
				style.top = pos.y+dLen+"px";
				style.left = (pos.x)+"px";

						
				renderFrame.width =  renderHit.width;
				renderFrame.height =  renderHit.height;
							
				hitBounds.width=renderHit.width;
				hitBounds.height=renderHit.height;

				hitBounds.x=0;
				hitBounds.y=0;
				renderHit.setBounds(hitBounds);
			}
		}
		
		/**
		 * 设置渲染器的url 
		 * @param url
		 * 
		 */
		public function setRender(url:String):void
		{
//			debugger;
			if(isLoaded) return;
			renderFrame.src = url;
		}
		
		
		/**
		 * 显示
		 * 
		 */
		public function show():void
		{
//			debugger;
			if(!renderFrame.parentNode)
			Browser.container.appendChild(renderFrame);
			setVisible(true);
			targetParent.parent.addChild(renderHit);
			adpt();
		}
		
		/**
		 * 隐藏
		 * 
		 */
		public function hide(clearSrc:Boolean=false):void
		{
//			debugger;
//			Browser.removeElement(renderFrame);
			
			setVisible(false);
			if(clearSrc)
			{
				renderFrame.src = "";
			}
			
			renderHit.removeSelf();
		}
		
		public function setVisible(visible:Boolean):void
		{
			var style:Object;
			style=renderFrame.style;
			if(visible)
			{
				style.display="";
			}else
			{
				style.display="none";
			}
		}
	}
}