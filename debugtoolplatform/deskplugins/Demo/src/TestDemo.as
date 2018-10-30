package  
{
	import laya.display.Text;
	/**
	 * ...
	 * @author ww
	 */
	public class TestDemo 
	{
		
		public function TestDemo() 
		{
			Laya.init(1000, 900);
			test();
		}
		private function test():void
		{
			var text:Text;
			text = new Text();
			text.text = "Demo";
			text.color = "#ff0000";
			text.fontSize = "100";
			text.pos(100, 100);
			Laya.stage.addChild(text);
		}
		
	}

}