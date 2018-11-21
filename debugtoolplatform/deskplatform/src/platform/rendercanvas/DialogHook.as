///////////////////////////////////////////////////////////
//  DialogHook.as
//  Macromedia ActionScript Implementation of the Class DialogHook
//  Created on:      2016-8-3 下午5:34:23
//  Original author: ww
///////////////////////////////////////////////////////////

package platform.rendercanvas
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.events.EventDispatcher;
	import laya.ui.Dialog;
	
	/**
	 * 
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2016-8-3 下午5:34:23
	 */
	public class DialogHook extends Sprite
	{
		public function DialogHook()
		{
		}
		public static var I:DialogHook=new DialogHook();
		public function hookDialog():void
		{
//			Dialog.manager["show"]=show;
//			Dialog.manager["popup"]=popup;
//			Dialog.manager["close"]=close;
//			return;
			Dialog.manager["open"]=open;
			Dialog.manager.closeEffect=null;
			Dialog.manager.popupEffect=null;
			Dialog.manager.closeEffectHandler=null;
			Dialog.manager.popupEffectHandler=null;
		}
		public var dialogLayer:Sprite = new Sprite();
		public var modalLayer:Sprite = new Sprite();
		public var maskLayer:Sprite = new Sprite();
		public var _centerDialog:Function;
		public var _checkMask:Function;
		public var popupEffect:Function;
		
		public static var tZorder:int=1;
		/**
		 * 显示对话框(非模式窗口类型)。
		 * @param dialog 需要显示的对象框 <code>Dialog</code> 实例。
		 * @param closeOther 是否关闭其它对话框，若值为ture，则关闭其它的对话框。
		 */
		public function open(dialog:Dialog, closeOther:Boolean = false):void {
			if (closeOther) removeChildren();
			CanvasSprite.setSpriteCanvasRender(dialog,101);
			tZorder++;
			dialog.zOrder=tZorder;
			if (dialog.popupCenter) _centerDialog(dialog);
			addChild(dialog);
			if (dialog.isModal || this._$P["hasZorder"]) timer.callLater(this, _checkMask);
			popupEffect && popupEffect(dialog);
			event(Event.OPEN);
		}
		
		/**
		 * 关闭对话框。
		 * @param dialog 需要关闭的对象框 <code>Dialog</code> 实例。
		 */
		public function close(dialog:Dialog):void {
			try
			{
				dialog.removeSelf();
				if (modalLayer.numChildren < 2) {
					maskLayer.removeSelf();
				} else {
					modalLayer.setChildIndex(maskLayer, modalLayer.numChildren - 2);
				}
			}catch(e:*){}
			
			event(Event.CLOSE);
		}
		/**
		 * 显示对话框(非模式窗口类型)。
		 * @param dialog 需要显示的对象框 <code>Dialog</code> 实例。
		 * @param closeOther 是否关闭其它对话框，若值为ture，则关闭其它的对话框。
		 */
		public function show(dialog:Dialog, closeOther:Boolean = false):void {
			CanvasSprite.setSpriteCanvasRender(dialog,101);
			if (closeOther) dialogLayer.removeChildren();
			if (dialog.popupCenter) _centerDialog(dialog);
			dialogLayer.addChild(dialog);
			event(Event.OPEN);
		}
		
		/**
		 * 显示对话框(模式窗口类型)。
		 * @param dialog 需要显示的对象框 <code>Dialog</code> 实例。
		 * @param closeOther 是否关闭其它对话框，若值为ture，则关闭其它的对话框。
		 */
		public function popup(dialog:Dialog, closeOther:Boolean = false):void {
			CanvasSprite.setSpriteCanvasRender(dialog,101);
			if (closeOther) modalLayer.removeChildren();
			if (dialog.popupCenter) _centerDialog(dialog);
			modalLayer.addChild(dialog);
			addChild(modalLayer);
			event(Event.OPEN);
		}
	}
}