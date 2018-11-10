///////////////////////////////////////////////////////////
//  LayerManager.as
//  Macromedia ActionScript Implementation of the Class LayerManager
//  Created on:      2015-12-25 上午10:19:18
//  Original author: ww
///////////////////////////////////////////////////////////

package platform.managers
{
	import laya.display.Sprite;
	import laya.display.Stage;
	import laya.ui.Box;
	import laya.utils.Browser;
	
	/**
	 * 
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2015-12-25 上午10:19:18
	 */
	public class LayerManager
	{
		public function LayerManager()
		{
		}
		public static var stage:Box;
		public static function init():void
		{
			stage=new Box();
			//stage.left=0;
			//stage.right=0;
			//stage.top=0;
			//stage.bottom=0;
			stage.mouseEnabled=true;
			Laya.stage.addChild(stage);
			
			Laya.stage.on("resize", null, onStage);
		}
		
		public static const minWidth:int=900;
		public static const minHeight:int=700;
		static private function onStage():void {
			if (Browser.pixelRatio != 1) {
				Laya.stage._width = Browser.clientWidth;
				Laya.stage._height = Browser.clientHeight;
				Laya.stage.scale(Browser.pixelRatio, Browser.pixelRatio);
			}
			stage.width = Laya.stage._width>minWidth?Laya.stage._width:minWidth;
			stage.height = Laya.stage._height>minHeight?Laya.stage._height:minHeight;
			stage.height-=1;
			stage.width+=2;
		}
	}
}