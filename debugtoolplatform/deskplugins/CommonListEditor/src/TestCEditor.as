package  
{
	import dataeditor.DataList;
	import dataeditor.DataTpl;
	import laya.debug.tools.resizer.DisResizer;
	import laya.debug.uicomps.ContextMenu;
	import laya.debug.uicomps.ContextMenuItem;
	import laya.display.Stage;
	import laya.net.Loader;
	import laya.utils.Handler;
	/**
	 * ...
	 * @author ww
	 */
	public class TestCEditor 
	{
		
		public function TestCEditor() 
		{
			Laya.init(1000, 900);
			Laya.stage.scaleMode = Stage.SCALE_FULL;
			//Laya.stage.bgColor = "#ffffff";
			DisResizer.init();
			ContextMenu.init();
			ContextMenuItem.labelColors = "#ffffff,#ffffff,#ffffff,#ffffff";
			ContextMenuItem.btnSkin = "comp/button.png";
			var resList:Array;
			resList = [ { "url":"res/atlas/comp.json", "type":Loader.ATLAS } ];
			//resList.push( { "url":"res/atlas/view.json", "type":Loader.ATLAS } );
			//resList.push({"url":"res/atlas/play.json","type":Loader.ATLAS});
			Laya.loader.load(resList, new Handler(this, test));
		}
		
		private function test():void
		{
			
			
			var editor:DataList;
			editor = new DataList();
			editor.pos(200, 200);
			editor.setData(DataTpl.createDataListData());
			Laya.stage.addChild(editor);
		}
		
	}

}