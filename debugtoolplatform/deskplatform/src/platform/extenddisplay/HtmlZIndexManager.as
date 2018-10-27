///////////////////////////////////////////////////////////
//  HtmlZIndexManager.as
//  Macromedia ActionScript Implementation of the Class HtmlZIndexManager
//  Created on:      2016-8-10 下午4:21:23
//  Original author: ww
///////////////////////////////////////////////////////////

package platform.extenddisplay
{

	import laya.debug.tools.JSTools;
	import laya.events.Event;
	import laya.maths.Point;
	import platform.tools.Notice;
	
	/**
	 * 
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2016-8-10 下午4:21:23
	 */
	public class HtmlZIndexManager
	{
		public function HtmlZIndexManager()
		{
		}
		public static const DisableOverlays:String="DisableOverlays";
		public static const EnableOverlays:String="EnableOverlays";
		public static function init():void
		{
			Laya.stage.on(Event.MOUSE_DOWN,null,onMouseDown);
			Laya.stage.on(Event.MOUSE_UP,null,onMouseUp);
//			Laya.stage.on(Event.MOUSE_OUT,null,onMouseUp);
		}
		public static var prePos:Point=new Point();
		public static var isDrag:Boolean=false;
		public static var isMouseDown:Boolean=false;
		public static function onMouseDown():void
		{
			isMouseDown=true;
			prePos.setTo(Laya.stage.mouseX,Laya.stage.mouseY);
			isDrag=false;
			Laya.stage.on(Event.MOUSE_MOVE,null,onMouseMove);
			
		}
		private static function onMouseMove():void
		{
			if(Math.abs(prePos.x-Laya.stage.mouseX)+Math.abs(prePos.y-Laya.stage.mouseY)>5)
			{
				Notice.notify(DisableOverlays);
				setHtmlEnable(false);
				isDrag=true;
				Laya.stage.off(Event.MOUSE_MOVE,null,onMouseMove);
				
			}
		}
		public static function onMouseUp():void
		{
			isMouseDown=false;
			Laya.stage.off(Event.MOUSE_MOVE,null,onMouseMove);
			if(!preValue)
			{
				Notice.notify(EnableOverlays);
				setHtmlEnable(true);
			}
			isDrag=false;
		}
		public static var preValue:Boolean=true;
		public static function setHtmlEnable(enable:Boolean):void
		{
			preValue=enable;
//			return;
			
			var i:int,len:int;
			len=htmlList.length;
			for(i=0;i<len;i++)
			{
				if(htmlList[i].disableAutoControl) continue;
				JSTools.setMouseEnable(htmlList[i],enable);
			}
		}
		public static var htmlList:Array=[];
		public static function addHtml(html:Object):void
		{
			if(!html) return;
			if(!htmlList.indexOf(html)>=0)
			{
				htmlList.push(html);
			}
		}
		public static function removeHtml(html:Object):void
		{
			if(!html) return;
			var index:int;
			index=htmlList.indexOf(html);
			if(index>=0)
			{
				htmlList.splice(index,1);
			}
		}
		
		
	}
}