package  
{
	import laya.debug.DebugPanel;
	import laya.debug.uicomps.ContextMenu;
	import laya.debug.uicomps.ContextMenuItem;
	import laya.display.Stage;
	import laya.display.Text;
	import laya.net.Loader;
	import laya.utils.Handler;
	import mindmap.MindMapEditor;
	import viewRender.EditorRenderBase;
	/**
	 * ...
	 * @author ww
	 */
	public class TestDemo extends EditorRenderBase
	{
		
		public function TestDemo() 
		{
			Laya.init(1000, 900);
			Laya.stage.scaleMode = Stage.SCALE_FULL;
			ContextMenu.init();
			ContextMenuItem.labelColors = "#ffffff,#ffffff,#ffffff,#ffffff";
			ContextMenuItem.btnSkin = "comp/button.png";
			var resList:Array;
			resList = [ { "url":"res/atlas/comp.json", "type":Loader.ATLAS } ];
			//resList.push( { "url":"res/atlas/view.json", "type":Loader.ATLAS } );
			//resList.push({"url":"res/atlas/play.json","type":Loader.ATLAS});
			Laya.loader.load(resList, new Handler(this, test));
			//DebugPanel.init();
		}
		private var text:Text;
		private var mindMapEditor:MindMapEditor;
		
		private function test():void
		{
			
			text = new Text();
			text.text = "Demo";
			text.color = "#ff0000";
			text.fontSize = 20;
			text.pos(100, 100);
			Laya.stage.addChild(text);
			
			mindMapEditor = new MindMapEditor();
			mindMapEditor.left = mindMapEditor.right = mindMapEditor.top = mindMapEditor.bottom = 2;
			Laya.stage.addChild(mindMapEditor);
			updateUIContent();
		}
		
		private var _data:Object;
		override public function getRenderData():Object 
		{
			return _data;
		}
		
		override public function setData(data:Object):void 
		{
			_data = data;
			super.setData(data);
			updateUIContent();
		}
		
		override public function updateData(data:Object):void 
		{
			_data = data;
			super.updateData(data);
			updateUIContent();
		}
		
		
		private function updateUIContent():void
		{
			if (!_data) return;
			mindMapEditor.setData(_data);
			text.text = JSON.stringify(_data);
		}
	}

}