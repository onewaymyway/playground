package laya.effect 
{
	/**
	 * ...
	 * @author ww
	 */
	public class EraseCircleShowEffect extends EraseLineShowEffect 
	{
		
		public function EraseCircleShowEffect() 
		{
			super();
			
		}
		override protected function loop():void 
		{
			blendSp.graphics.drawCircle(_rec.x + Math.random() * _rec.width, _rec.y + _rec.height * Math.random(), 5 + 20 * Math.random(), "#ff0000");
			blendSp.graphics.drawCircle(_rec.x + Math.random() * _rec.width, _rec.y + _rec.height * Math.random(), 5 + 20 * Math.random(), "#ff0000");
			_tar.mask = null;
			_tar.mask = blendSp;
		}
	}

}