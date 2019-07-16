package test 
{
	import nlp.algorithm.ObjectHeap;
	/**
	 * ...
	 * @author ww
	 */
	public class TestObjectHeap 
	{
		
		public function TestObjectHeap() 
		{
			test();
		}
		
		private function test():void
		{
			var i:int, len:int;
			len = 10;
			var arr:Array;
			var heap:ObjectHeap;
			heap = new ObjectHeap();
			heap.isTopMax = false;
			heap.key = null;
			arr = [];
			for (i = 0; i < len; i++)
			{
				arr.push(Math.floor(Math.random()*100));
			}
			trace("arr:",arr);
			for (i = 0; i < len; i++)
			{
				//heap.addByValue(arr[i]);
			}
			heap.addByValueList(arr);
			var sortArr:Array;
			sortArr = heap.popAll(false);
			trace("sortArr:",sortArr);
			
			
		}
	}

}