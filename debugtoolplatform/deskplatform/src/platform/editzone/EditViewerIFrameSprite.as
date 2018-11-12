package platform.editzone 
{
	import laya.events.Event;
	import platform.extenddisplay.IFrameSprite;
	import platform.tools.Notice;
	import platform.tools.Notices;
	import viewRender.EditorRenderBase;
	/**
	 * ...
	 * @author ww
	 */
	public class EditViewerIFrameSprite extends IFrameSprite
	{
		public var renderFrame:*;
		public var renderItem:EditorRenderBase;
		public var style:Object;
		public var iframeWindow:*;
		public function EditViewerIFrameSprite() 
		{
			
		}
		
		override protected function onIFrameLoaded():void 
		{
			super.onIFrameLoaded();
			//代码能执行到这里说明已经载入成功完毕了
			iframeWindow=div.contentWindow;
			renderItem = iframeWindow.renderBinds;
			if (!renderItem) return;
			Notice.listen(Notices.RENDER_INITED,null,renderInited);
			if(renderItem)
				renderItem.setNotice(Notice.I);	
			event(Event.LOADED);
		}
		
		protected function renderInited():void
		{
			trace("renderInited");
		}
	}

}