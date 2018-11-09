///////////////////////////////////////////////////////////
//  KeyManager.as
//  Macromedia ActionScript Implementation of the Class KeyManager
//  Created on:      2016-4-20 下午4:48:41
//  Original author: ww
///////////////////////////////////////////////////////////

package extendui
{
	import laya.display.Input;
	import laya.display.Sprite;
	import laya.events.Event;
	
	/**
	 * 
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2016-4-20 下午4:48:41
	 */
	public class KeyManager
	{
		public function KeyManager()
		{
		}
		public static var I:KeyManager=new KeyManager();
		
		public function init():void
		{
			Laya.stage.on(Event.KEY_DOWN,this,keyDown);
			Laya.stage.on(Event.KEY_UP,this,keyUp);
			Laya.stage.on(Event.BLUR,this,onBlur);
	    }
		public  function onBlur():void
		{
			isCommandKeyDown=false;
	    }
		public static var commandKeys:Object=
			{
				91:true,
				93:true,
				244:true,
				17:true
			};
		public function isCommandKey(keyCode:int):Boolean
		{
//			91, 93, and 224, will get the job done. 17 
			if(commandKeys[keyCode]) return true;
			return false;
		}
		public static function isABC(keyCode:int):Boolean
		{
			return keyCode>=65&&keyCode<=90;
		}
		public static function getCharByCode(code:int):String
		{
			return String.fromCharCode(code);
		}
		public var isCommandKeyDown:Boolean=false;
		private function keyDown(e:Event):void
		{
//			trace("keyDown:",e.keyCode,e);
			if(isCommandKey(e.keyCode))
			{
				isCommandKeyDown=true;
			}
			if(Input.isInputting)
			{
				isCommandKeyDown=false;
			}
	    }
		private function keyUp(e:Event):void
		{
//			trace("keyUp:",e.keyCode,e);
			if(Input.isInputting)
			{
				isCommandKeyDown=false;
			}
			if(isCommandKey(e.keyCode))
			{
				isCommandKeyDown=false;
			}
	    }
		
		private static var focusList:Array=[];
		public static function setNewFocus(item:Sprite):void
		{
			if(Laya.stage.focus)
			{
				focusList.push(Laya.stage.focus);
			}
			Laya.stage.focus=item;
		}
		public static function restoreFocus():void
		{
			if(focusList.length>0)
			{
				Laya.stage.focus=focusList.pop();
			}
		}
	}
}