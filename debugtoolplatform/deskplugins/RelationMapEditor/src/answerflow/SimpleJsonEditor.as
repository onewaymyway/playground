package answerflow 
{
	import commontools.MessageManager;
	import commonui.view.TipMessage;
	import laya.debug.tools.JsonTool;
	import laya.events.Event;
	import laya.utils.Handler;
	import ui.answerflow.SimpleJsonEditorUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class SimpleJsonEditor extends SimpleJsonEditorUI 
	{
		private static var _I:SimpleJsonEditor;
		public static function get I():SimpleJsonEditor
		{
			if (!_I) _I = new SimpleJsonEditor();
			return _I;
		}
		public function SimpleJsonEditor() 
		{
			saveBtn.on(Event.CLICK, this, onBtnClick, ["saveBtn"]);
			cancelBtn.on(Event.CLICK, this, onBtnClick,["cancelBtn"]);
		}
		
		private var complete:Handler;
		public function start(editData:Object,complete:Handler):void
		{
			this.complete = complete;
			editTxt.text = JsonTool.getJsonString(editData,false);
			popup();
		}
		
		
		private function checkJson():Object
		{
			var dataO:Object;
			try
			{
				dataO = JSON.parse(editTxt.text);
			}catch (e:*)
			{
				trace("parse err:",e);
				dataO = null;
			}
			return dataO;
		}
		private function onBtnClick(type:String):void
		{
			switch(type)
			{
				case "saveBtn":
					var tData:Object;
					tData = checkJson();
					if (!tData)
					{
						MessageManager.I.show("格式错误");
					}else
					{
						if (complete)
						{
							complete.runWith(tData);
						}
					this.close();
					}
					break;
				case "cancelBtn":
					close();
					break;
			}
		}
		
	}

}