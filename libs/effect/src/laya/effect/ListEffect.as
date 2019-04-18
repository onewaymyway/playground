package laya.effect 
{
	import laya.ui.Box;
	import laya.ui.List;
	import laya.utils.Ease;
	import laya.utils.Tween;
	/**
	 * ...
	 * @author ww
	 */
	public class ListEffect 
	{
		
		public function ListEffect() 
		{
			
		}
		
		private var _tar:List;
		
		/**
		 * 设置控制对象 
		 * @param tar
		 */		
		public function set target(tar:List):void
		{
			_tar = tar;
		}
		public var tweenTime:Number = 300;
		public var dTime:Number = 100;
		public function play():void
		{
			if (!_tar) return;
			var cells:Array;
			cells = _tar.cells;
			if (!cells || cells.length < 1) return;
			var i:int, len:int;
			len = cells.length;
			var tCell:Box;
			var preX:Number;
			preX = cells[0].x;
			for (i = 0; i < len; i++)
			{
				tCell = cells[i];
				tCell.x = preX + tCell.width + 10;
				Tween.clearAll(tCell);
				Tween.to(tCell, {x:preX} ,tweenTime,Ease.cubicInOut,null,i*dTime);
			}
			
		}
		
	}

}