/**Created by the LayaAirIDE,do not modify.*/
package commonui.ui.prop {
	import laya.ui.*;
	import laya.display.*; 
	import commonui.view.prop.PropsInputBase;

    import laya.utils.ClassUtils;
	public class NumberInputUI extends PropsInputBase {
		public var input:TextInput;
		public var leftBtn:Box;
		public var rightBtn:Box;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"PropsInputBase","props":{"width":150,"height":47},"child":[{"type":"TextInput","props":{"var":"input","top":2,"text":"123","skin":"comp/input_32.png","right":24,"padding":"0,10,0,10","left":24,"fontSize":20,"bottom":2,"align":"center","sizeGrid":"0,3,0,3","color":"#CCCCCC","height":32}},{"type":"Box","props":{"width":69,"var":"leftBtn","top":0,"left":0,"bottom":0},"child":[{"type":"Image","props":{"x":0,"skin":"view/arrow_left.png","height":36,"centerY":0}}]},{"type":"Box","props":{"width":71,"var":"rightBtn","top":0,"right":0,"bottom":0},"child":[{"type":"Image","props":{"x":52,"skin":"view/arrow_right.png","right":0,"height":36,"centerY":0}}]}]};
		public function NumberInputUI(){
		createUI(uiView);
		}
		private function createUI(uiData:Object):void
		{

			ClassUtils.createByJson(uiData, this, this);

		}

	}
}