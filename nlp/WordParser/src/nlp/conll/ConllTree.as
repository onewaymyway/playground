package nlp.conll 
{
	/**
	 * ...
	 * @author ww
	 */
	public class ConllTree 
	{
		private var wordList:Array;
		public function ConllTree() 
		{
			wordList = [];
		}
		
		public function addLine(line:String):void
		{
			wordList.push(ConllWord.parseFromLine(line));
		}
	}

}