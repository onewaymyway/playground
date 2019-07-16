package nlp.algorithm 
{
	/**
	 * ...
	 * @author ww
	 */
	public class ObjectHeap 
	{
		public var key:String="value";
		public var idKey:String = "id";
		public var isTopMax:Boolean = true;
		public function ObjectHeap() 
		{
			
		}
		private var _arr:Array=[];
		
		private function getValueByIndex(index:int):Number
		{
			var value:Number;
			value = key?_arr[index][key]:_arr[index];
			if (!isTopMax)
			{
				value =-value;
			}
			return value;
		}
		
		public function getValue(index:int =-1):Number
		{
			if (index < 0) index = 0;
			return _arr[index];
		}
		
		public function getTopItem():Object
		{
			return _arr[0];
		}
		
		public function get size():int
		{
			return _arr.length;
		}
		
		private function swap(i:int, j:int):void
		{
			var temp:*;
			temp = _arr[i];
			_arr[i] = _arr[j];
			_arr[j] = temp;
			updateID(i);
			updateID(j);
		}
		
		private function updateID(index:int):void
		{
			if (!key) return;
			_arr[index][idKey] = index;
		}
		
		public function buildByArr(arr:Array):void
		{
			this._arr = arr;
			var i:int, len:int;
			len = _arr.length;
			for (i = 0; i < len; i++)
			{
				updateID(i);
			}
			for (i = getLastParent(len); i >= 0; i--)
				adjustHeap(i, len);
			
		}
		
		public function addByValueList(vList:Array):void
		{
			var i:int, len:int;
			len = vList.length;
			for (i = 0; i < len; i++)
			{
				addByValue(vList[i]);
			}
		}
		
		public function addByValue(value:Number):Object
		{
			if (!key)
			{
				addItem(value);
				return;
			}
			var obj:Object;
			obj = {};
			obj[key] = value;
			addItem(obj);
			return obj;
		}
		public function addItem(item:Object):void
		{
			var tIndex:int;
			tIndex=_arr.length;
			_arr.push(item);
			updateID(tIndex);
			adjustHeapB2T(tIndex, _arr.length);
		}
		
		public function popTop():Object
		{
			if (_arr.length < 1) return null;
			var item:Object;
			item = _arr[0];
			swap(0, _arr.length - 1);
			_arr.length = _arr.length - 1;
			if (_arr.length)
			{
				adjustHeap(0, _arr.length);
			}
			return item;
		}
		
		public function popAll(onlyValue:Boolean=false):Array
		{
			var i:int, len:int;
			len = _arr.length;
			var rst:Array;
			rst = [];
			var tItem:Object;
			for (i = 0; i < len; i++)
			{
				tItem = popTop();
				if (onlyValue&&key)
				{
					rst.push(tItem[key]);
				}else
				{
					rst.push(tItem);
				}
			}
			return rst;
		}
		
		public function removeItem(item:Object):Boolean
		{
			var tIndex:int;
			tIndex = item[idKey];
			if (_arr[tIndex] != item) 
			{
				trace("removeitem not found:",item);
				return false;
			}
			if (tIndex == _arr.length - 1)
			{
				_arr.length = _arr.length - 1;
				return true;
			}
			swap(tIndex, _arr.length - 1);
			_arr.length = _arr.length - 1;
			adjustHeap(tIndex, _arr.length);
			adjustHeapB2T(tIndex, _arr.length);
			return true;
		}
		
		public function updateItem(item:Object):Boolean
		{
			var tIndex:int;
			tIndex = item[idKey];
			if (_arr[tIndex] != item) 
			{
				trace("updateItem not found:",item);
				return false;
			}
			adjustHeap(tIndex, _arr.length);
			adjustHeapB2T(tIndex, _arr.length);
			return true;
		}
		
		/**
		 * 堆底向上调整
		 * @param	child
		 * @param	end
		 */
		private function adjustHeapB2T(child:int, end:int):void
		{
			var parent:int;
			parent = getParent(child);
			while (parent >= 0)
			{
				if (getValueByIndex(parent) < getValueByIndex(child))
				{
					swap(parent, child);
					child = parent;
					parent = getParent(child);
				}else
				{
					break;
				}
			}
			
		}
		public function getLastParent(len:int):int
		{
			return Math.floor(len / 2) - 1;
		}
		
		public function getParent(i:int):int
		{
			return Math.ceil(i / 2) - 1;
		}
		
		public function getLeftChild(i:int):int
		{
			return i * 2 + 1;
		}
		
		/**
		 * 堆顶向下调整
		 * @param	root
		 * @param	end
		 */
		private function adjustHeap(root:int, end:int):void
		{
			var dad:int = root;
			var son:int = getLeftChild(dad);
			while (son < end) { //若子节点指标在范围内才做比较
				if (son + 1 < end && getValueByIndex(son) < getValueByIndex(son + 1)) //先比较两个子节点大小，选择最大的
					son++;
				if (getValueByIndex(dad) > getValueByIndex(son)) //如果父节点大於子节点代表调整完毕，直接跳出函数
					return;
				else { //否则交换父子内容再继续子节点和孙节点比较
					swap(dad, son);
					dad = son;
					son = getLeftChild(dad);
				}
			}
		}
		
	}

}