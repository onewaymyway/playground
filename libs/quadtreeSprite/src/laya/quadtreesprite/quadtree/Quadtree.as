package laya.quadtreesprite.quadtree
{
	import laya.maths.Point;
	import laya.maths.Rectangle;

    public class Quadtree
    {
        private var _root:QuadtreeNode;

        private var _bounds:Rectangle;
        private var _minimumBounds:Point;

        private var _objectNodeMapping:Object;
		
		private static var _id:int = 1;
		public static const idKey:String = "ObjKey";
		public static function getObjKey(obj:Object):int
		{
			if (!obj[idKey])
			{
				_id++;
				obj[idKey] = _id;
			}
			return obj[idKey];
		}

        public function Quadtree(minX:Number, minY:Number, maxX:Number, maxY:Number, minimumSize:Number = 100)
        {
            _bounds = new Rectangle(minX, minY, maxX - minX, maxY - minY);
            _minimumBounds = new Point(minimumSize, minimumSize);

            _root = new QuadtreeNode(_bounds, _minimumBounds);

            _objectNodeMapping = {};

        }

        public function insert(object:Object, bounds:Rectangle):Boolean
        {
            var targetQuadtreeNode:QuadtreeNode = _root.insert(object, bounds);

            if (targetQuadtreeNode) {
                _objectNodeMapping[getObjKey(object)] = targetQuadtreeNode;
            }

            return targetQuadtreeNode != null;
        }

        public function nodeForObject(object:Object):QuadtreeNode
        {
            return _objectNodeMapping[getObjKey(object)];
        }

        public function remove(object:Object):Boolean
        {
            var node:QuadtreeNode = _objectNodeMapping[getObjKey(object)];

            /// Object not found
            if (!node) return false;

            node.removeObject(object);

            delete _objectNodeMapping[getObjKey(object)];

            return true;
        }

        public function update(object:Object, bounds:Rectangle):void
        {
            const wasRemoved:Boolean = this.remove(object);
            if (!wasRemoved) {
                throw new Error("Can't update object which has not been added to Quadtree.");
            }
            this.insert(object, bounds);
        }

        public function objectsInRectangle(rectangle:Rectangle):Vector.<Object>
        {
            return _root.objectInBounds(rectangle);
        }

        public function get root():QuadtreeNode
        {
            return _root;
        }
    }
}
