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
		public var index:int;
		public var conllDes:ConllDesParser;
		public function ConllFileParser(conllDes:ConllDesParser=null) 
		{
			this.conllDes = conllDes;
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
				if (tLine.indexOf("\t")<0)
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
			trace("conllfileParser:", this);
			trace("contypeDic:",ConllWordDic.I);
		}
		
		
		public function reset():void
		{
			index = 0;
		}
		
		public function getCurLine():String
		{
			return treeList[index];
		}
		
		public function pre():String
		{
			index--;
			normalIndex();
			return getCurLine();
		}
		
		public function next():String
		{
			index++;
			normalIndex();
			return getCurLine();
		}
		
		private function normalIndex():void
		{
			if (index < 0) index = 0;
			if (index >= treeList.length) index = treeList.length - 1;
		}
	}

}