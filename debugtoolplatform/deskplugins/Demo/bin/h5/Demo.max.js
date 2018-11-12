
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var EditorRenderBase=viewRender.EditorRenderBase,Text=laya.display.Text;
	/**
	*...
	*@author ww
	*/
	//class TestDemo extends viewRender.EditorRenderBase
	var TestDemo=(function(_super){
		function TestDemo(){
			this.text=null;
			this._data=null;
			TestDemo.__super.call(this);
			Laya.init(1000,900);
			this.test();
		}

		__class(TestDemo,'TestDemo',_super);
		var __proto=TestDemo.prototype;
		__proto.test=function(){
			this.text=new Text();
			this.text.text="Demo";
			this.text.color="#ff0000";
			this.text.fontSize=20;
			this.text.pos(100,100);
			Laya.stage.addChild(this.text);
		}

		__proto.getRenderData=function(){
			return this._data;
		}

		__proto.setData=function(data){
			this._data=data;
			_super.prototype.setData.call(this,data);
			this.updateUIContent();
		}

		__proto.updateData=function(data){
			this._data=data;
			_super.prototype.updateData.call(this,data);
			this.updateUIContent();
		}

		__proto.updateUIContent=function(){
			this.text.text=JSON.stringify(this._data);
		}

		return TestDemo;
	})(EditorRenderBase)



	new TestDemo();

})(window,document,Laya);
