///////////////////////////////////////////////////////////
//  CanvasSpriteContainer.as
//  Macromedia ActionScript Implementation of the Class CanvasSpriteContainer
//  Created on:      2016-8-4 上午9:24:35
//  Original author: ww
///////////////////////////////////////////////////////////

package platform.rendercanvas
{
	import laya.debug.tools.DisControlTool;
	import laya.display.Node;
	import laya.display.Sprite;
	
	/**
	 * 
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2016-8-4 上午9:24:35
	 */
	public class CanvasSpriteContainer extends Sprite
	{
		public function CanvasSpriteContainer()
		{
		}
		public var canvasZIndex:int=100;
		public var autoTop:Boolean=true;
		override public function addChild(node:Node):Node 
		{
			childAddHandler(node);
			return super.addChild(node);
		}
		override public function addChildAt(node:Node, index:int):Node 
		{
			childAddHandler(node);
			return super.addChildAt(node, index);
		}
		override public function removeChild(node:Node):Node 
		{
			removeChildHandler(node);
			return super.removeChild(node);
		}
		override public function removeChildAt(index:int):Node 
		{
			var node:Node = getChildAt(index);
			if (node)
			{
				removeChildHandler(node);
			}
			return super.removeChildAt(index);
		}
		public function childAddHandler(node:Node):void
		{
			if(autoTop)
			{
				DisControlTool.setTop(this);
			}
			CanvasSprite.setSpriteCanvasRender(node as Sprite,canvasZIndex,true);
		}
		public function removeChildHandler(node:Node):void
		{

			CanvasSprite.removeSpriteCanvas(node as Sprite);
		}
	}
}