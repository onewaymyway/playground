package viewRender  
{

	import laya.display.Sprite;
	import laya.utils.Browser;
	import laya.utils.Utils;
	import platform.tools.Notice;
	import platform.tools.Notices;

	/**
	 * ...
	 * @author WW
	 */
	public class ViewRenderBase 
	{
		
		public function ViewRenderBase() 
		{
			initFuns();
		}
		public function initFuns():void
		{
			Browser.window.renderBinds={};
			Browser.window.renderBinds.setData = Utils.bind(setData, this);
			Browser.window.renderBinds.updateData = Utils.bind(updateData, this);
			Browser.window.renderBinds.clearRender = Utils.bind(clearRender,this);
			Browser.window.renderBinds.sizeRender = Utils.bind(sizeRender,this);
			Browser.window.renderBinds.posRender = Utils.bind(posRender,this);
			Browser.window.renderBinds.getRenderData = Utils.bind(getRenderData, this);
			Browser.window.renderBinds.getStage = Utils.bind(getStage,this);
			Browser.window.renderBinds.setNotice = Utils.bind(setNotice, this);
			Browser.window.renderBinds.firstInit = Utils.bind(firstInit,this);
		}
		
		public function getRenderData():Object
		{
			return null;
		}
		public function setData(data:Object):void
		{
			
		}
		
		public function updateData(data:Object):void
		{
			
		}
		
		public function clearRender():void
		{
			
		}
		public function sizeRender(width:int,height:int):void
		{
			
		}
		
		public function posRender(x:int,y:int):void
		{
			
		}
		public function getStage():Sprite
		{
			return Laya.stage;
		}
		public function setNotice(notice:Notice):void
		{
			Notice.I=notice;
			Notice.notify(Notices.RENDER_INITED);
		}
		
		public function firstInit(complete:Function=null,param:*=null):void
		{
		}
		
	}

}