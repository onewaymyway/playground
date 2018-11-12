package platform.editzone 
{
	import laya.display.Node;
	
	/**
	 * ...
	 * @author ww
	 */
	public interface IEditViewer 
	{
		 function removeSelf():Node;
		 function save():void;
		 function get pagePath():String;
		 function set pagePath(path:String):void;
		 function get title():String;
		 function show():void;
		 function clears():void;
		 function onActive():void;
		 function get hasChange():Boolean;
		 function dealAction(funName:String, param:Array = null):void;
		 function get canSetPageInfo():Boolean;
		 function get useDesignChangeEvent():Boolean;
		 function getDesignData():Object;
		 function get design():*;
		 function changeDataO(dataO:Object):void;
		 function get scaleView():Number;
		 function set scaleView(value:Number):void;
		 function focusDesign():void;
		 
	}
	
}