package platform.editzone 
{
	
	import laya.display.Node;
	import laya.ui.Box;
	import nodetools.devices.FileTools;


	/**
	 * 编辑页基类
	 * @author ww
	 */
	public class SceneBase extends Box implements IEditViewer
	{
		
		public function SceneBase() 
		{
			super();
		}
		public function setUp(parent:Node=null):void
		{
			//trace("SceneBase setUp");
		}
		public function save():void
		{
			
		}
		public function open():void
		{
			
		}
		public function clears():void
		{
		}
		public function onActive():void
		{
		}
		public function changeDataO(dataO:Object):void
		{
			
		}
		public function focusDesign():void
		{

		}
		public var data:Object;
		public var _path:String;
		public var _title:String;
		public function get pagePath():String
		{
			// TODO Auto Generated method stub
			return _path;
		}
		
		public function set pagePath(path:String):void
		{
			// TODO Auto Generated method stub
			_path=path;
			_title=FileTools.getFileName(_path);
		}
		public function get canSetPageInfo():Boolean
		{
			return false;
		}
		
		public function get useDesignChangeEvent():Boolean
		{
			return false;
		}
		
		protected var _scaleView:Number=1;
		public function get scaleView():Number
		{
			return _scaleView;
		}
		
		public function set scaleView(value:Number):void
		{
			_scaleView=value;
		}
		
		public function removeSelf():Node
		{

			return null;
		}
		public function dealAction(funName:String, param:Array = null):void
		{
			if (this[funName] is Function)
			{
				this[funName].apply(this,param);
			}
		}
		public function show():void
		{
		}
		public function renderDragDrop(e:DragEvent):void
		{
			
		}
		public function propChange(key:String,data:Object):void
		{
			
		}
		public function onResClick(data:Object):void
		{
			
		}
		
		public function getDesignData():Object
		{

			return {};
		}

		public function get title():String
		{
			// TODO Auto Generated method stub
			return _title;
		}
		
		public var _changed:Boolean;
		public function get hasChange():Boolean
		{
			return _changed;
		}
		
		public function get design():*
		{
			return this;
		}
		
		public function goBack():void
		{
			
		}
		public function goForward():void
		{
			
		}
	}

}