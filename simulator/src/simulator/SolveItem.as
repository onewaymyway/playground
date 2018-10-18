package simulator {
	
	/**
	 * ...
	 * @author ww
	 */
	public class SolveItem {
		public var add:Array;
		public var sub:Array;
		public var name:String;
		public var tip:String;
		
		public function SolveItem() {
		
		}
		public static function createByData(dataO:Object):Object
		{
			var item:SolveItem;
			item = new SolveItem();
			item.initByData(dataO);
			return item;
		}
		public function initByData(dataO:Object):void {
			this.name = dataO.name;
			this.tip = dataO.tip;
			this.add = getAdptOpList(dataO.solve.add);
			this.sub = getAdptOpList(dataO.solve.sub);
		}
		
		private function getAdptOpList(opList:Array):Array {
			var i:int, len:int;
			var rst:Array;
			rst = [];
			var tObject:Object;
			var tSolveItem:*;
			len = opList.length;
			for (i = 0; i < len; i++) {
				tSolveItem = opList[i];
				tObject = {};
				if (tSolveItem is String) {
					tObject.name = tSolveItem;
					tObject.count = 1;
					
				}
				else if (tSolveItem is Array) {
					if (tSolveItem.length > 1) {
						tObject.name = tSolveItem[0];
						tObject.count = tSolveItem[1];
						
					}
					else {
						tObject.name = tSolveItem[0];
						tObject.count = 1;
						
					}
				}
				rst.push(tObject);
			}
			return rst;
		}
	}

}