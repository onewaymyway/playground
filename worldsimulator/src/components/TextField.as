package components 
{
	import laya.ui.Label;
	import laya.events.Event;
	
	/**
	 * TextField封装
	 * @author ww
	 */
	public class TextField extends Label 
	{
		
		public function TextField(text:String="") 
		{
			super(text);
			
		}
		public override function set text(value:String):void {
			if (_tf.text != value) {
				_tf.text = value;
//				_tf.updateText();
				_tf.typeset();
				event(Event.CHANGE);
			}
		}
		
		public override function get width():Number
		{
//			trace("textWidth:",_tf.textWidth);
			return _tf.textWidth;
		}
	}

}