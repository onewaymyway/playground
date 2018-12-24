package commonlayout.mindmaptree 
{
	
	/**
	 * ...
	 * @author ww
	 */
	public interface IMindMapTreeItem 
	{
		
		function get childNodes():Array;
		function get width():Number;
		function get height():Number;
		function setLayoutPos(x:Number, y:Number):void;
		function get x():Number;
		function get y():Number;
		function recover():void;
		function reset():void;
		function setData(dataO:Object):void;
		function getData():Object;
		
	}
	
}