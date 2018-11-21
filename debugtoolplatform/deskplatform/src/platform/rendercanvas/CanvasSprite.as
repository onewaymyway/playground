///////////////////////////////////////////////////////////
//  CanvasSprite.as
//  Macromedia ActionScript Implementation of the Class CanvasSprite
//  Created on:      2016-8-3 下午2:43:22
//  Original author: ww
///////////////////////////////////////////////////////////

package platform.rendercanvas
{
	import laya.debug.tools.ClassTool;
	import laya.debug.tools.DisControlTool;
	import laya.debug.tools.JSTools;
	import laya.debug.view.nodeInfo.NodeUtils;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Matrix;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	import laya.renders.Render;
	import laya.renders.RenderContext;
	import laya.renders.RenderSprite;
	import laya.resource.HTMLCanvas;
	import laya.ui.Box;
	import laya.utils.Browser;
	import laya.utils.Pool;
	import laya.utils.Stat;
	import laya.utils.Utils;
	
	/**
	 * 
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2016-8-3 下午2:43:22
	 */
	public class CanvasSprite extends Box
	{
		/**当前画布*/
		public var canvas:HTMLCanvas;
		private var _context:RenderContext;
		public var clearWhenRemove:Boolean = false;
		public var mat:Matrix;
		public var rate:Number
		public function CanvasSprite()
		{
			
			canvas = HTMLCanvas.create('2D');
			_context = new RenderContext(100, 100, canvas);
			JSTools.setZIndex(canvas.source,100);
//			JSTools.noMouseEvent(canvas.source);
			rate = Browser.pixelRatio;
			if(rate<1) rate=1;
			if (rate!=1)
			{
				mat = new Matrix();
				mat.scale(1 / rate, 1 / rate);
				JSTools.setTransform(canvas.source, mat);
				
				//canvas.context.scale(rate, rate);
			}
//			canvas.source.addEventListener("mouseover", function(e:*):void {
//				canvasMouseOver();
//			})
			
			canvas.source.addEventListener("mouseup", passEvent);
			canvas.source.addEventListener("mousemove", passEvent);
			canvas.source.addEventListener("mousedown", passEvent);
			canvas.source.addEventListener('mousewheel', passEvent);
//			trace("create CanvasSprite");
//		    Laya.timer.loop(1,this,updateCanvas);
			
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
			Render.canvas.dispatchEvent(evt);

		}

		public var tar:Sprite;
		public var prePoint:Point=new Point();
		public function setTarget(tar:Sprite):void
		{
			this.tar=tar;
			tar["render"]=Utils.bind(newRender,this);
			tar.on(Event.DISPLAY, this, _onDisplay);
			tar.on(Event.UNDISPLAY, this, _onDisplay);
//			tar.on(Event.MOUSE_OUT,this,tarMouseOut);
			canvas.source.id=ClassTool.getNodeClassAndName(tar);
			tar["_repaint"] =1;
		}
		private function canvasMouseOver():void
		{
//			trace("canvas MouseOver");
//			JSTools.setMouseEnable(canvas.source,false);
		}
		private function tarMouseOut():void
		{
//			trace("tarMouseOut");
			if(HtmlZIndexManager.isMouseDown) return;
			JSTools.setMouseEnable(canvas.source,true);
		}
		public function clearMe():void
		{
			if(tar)
			{
				tar.off(Event.DISPLAY, this, _onDisplay);
			    tar.off(Event.UNDISPLAY, this, _onDisplay);
				tar.off(Event.MOUSE_OUT,this,tarMouseOut);
				var canvasSprite:CanvasSprite;
				canvasSprite=tar["canvasSprite"];
				if(canvasSprite)
				{
					delete tar["canvasSprite"];
					JSTools.removeElement(canvas.source);
				}
			}
			Pool.recover("CanvasSprite",this);
		}
		
		/**@private */
		private function _onDisplay():void {
			if(!tar) return;
			if(tar.displayedInStage)
			{
				
			}else
			{
				JSTools.removeElement(canvas.source);
				if (clearWhenRemove)
				{
					this.clearMe();
				}
			}
		}
		public function renderOld(context:RenderContext, x:Number, y:Number):void {
			
			
			Stat.spriteCount++;
			RenderSprite.renders[tar._renderType]._fun(tar, context, x, y);
			tar["_repaint"] = 0;
		}
		public function newRender(context:RenderContext, x:Number, y:Number):void {
			updateCanvas(x,y);
		}
		public static var parentNode:Object;
		public function updateCanvas(x:Number, y:Number):void
		{
			
			if(tar.displayedInStage)
			{
				if(tar["prerenderhook"])
				{
					tar["prerenderhook"]();
				}
				var point:Point;
				point=NodeUtils.getGPos(tar);
				if(!JSTools.isElementInDom(canvas.source))
				{
//					JSTools.addToBody(canvas.source);
//					JSTools.showToBody(canvas.source,point.x,point.y);
					JSTools.showToParent(canvas.source,point.x,point.y,parentNode);
					prePoint.setTo(point.x,point.y);
				}else
				{
					if(prePoint.x!=point.x||prePoint.y!=point.y)
					{
						JSTools.setPos(canvas.source,point.x,point.y);
						prePoint.setTo(point.x,point.y);
					}
				}

				
//				JSTools.setPos(canvas.source,point.x,point.y);
				if(tar["_repaint"] ==0) return;
				//if(IDEConsts.showRenderDebug)
				//{
					//trace("CanvasSprite:",this.tar);
				//}
				var gRec:Rectangle;
//				if(tar is ColorPickerPanelEx)
//				{
//					debugger;
//				}
				gRec = tar.getSelfBounds();	
				var dW:int=2;
				gRec.x-=dW;
				gRec.y-=dW;
				gRec.width+=dW*2;
				gRec.height+=dW*2;
				canvas.size(gRec.width*rate,gRec.height*rate);
				canvas.clear();
				if (rate != 1)
				{
					canvas.context.save();
				    canvas.context.scale(rate, rate);
					renderOld(_context, 0, 0);
				    canvas.context.restore();
				}else
				{
					renderOld(_context, 0, 0);
				}
				
				
				
				
			}else
			{
				JSTools.removeElement(canvas.source);
			}
			
		}
		public static var enableCanvasSprite:Boolean=true;
		public static function setSpriteCanvasRender(tar:Sprite,index:int=100,autoClear:Boolean=false):void
		{
			if(!enableCanvasSprite) return;
//			return;
			if(tar["canvasSprite"]) return;
			var canvasSprite:CanvasSprite;
			canvasSprite = Pool.getItemByClass("CanvasSprite", CanvasSprite);
			canvasSprite.clearWhenRemove = autoClear;
			canvasSprite.setTarget(tar);
			tar["canvasSprite"]=canvasSprite;
			setSpriteCanvasIndex(tar,index);
		}
		public static function setSpriteCanvasIndex(tar:Sprite,index:int):void
		{
			var canvasSprite:CanvasSprite;
			canvasSprite=tar["canvasSprite"];
			if(canvasSprite)
			{
				JSTools.setZIndex(canvasSprite.canvas.source,index);
			}
		}
		public static function removeSpriteCanvas(tar:Sprite):void
		{
			var canvasSprite:CanvasSprite;
			canvasSprite=tar["canvasSprite"];
			if(canvasSprite)
			{
				canvasSprite.clearMe();
				delete tar["canvasSprite"];
			}
		}
		public static function inits():void
		{
//			setSpriteCanvasRender(SetProject.instance);
			//setSpriteCanvasRender(QuickTool.instance);
//			setSpriteCanvasRender(MessageManager.instance,101);
			hookDialog();
		}
		public static function hookDialog():void
		{
			DialogHook.I.hookDialog();
		}
		public static function setSpriteRenderEmpty(tar:Sprite):void
		{
			tar["render"]=renderEmpty;
		}
		public static function renderEmpty():void
		{
			
		}
		
	}
}