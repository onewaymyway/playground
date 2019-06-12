package nlp.conll 
{
	import laya.debug.tools.ObjectTools;
	/**
	 * ...
	 * @author ww
	 */
	public class ConllWord 
	{
		/**
		 * 当前词在句子中的序号，１开始.
		 */
		public var id:int;
		/**
		 * 当前词语或标点
		 */
		public var form:String;
		/**
		 * 当前词语（或标点）的原型或词干，在中文中，此列与FORM相同
		 */
		public var lemma:String;
		/**
		 * 当前词语的词性（粗粒度）
		 */
		public var cpostag:String;
		/**
		 * 当前词语的词性（细粒度）
		 */
		public var postag:String;
		/**
		 * 句法特征，在本次评测中，此列未被使用，全部以下划线代替。
		 */
		public var feats:String;
		/**
		 * 当前词语的中心词
		 */
		public var head:int;
		/**
		 * 当前词语与中心词的依存关系
		 */
		public var deprel:String;
		
		public var word:String;
		
		public var tree:ConllTree;
		public var refers:Array;
		public function ConllWord() 
		{
			
		}
		
		
		public static const KeyList:Array = ["id","form","lemma","cpostag","postag","feats","head","deprel"];
		public static function parseFromLine(line:String):ConllWord
		{
			var values:Array;
			values = line.split("\t");
			var rst:ConllWord;
			rst = new ConllWord();
			var i:int, len:int;
			len = KeyList.length;
			for (i = 0; i < len; i++)
			{
				rst[KeyList[i]] = values[i];
			}
			rst.id = Sys.mParseInt(rst.id) - 1;
			rst.head = Sys.mParseInt(rst.head) - 1;
			rst.word = rst.form;
			rst.refers = [];
			return rst;
		}
		
		public function clone():ConllWord
		{
			var rst:ConllWord;
			rst = new ConllWord();
			ObjectTools.copyValueByArr(rst, this, KeyList);
			rst.word = rst.form;
			return rst;
		}
		
		public function removeTreeInfo():void
		{
			head =-1;
			deprel = null;
			refers = [];
		}
		
		public function sortRefers(i:int):void
		{
			function mSort(v0:int, v1:int):int
			{
				if (v0 == i||v1==i)
				{
					return v0 - v1;
				}
				
				if (v0 > i && v1 > i)
				{
					return v1 - v0;
				}
				
				if (v0 < i && v1 < i)
				{
					return v1 - v0;
				}
				
				return v0 - v1;
			}
			//this.refers.sort();
			//this.refers.reverse();
			this.refers.sort(mSort);
			//this.refers.reverse();
			
		}
	}

}