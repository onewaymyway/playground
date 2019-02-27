package nlp.conll 
{
	/**
	 * ...
	 * @author ww
	 */
	public class ConllRelation 
	{
		public var start:int;
		public var end:int;
		public var type:String;
		public var len:int;
		public function ConllRelation() 
		{
			
		}
		
		public static function buildByWord(word:ConllWord):ConllRelation
		{
			var rst:ConllRelation;
			rst = new ConllRelation();
			rst.start = word.id;
			rst.end = word.head;
			rst.type = word.deprel;
			rst.len = Math.abs(rst.start - rst.end);
			return rst;
		}
	}

}