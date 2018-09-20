/**Created by the LayaAirIDE,do not modify.*/
package remotedebugtool.ui.test {
	import laya.ui.*;
	import laya.display.*; 

	public class TestPageUI extends View {
		public var btn:Button;
		public var clip:Clip;
		public var combobox:ComboBox;
		public var tab:Tab;
		public var list:List;
		public var btn2:Button;
		public var check:CheckBox;
		public var radio:RadioGroup;
		public var box:Box;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","child":[{"props":{"x":0,"y":0,"skin":"comp/bg.png","sizeGrid":"30,4,4,4","width":600,"height":400,"compId":3},"type":"Image","compId":3},{"props":{"x":41,"y":56,"skin":"comp/button.png","label":"点我赋值","width":150,"height":37,"sizeGrid":"4,4,4,4","var":"btn","compId":2},"type":"Button","compId":2},{"props":{"x":401,"y":56,"skin":"comp/clip_num.png","clipX":10,"var":"clip","compId":4},"type":"Clip","compId":4},{"props":{"x":220,"y":143,"skin":"comp/combobox.png","labels":"select1,select2,selecte3","selectedIndex":1,"sizeGrid":"4,20,4,4","width":200,"height":23,"var":"combobox","compId":5},"type":"ComboBox","compId":5},{"props":{"x":220,"y":96,"skin":"comp/tab.png","labels":"tab1,tab2,tab3","var":"tab","compId":8},"type":"Tab","compId":8},{"props":{"x":259,"y":223,"skin":"comp/vscroll.png","height":150,"compId":10},"type":"VScrollBar","compId":10},{"props":{"x":224,"y":223,"skin":"comp/vslider.png","height":150,"compId":11},"type":"VSlider","compId":11},{"type":"List","compId":19,"child":[{"type":"Box","compId":30,"child":[{"props":{"skin":"comp/label.png","text":"this is a list","x":26,"y":5,"width":78,"height":20,"fontSize":14,"name":"label","compId":31},"type":"Label","compId":31},{"props":{"x":0,"y":2,"skin":"comp/clip_num.png","clipX":10,"name":"clip","compId":32},"type":"Clip","compId":32}],"props":{"name":"render","x":0,"y":0,"width":112,"height":30,"compId":30},"components":[]}],"props":{"x":452,"y":68,"width":128,"height":299,"vScrollBarSkin":"comp/vscroll.png","repeatX":1,"var":"list","compId":19},"components":[]},{"props":{"x":563,"y":4,"skin":"comp/btn_close.png","name":"close","compId":20},"type":"Button","compId":20},{"props":{"x":41,"y":112,"skin":"comp/button.png","label":"点我赋值","width":150,"height":66,"sizeGrid":"4,4,4,4","labelSize":30,"labelBold":true,"var":"btn2","compId":21},"type":"Button","compId":21},{"props":{"x":220,"y":188,"skin":"comp/checkbox.png","label":"checkBox1","var":"check","compId":22},"type":"CheckBox","compId":22},{"props":{"x":220,"y":61,"skin":"comp/radiogroup.png","labels":"radio1,radio2,radio3","var":"radio","compId":27},"type":"RadioGroup","compId":27},{"type":"Panel","compId":33,"child":[{"props":{"skin":"comp/image.png","compId":34},"type":"Image","compId":34}],"props":{"x":299,"y":223,"width":127,"height":150,"vScrollBarSkin":"comp/vscroll.png","compId":33},"components":[]},{"props":{"x":326,"y":188,"skin":"comp/checkbox.png","label":"checkBox2","labelColors":"#ff0000","compId":35},"type":"CheckBox","compId":35},{"type":"Box","compId":36,"child":[{"props":{"y":70,"skin":"comp/progress.png","width":150,"height":14,"sizeGrid":"4,4,4,4","name":"progress","compId":37},"type":"ProgressBar","compId":37},{"props":{"y":103,"skin":"comp/label.png","text":"This is a Label","width":137,"height":26,"fontSize":20,"name":"label","compId":38},"type":"Label","compId":38},{"props":{"y":148,"skin":"comp/textinput.png","text":"textinput","width":150,"name":"input","compId":39},"type":"TextInput","compId":39},{"props":{"skin":"comp/hslider.png","width":150,"name":"slider","compId":40},"type":"HSlider","compId":40},{"props":{"y":34,"skin":"comp/hscroll.png","width":150,"name":"scroll","compId":41},"type":"HScrollBar","compId":41}],"props":{"x":41,"y":197,"var":"box","compId":36},"components":[]}],"props":{"width":600,"height":400,"compId":1,"__$fileRefer":"D:/codes/playground.git/trunk/remotedebugtool/client/Demo/laya/pages/test/TestPage.ui"},"compId":1,"loadList":["comp/bg.png","comp/button.png","comp/clip_num.png","comp/combobox.png","comp/tab.png","comp/vscroll.png","comp/vslider.png","comp/label.png","comp/btn_close.png","comp/checkbox.png","comp/radiogroup.png","comp/image.png","comp/progress.png","comp/textinput.png","comp/hslider.png","comp/hscroll.png"],"loadList3D":[],"components":[]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}