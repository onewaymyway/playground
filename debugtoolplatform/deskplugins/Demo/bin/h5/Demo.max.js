
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var ContextMenu=laya.debug.uicomps.ContextMenu,ContextMenuItem=laya.debug.uicomps.ContextMenuItem;
	var DebugPanel=laya.debug.DebugPanel,EditorRenderBase=viewRender.EditorRenderBase,Event=laya.events.Event;
	var Handler=laya.utils.Handler,Loader=laya.net.Loader,Stage=laya.display.Stage,Text=laya.display.Text,View=laya.ui.View;
	/**
	*...
	*@author ww
	*/
	//class TestDemo extends viewRender.EditorRenderBase
	var TestDemo=(function(_super){
		function TestDemo(){
			this.text=null;
			this.mindMapEditor=null;
			this._data=null;
			TestDemo.__super.call(this);
			Laya.init(1000,900);
			Laya.stage.scaleMode="full";
			ContextMenu.init();
			ContextMenuItem.labelColors="#ffffff,#ffffff,#ffffff,#ffffff";
			ContextMenuItem.btnSkin="comp/button.png";
			var resList;
			resList=[ {"url":"res/atlas/comp.json","type":"atlas" }];
			Laya.loader.load(resList,new Handler(this,this.test));
			DebugPanel.init();
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
			this.mindMapEditor=new MindMapEditor();
			this.mindMapEditor.left=this.mindMapEditor.right=this.mindMapEditor.top=this.mindMapEditor.bottom=2;
			Laya.stage.addChild(this.mindMapEditor);
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
			this.mindMapEditor.setData(this._data);
			this.text.text=JSON.stringify(this._data);
		}

		return TestDemo;
	})(EditorRenderBase)


	//class ui.mindmap.MindMapEditorUI extends laya.ui.View
	var MindMapEditorUI=(function(_super){
		function MindMapEditorUI(){MindMapEditorUI.__super.call(this);;
		};

		__class(MindMapEditorUI,'ui.mindmap.MindMapEditorUI',_super);
		var __proto=MindMapEditorUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(MindMapEditorUI.uiView);
		}

		MindMapEditorUI.uiView={"type":"View","props":{"width":400,"height":300},"child":[{"type":"Button","props":{"top":5,"skin":"comp/button.png","right":5,"label":"保存"}}]};
		return MindMapEditorUI;
	})(View)


	/**
	*...
	*@author ww
	*/
	//class mindmap.MindMapEditor extends ui.mindmap.MindMapEditorUI
	var MindMapEditor=(function(_super){
		function MindMapEditor(){
			this._menu=null;
			this._dataO=null;
			MindMapEditor.__super.call(this);
			this._menu=ContextMenu.createMenuByArray(["新建"]);
			this._menu.on("select",this,this.onSelect);
			this.on("rightmouseup",this,this.onRightClick);
		}

		__class(MindMapEditor,'mindmap.MindMapEditor',_super);
		var __proto=MindMapEditor.prototype;
		__proto.onRightClick=function(){
			this._menu.show();
		}

		__proto.onSelect=function(dataO){
			console.log("onMenuSelect:",dataO);
			var label;
			label=dataO.target.data;
			console.log("Menu:",label);
			switch(label){
				}
		}

		__proto.setData=function(dataO){
			this._dataO=dataO;
			this.freshUI();
		}

		__proto.freshUI=function(){}
		return MindMapEditor;
	})(MindMapEditorUI)



	new TestDemo();

})(window,document,Laya);
