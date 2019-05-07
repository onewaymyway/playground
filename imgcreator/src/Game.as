package  
{
	import laya.display.Sprite;
	import laya.display.Stage;
	import laya.events.Event;
	import laya.net.Loader;
	import laya.utils.Handler;
	import scriptuis.ScriptUICreateUtils;
	import ui.codeeditor.CodeIconsUI;
	import wraps.filesaver.FileSaver;


	/**
	 * ...
	 * @author ww
	 */
	public class Game 
	{
		
		private var configName:String;
		public function Game() 
		{
			Laya.init(720, 1280);
			Laya.stage.scaleMode = Stage.SCALE_SHOWALL;
			Laya.stage.alignH = Stage.ALIGN_CENTER;
			Laya.stage.alignV = Stage.ALIGN_MIDDLE;
			Laya.stage.bgColor = "#aaaaaa";
			UIConfig.closeDialogOnSide = false;
			var loadList:Array;
			loadList = [];
			loadList.push( { url:"res/atlas/comp.json", type:Loader.ATLAS } );
			Laya.loader.load( loadList, new Handler(this, initGameView));
			
		}

		
		public function saveView(view:Sprite):void
		{
			var childs:Array;
			childs = view._childs;
			var i:int, len:int;
			len = childs.length;
			var tChild:Sprite;
			
			for (i = 0; i < len; i++)
			{
				tChild = childs[i];
				if (tChild.name)
				{
					trace("save:", tChild.name);
					Laya.timer.once(100 * i, FileSaver, FileSaver.saveSprite, [tChild, tChild.name],false);
					//FileSaver.saveSprite(tChild, tChild.name);
				}
			}
		}
		private var tSp:CodeIconsUI;
		private var resSp:Sprite;
		private function initGameView():void
		{
			
			//tSp = new CodeIconsUI();
			//tSp.pos(100, 100);
			Laya.stage.on(Event.CLICK, this, onMouseClick);
			//Laya.stage.addChild(tSp);
			
			resSp = ScriptUICreateUtils.createSpForRender();
			resSp.pos(100, 100);
			Laya.stage.addChild(resSp);
		}
		
		private function onMouseClick():void
		{
			
			saveView(resSp);
		}
		
	}

}