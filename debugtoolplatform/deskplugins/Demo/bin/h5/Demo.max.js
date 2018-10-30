
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var Text=laya.display.Text;
	/**
	*...
	*@author ww
	*/
	//class TestDemo
	var TestDemo=(function(){
		function TestDemo(){
			Laya.init(1000,900);
			this.test();
		}

		__class(TestDemo,'TestDemo');
		var __proto=TestDemo.prototype;
		__proto.test=function(){
			var text;
			text=new Text();
			text.text="Demo";
			text.color="#ff0000";
			text.fontSize="100";
			text.pos(100,100);
			Laya.stage.addChild(text);
		}

		return TestDemo;
	})()



	new TestDemo();

})(window,document,Laya);
