package view.actorgame 
{
	import laya.debug.tools.ObjectTools;
	/**
	 * ...
	 * @author ww
	 */
	public class QGameDataManager 
	{
		private var _dataO:Object;
		public static var I:QGameDataManager;
		public function QGameDataManager() 
		{
			
		}
		
		private var _roles:Array;
		private var _questions:Array;
		public function get roles():Array
		{
			return _roles;
		}
		public function setUpByData(dataO:Object):void
		{
			_dataO = dataO;
			//debugger;
			_roles = [];
			_roles = dataO.items;
			_questions = getAdptQuestions(dataO.actions);
			//debugger;
		}
		
		public function get questions():Array
		{
			return _questions;
		}
		public function getRandomQuestion():Object
		{
			var index:int;
			index = Math.round(Math.random() * 9999999);
			return _questions[index%_questions.length];
		}
		
		private function getAdptQuestions(qList:Array):Array
		{
			var rst:Array;
			rst = [];
			
			var i:int, len:int;
			len = qList.length;
			var tQestionO:Object;
			for (i = 0; i < len; i++)
			{
				tQestionO = qList[i];
				if (tQestionO.type == "addnew") continue;
				rst.push(getAdptQuestion(qList[i]));
			}
			return rst;
		}
		
		private function getAdptQuestion(qO:Object):Object
		{
			//debugger;
			var tQData:Object;
			tQData = qO.data;
			var rst:Object;
			rst = { };
			rst.label = tQData.props.label;
			var actorDic:Object;
			actorDic = { };
			rst.ops = getSelections(tQData.childs[0].childs, actorDic);
			rst.actorDic = actorDic;
			
			return rst;
		}
		
		private function getSelections(selectList:Array,actorDic:Object):Array
		{
			var i:int, len:int;
			len = selectList.length;
			var rst:Array;
			rst = [];
			for (i = 0; i < len; i++)
			{
				rst.push(getAdptSelection(selectList[i],actorDic));
			}
			return rst;
		}
		
		private function getAdptSelection(selectO:Object,actorDic:Object):Object
		{
			//debugger;
			var rst:Object;
			rst = { };
			rst.label = selectO.props.label;
			rst.ops = getItemOps(selectO.childs,actorDic);
			
			return rst;
		}
		
		private function getItemOps(itemList:Array,actorDic:Object):Array
		{
			var i:int, len:int;
			len = itemList.length;
			var rst:Array;
			rst = [];
			for (i = 0; i < len; i++)
			{
				rst.push(getAdptItemOp(itemList[i],actorDic));
			}
			return rst;
		}
		
		private function getAdptItemOp(itemOp:Object,actorDic:Object):Object
		{
			var rst:Object;
			rst = { };
			rst.item = itemOp.props.item;
			actorDic[rst.item] = true;
			rst.count = parseInt(itemOp.props.count)||0;
			return rst;
		}
		
		public static function initData(dataO:Object):void
		{
			I = new QGameDataManager();
			I.setUpByData(dataO);
		}
		
	}

}