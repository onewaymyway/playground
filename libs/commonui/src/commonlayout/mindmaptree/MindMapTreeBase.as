package commonlayout.mindmaptree 
{
	import commontools.EventTools;
	import laya.debug.tools.ClassTool;
	import laya.debug.tools.ObjectTools;
	import laya.events.Event;
	import laya.ui.TextInput;
	import laya.ui.View;
	import laya.utils.ClassUtils;
	import laya.utils.Pool;
	import platform.tools.Notice;
	
	/**
	 * ...
	 * @author ww
	 */
	public class MindMapTreeBase extends View implements IMindMapTreeItem
	{
		protected var _dataO:Object;
		protected var _childNodes:Array;
		public var parentNode:MindMapTreeBase;
		public function MindMapTreeBase() 
		{
			reset();
		}
		
		public function removeFromParent():void
		{
			if (parentNode)
			{
				MindMapViewer.removeChildNode(parentNode, this);
				//Notice.notify("DataChanged");
				EventTools.sendEventOnTree(this, "DataChanged");
			}
		}
		protected function setUpTextInput(input:TextInput, key:String):void
		{
			input.on(Event.BLUR, this, onTextInputChange,[input,key]);
		}
		
		private function onTextInputChange(input:TextInput,key:String):void
		{
			if (_dataO.props[key] == input.text) return;
			_dataO.props[key] = input.text;
			//Notice.notify("DataChanged");
			EventTools.sendEventOnTree(this, "DataChanged");
		}
		public function setLayoutPos(x:Number, y:Number):void
		{
			pos(x, y);
		}
		
		public function recover():void
		{
			reset();
			Pool.recover(ClassTool.getClassName(this),this);
		}
		
		public function get childNodes():Array
		{
			return _childNodes;
		}
		
		public function reset():void
		{
			_childNodes = [];
			pos(0, 0);
		}
		
		public function setData(dataO:Object):void
		{
			_dataO = dataO;
			renderByData();
		}
		
		protected function renderByData():void
		{
			
		}
		
		public function getData():Object
		{
			return _dataO;
		}
		
		public function addChildData(dataO:Object):void
		{
			_dataO.childs.push(ObjectTools.copyObjFast(dataO));
			//Notice.notify(AnswerFlowEvents.DataChanged);
			EventTools.sendEventOnTree(this, "DataChanged");
		}
	}

}