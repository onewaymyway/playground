package laya.effect.effectcontainer 
{
	/**
	 * ...
	 * @author ww
	 */
	public class ParticleDraw extends TextureDraw 
	{
		public var vX:Number = 1;
		public var vY:Number = 1;
		public var life:Number = 3;
		public function ParticleDraw() 
		{
			super();
			enableMt = true;
		}
		override public function update(dt:int):void 
		{
			if (life <= 0)
			{
				dead = true;
				return;
			} 
			x += vX;
			y += vY;
			life-= dt;
		}
	}

}