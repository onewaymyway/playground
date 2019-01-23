package view.actorgame 
{
	import laya.utils.Handler;
	import ui.actorgame.ReportItemUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ReportItem extends ReportItemUI 
	{
		
		public function ReportItem() 
		{
			starList.renderHandler = new Handler(this, itemRender);
		}
		
		private function itemRender(cell:StarItem, index:int):void
		{
			cell.initByData(cell.dataSource);
		}
		
		private var _dataO:Object;
		private var _starList:Array=[];
		public function initByData(dataO:ActorData):void
		{
			_dataO = dataO;
			var opCount:int;
			opCount = dataO.lastOpCount;
			if (opCount > 0)
			{
				changeTxt.text = "+"+opCount + "";
			}else
			{
				changeTxt.text = opCount + "";
			}
			changeTxt.visible = opCount != 0;
			if (dataO.sign)
			{
				icon.skin = "icons/" + dataO.sign + ".png";
			}
			moneyChangeTxt.visible = false;
			var changeMoney:int;
			changeMoney = dataO.getChangeMoney();
			if (changeMoney != 0)
			{
				moneyChangeTxt.text = "钱"+QGameState.getSignedInt(changeMoney);
				moneyChangeTxt.visible = true;
			}
			
			
			var curCount:int;
			curCount = dataO.count;
			_starList.length = dataO.count;
			nameTxt.text = dataO.label;
			var i:int, len:int;
			len = _starList.length;
			for (i = 0; i < len; i++)
			{
				_starList[i] = 0;
			}
			if (opCount > 0)
			{
				for (i = 0; i < opCount; i++)
				{
					_starList[curCount-1-i] = 1;
				}
			}
			if (opCount < 0)
			{
				opCount = -opCount;
				for (i = 0; i < opCount; i++)
				{
					_starList.push(2);
				}
			}
			
			starList.array = _starList;
		}
		
	}

}