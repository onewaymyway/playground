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
		public var lowCount:int=0;
		public var highCount:int = 0;
		public var questions:Array=[];
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
			if (count <= 3)
			{
				lowCount++;
				highCount = 0;
			}else
			if(count>=10)
			{
				highCount++;
				lowCount = 0;
			}else
			{
				lowCount = 0;
				highCount = 0;
			}
		}
		
		public function getRandomQuestion():Object
		{
			var index:int;
			index = Math.round(Math.random() * 9999999);
			return questions[index%questions.length];
		}
		
		public function getChangeMoney():int
		{
			if (count > 10) return (count-10)*1000;
			if (count <3) return -(3-count)*3000;
			return 0;
		}
		
	}

}