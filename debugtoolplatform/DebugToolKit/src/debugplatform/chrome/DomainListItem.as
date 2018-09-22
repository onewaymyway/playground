package debugplatform.chrome 
{
	import laya.events.Event;
	import ui.debugplatform.chrome.DomainListItemUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class DomainListItem extends DomainListItemUI 
	{
		
		public function DomainListItem() 
		{
			this.on(Event.DOUBLE_CLICK,this,onDoubleClick);
			this.debugCheck.on(Event.CHANGE,this,onDebugCheckChange);
		}
		
		private function onDebugCheckChange():void
		{
			if(_isSettingValue) return;
			isDebugDic[filePath] = debugCheck.selected;
			if (debugCheck.selected)
			{
				tDataO.clz.enable();
			}else
			{
				tDataO.clz.disable();
			}
		}
		private var tDataO:Object;
		private var filePath:String;
		
		public var isDebugDic:Object;
		private var _isSettingValue:Boolean=false;
		public function initByData(dataO:Object):void
		{
			_isSettingValue=true;
			tDataO = dataO;

			filePath=dataO.name;
			
			label.text = filePath;
			debugCheck.selected=isDebugDic[filePath]?true:false;
			_isSettingValue=false;
		}
		
		private function onDoubleClick():void
		{
			
		}
	}

}