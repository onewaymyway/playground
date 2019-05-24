package nlp 
{
	import laya.net.Loader;
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
		
	}

}