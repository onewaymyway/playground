///////////////////////////////////////////////////////////
//  IFrameSprite.as
//  Macromedia ActionScript Implementation of the Class IFrameSprite
//  Created on:      2016-8-12 上午11:35:20
//  Original author: ww
///////////////////////////////////////////////////////////

package platform.extenddisplay
{
	import laya.utils.Browser;
	
	/**
	 * 
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2016-8-12 上午11:35:20
	 */
	public class IFrameSprite extends HtmlSprite
	{
		public function IFrameSprite()
		{
		}
		
		override public function createHtml():void
		{
			div = Browser.createElement("iframe");
			div.style.border = "0px";
		}
		
		public function setUrl(path:String):void
		{
			div.src=path;
		}
		
		private static var _I:IFrameSprite;
		public static function get I():IFrameSprite
		{
			if (!_I) _I = new IFrameSprite();
			return _I;
		}
	}
}