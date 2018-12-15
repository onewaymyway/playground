/**Created by the LayaAirIDE,do not modify.*/
package commonui.ui.prop {
	import laya.ui.*;
	import laya.display.*; 
	import commonui.view.prop.PropsInputBase;

    import laya.utils.ClassUtils;
	public class PropTextInputUI extends PropsInputBase {
		public var input:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"PropsInputBase","props":{"width":150,"height":47},"child":[{"type":"Label","props":{"var":"input","valign":"middle","top":0,"text":"111","styleSkin":"comp/input_32.png","right":0,"mouseEnabled":false,"left":0,"fontSize":30,"editable":false,"color":"#000000","bottom":0,"sizeGrid":"0,3,0,3","padding":"0,4,0,4","height":32}}]};
		public function PropTextInputUI(){
		createUI(uiView);
		}
		private function createUI(uiData:Object):void
		{

			ClassUtils.createByJson(uiData, this, this);

		}

	}
}