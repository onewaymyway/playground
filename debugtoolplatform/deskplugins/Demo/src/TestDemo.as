package  
{
	import laya.display.Text;
	import viewRender.EditorRenderBase;
	/**
	 * ...
	 * @author ww
	 */
	public class TestDemo extends EditorRenderBase
	{
		
		public function TestDemo() 
		{
			Laya.init(1000, 900);
			test();
		}
		private var text:Text;
		private function test():void
		{
			
			text = new Text();
			text.text = "Demo";
			text.color = "#ff0000";
			text.fontSize = 20;
			text.pos(100, 100);
			Laya.stage.addChild(text);
		}
		
		private var _data:Object;
		override public function getRenderData():Object 
		{
			return _data;
		}
		
		override public function setData(data:Object):void 
		{
			_data = data;
			super.setData(data);
			updateUIContent();
		}
		
		override public function updateData(data:Object):void 
		{
			_data = data;
			super.updateData(data);
			updateUIContent();
		}
		
		
		private function updateUIContent():void
		{
			text.text = JSON.stringify(_data);
		}
	}

}