package remotedebugtool.view 
{
	import laya.events.Event;
	import laya.utils.Handler;
	import remotedebugtool.client.DebugClient;
	import remotedebugtool.client.DebugControlClient;
	import remotedebugtool.client.DebugMsgConst;
	import remotedebugtool.ui.remotedebugtool.EditorViewListUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class EditorViewList extends EditorViewListUI 
	{
		private var _client:DebugControlClient;
		public function EditorViewList() 
		{
			_client = new DebugControlClient();
			_client.on(DebugClient.OnReady, this, onControlReady);
			_client.on(DebugClient.OnRemoteInfo,this, onRemoteMsg);
			viewList.array = [];
			viewList.renderHandler = new Handler(this, listRenderHandler);
			freshBtn.visible = false;
			freshBtn.on(Event.CLICK, this, onFreshBtn);
		}
		
		public function connect(server:String):void
		{
			_client.connect(server);
		}
		private function listRenderHandler(cell:EditorViewItem, index:int ):void
		{
			var dataO:Object;
			dataO = cell.dataSource;
			cell.initByData(dataO);
		}
		private function onFreshBtn():void
		{
			_client.sendTypedToChannel(DebugMsgConst.GetAllDebugView, { } );
		}
		
		private function onControlReady():void
		{
			freshBtn.visible = true;
		}
		
		private function onRemoteMsg(dataO:Object):void
		{
			trace("onRemoteMsg:", dataO);
			switch(dataO.type)
			{
				case DebugMsgConst.GetAllDebugView:
					debugger;
					viewList.array = dataO.data;
					break;
			}
		}
		
	}

}