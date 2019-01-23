package view.actorgame 
{
	/**
	 * ...
	 * @author ww
	 */
	public class ActorData 
	{
		public var count:int = 0;
		public var lastOpCount:int = 0;
		public var label:String;
		public var sign:String;
		public var lowCount:int=0;
		public var highCount:int = 0;
		public var tooHighCount:int = 0;
		public var questions:Array = [];
		public var lowActions:Array = [];
		public var highActions:Array = [];
		public var tooHighActions:Array = [];
		public function ActorData() 
		{
			
		}
		
		public function reset():void
		{
			lowCount = 0;
			highCount = 0;
		}
		
		public function next():void
		{
			if (count < 3)
			{
				lowCount++;
			}else
			{
				lowCount = 0;
			}
			if(count>=15)
			{
				highCount++;
			}else
			{
				highCount = 0;
			}
			
			if (count >= 17)
			{
				tooHighCount++;
			}else
			{
				tooHighCount = 0;
			}
		}
		
		public function getRandomQuestion():Object
		{
			var index:int;
			index = Math.round(Math.random() * 9999999);
			return questions[index%questions.length];
		}
		
		public function getRandomFromArr(arr:Array):Object
		{
			if (arr.length == 1) return arr[0];
			var index:int;
			index = Math.round(Math.random() * 9999999);
			return arr[index%arr.length];
		}
		
		public function getChangeMoney():int
		{
			if (count > 10) return (count-10)*1000;
			if (count <3) return -(3-count)*3000;
			return 0;
		}
		
		private function getIsRandomOK():Boolean
		{
			return Math.random() < 0.3;
		}
		
		public function getAction():Object
		{
			
			if (tooHighCount >= 4&&getIsRandomOK())
			{
				tooHighCount = 0;
				if (tooHighActions.length > 0)
				{
					//highCount = 0;
					return getRandomFromArr(tooHighActions);
				}
				
			}
			
			if (lowCount >= 5&&getIsRandomOK())
			{
				lowCount = 0;
				if (lowActions.length > 0)
				{
					return getRandomFromArr(lowActions);
				}
				
			}
			if (highCount >= 5&&getIsRandomOK())
			{
				highCount = 0;
				if (highActions.length > 0)
				{
					tooHighCount = 0;
					return getRandomFromArr(highActions);
				}
				
			}
			
			return null;
		}
		
		public function clearState():void
		{
			lowCount = 0;
			highCount = 0;
		}
		
	}

}