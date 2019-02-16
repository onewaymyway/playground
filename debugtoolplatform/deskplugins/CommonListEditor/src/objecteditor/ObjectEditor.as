package objecteditor 
{
	import commonlayout.mindmaptree.MindMapViewer;
	import ui.objecteditor.ObjectEditorUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ObjectEditor extends ObjectEditorUI 
	{
		private var viewer:MindMapViewer;
		public function ObjectEditor() 
		{
			viewer = new MindMapViewer();
			var clzList:Array;
			clzList = [ArrayItem, KeyItem, KeyValueItem, ObjectItem, ValueItem];
			viewer.regItemClassList(clzList);
			content.addChild(viewer);
			viewer.centerY = 0;
			viewer.x = 100;
			
			this.on("DataChanged", this, freshUI);
		}
		
		public static function createTplData():Object
		{
			var rst:Object;
			rst = {};
			rst.type = "Object";
			rst.label = "Object";
			var actionData:Object;
			actionData = {
				"type":"ObjectItem",
				"props":{"des":"描述信息","label":"问题"},
				"childs":
					[
					]
				};
			rst.data = actionData;
			
			return rst;
		}
		private var _dataO:Object;
		public function freshUI():void
		{
			viewer.setData(_dataO);
		}
		public function freshLayout():void
		{
			viewer.freshLayout();
		}
		public function setData(dataO:Object):void
		{
			_dataO = dataO;
			freshUI();
		}
		
	}

}