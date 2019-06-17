package nlp 
{
	import laya.net.Loader;
	import nlp.conll.ConllDesParser;
	import nlp.conll.ConllFileParser;
	import nlp.conll.ConllTreeAnalyse;
	import nlp.conll.ConllTreeBuilder;
	import nlp.dictools.TypeDicParser;
	/**
	 * ...
	 * @author ww
	 */
	public class NLP 
	{
		
		public function NLP() 
		{
			
		}
		
		public static function cut(str:String):Array
		{
			
		}
		
		public static function initWordCutter(dicFile:String,typeFile:String):void
		{
			WordDicParser.I.initByDicTxt(Loader.getRes(dicFile));
			var typeDic:TypeDicParser;
			typeDic = new TypeDicParser();
			typeDic.initByTxt(Loader.getRes(typeFile));
			typeDic.addDefaultTypes();
			//trace("unkonw:","　".charCodeAt(0));
			//trace(typeDic);
			WordUtils.typeDic = typeDic;
			WordDicParser.I.cutter.typeDic = typeDic;
			WordDicParser.I.trie.addWordOneList(typeDic.wordList);
		}
		
		public static var contreeBuilder:ConllTreeBuilder;
		public static var conllParser:ConllFileParser;
		public static function initConllTreeParser(conllDesFile:String,conllTrees:Array):void
		{
			contreeBuilder = new ConllTreeBuilder();

			var conllDes:ConllDesParser;
			conllDes = new ConllDesParser();
			conllDes.parseTxt(Loader.getRes(conllDesFile));
			
			ConllDesParser.I = conllDes;
			
			conllParser = new ConllFileParser();
			var i:int, len:int;
			len = conllTrees.length;
			for (i = 0; i < len; i++)
			{
				conllParser.parseTxt(Loader.getRes(conllTrees[i]));
			}
			
			
			ConllTreeAnalyse.typeDic = WordUtils.typeDic;
			var analyse:ConllTreeAnalyse;
			analyse = new ConllTreeAnalyse();
			analyse.analyse(conllParser.treeList);
			contreeBuilder.arcAnalyser.analyseTreeList(conllParser.treeList);
			contreeBuilder.treeAnalyseer = analyse;
		}
		
	}

}