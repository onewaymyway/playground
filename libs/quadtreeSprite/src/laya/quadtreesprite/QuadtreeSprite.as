package laya.quadtreesprite
{
	import laya.display.Node;
	import laya.display.Sprite;
	import laya.maths.Rectangle;
	import laya.quadtreesprite.quadtree.Quadtree;
	import laya.quadtreesprite.quadtree.QuadtreeNode;
	import laya.renders.RenderContext;
	
	public class QuadtreeSprite extends Sprite
	{
		private var _quadtree:Quadtree;
		private var _viewport:Rectangle;
		private var _children:Vector.<Sprite>;
		
		private var _childrenPositions:Object;
		
		private var _dirty:Boolean;
		
		public function QuadtreeSprite(worldSpace:Rectangle, maintainOrder:Boolean = false)
		{
			_quadtree = new Quadtree(worldSpace.x, worldSpace.y, worldSpace.right, worldSpace.bottom);
			_viewport = worldSpace.clone();
			_children = new Vector.<Sprite>();
			
			if (maintainOrder)
				_childrenPositions = {};
			
			_dirty = true;
		}
		
		override public function render(context:RenderContext, x:Number, y:Number):void
		{
			refresh()
			super.render(context, x, y);
		}
		
		//override public function render(support:RenderSupport, parentAlpha:Number):void
		//{
		//refresh();
		//super.render(support, parentAlpha);
		//}
		
		public function updateChild(child:*):void
		{
			// TODO Is it better to save them in a set and update them at the time when the refresh is called?
			// Solves the problem of updating a child multiple times per frame.
			
			_quadtree.update(child, child.bounds);
			_dirty = true;
		}
		
		override public function addChild(child:Node):Node
		{
			addChildAt(child as Sprite, this.dynamicNumChildren);
			return child;
		}
		
		override public function addChildAt(child:Node, index:int):Node
		{
			// No need to set the dirty, we can just check if the object intersects.
			var tChild:QuadtreeNode;
			tChild=(child as QuadtreeNode);
			if (_viewport.intersects(tChild.bounds))
				super.addChildAt(child, this.numChildren);
			
			if (_childrenPositions)
			{
				_children.splice(index, 0, child);
				
				for (var i:int = index; i < _children.length; i++)
					_childrenPositions[Quadtree.getObjKey(_children[i])] = i;
				
				this.invalidate();
			}
			else
			{
				// Don't care about the order
				_children.push(child);
			}
			
			_quadtree.insert(child, tChild.bounds);
			
			// TODO Can this be removed?
			_dirty = true;
			
			return child;
		}
		
		public function get dynamicNumChildren():int
		{
			return _children.length;
		}
		
		public function dynamicGetChildAt(index:int):Sprite
		{
			return _children[index];
		}
		
		override public function removeChild(child:Node):Node
		{
			var index:int = _children.indexOf(child as Sprite);
			_children.splice(index, 1);
			
			_quadtree.remove(child);
			
			if (_childrenPositions)
				delete _childrenPositions[Quadtree.getObjKey(child)];
			
			// to remove the need for refresh, remove the child from the container if it's there
			if (this.contains(child))
				super.removeChild(child);
			
			return child;
		}
		
		public function refresh():void
		{
			if (!_dirty)
				return;
			
			_dirty = false;
			
			this.removeChildren();
			
			var visibleObjects:Vector.<Object> = _quadtree.objectsInRectangle(_viewport);
			
			// To maintain the order sort children by their insertion index
			if (_childrenPositions)
			{
				visibleObjects.sort(function(first:Object, second:Object):Number
					{
						return _childrenPositions[Quadtree.getObjKey(first)] - _childrenPositions[Quadtree.getObjKey(second)];
					});
			}
			
			for each (var visibleObject:Sprite in visibleObjects)
			{
				super.addChildAt(visibleObject, this.numChildren);
			}
		
			//this.dispatchEventWith(Event.CHANGE);
		}
		
		public function get visibleViewport():Rectangle
		{
			return _viewport;
		}
		
		public function set visibleViewport(viewport:Rectangle):void
		{
			if (viewport.equals(_viewport))
				return;
			
			_viewport = viewport.clone();
			_dirty = true;
		}
		
		public function get dirty():Boolean
		{
			return _dirty;
		}
		
		public function invalidate():void
		{
			_dirty = true;
		}
	
	}
}
