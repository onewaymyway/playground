package nlp.conll 
{
	import laya.net.Loader;
	import laya.utils.Handler;
	/**
	 * ...
	 * @author ww
	 */
	public class ConllFileParser 
	{
		
		public function ConllFileParser() 
		{
			treeList = [];
		}
		
		
		public function loadFile(file:String,complete:Handler=null):void
		{
			Laya.loader.load(file, Handler.create(this, onFileLoaded,[complete]), null, Loader.TEXT);
		}
		
		
		private function onFileLoaded(complete:Handler,txt:String):void
		{
			parseTxt(txt);
			if (complete)
			{
				complete.run();
			}
		}
		public var treeList:Array;
		public function parseTxt(txt:String):void
		{
			var lines:Array;
			lines = txt.split("\n");
			var i:int, len:int;
			len = lines.length;
			var tLine:String;
			var tTree:ConllTree;
			for (i = 0; i < len; i++)
			{
				tLine = lines[i];
				if (tLine == "")
				{
					tTree = null;
				}else
				{
					if (!tTree)
					{
						tTree = new ConllTree();
						treeList.push(tTree);
						
					}
					tTree.addLine(tLine);
				}
			}
			trace("conllfileParser:",this);
		}
	}

}