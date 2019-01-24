
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var Button=laya.ui.Button,ContextMenu=laya.debug.uicomps.ContextMenu,ContextMenuItem=laya.debug.uicomps.ContextMenuItem;
	var EditorRenderBase=viewRender.EditorRenderBase,Event=laya.events.Event,Handler=laya.utils.Handler,Image=laya.ui.Image;
	var Loader=laya.net.Loader,MindMapTreeBase=commonlayout.mindmaptree.MindMapTreeBase,Stage=laya.display.Stage;
	var Tab=laya.ui.Tab,Text=laya.display.Text,View=laya.ui.View;
	/**
	*...
	*@author ww
	*/
	//class test.MakeAnsFlowFile
	var MakeAnsFlowFile=(function(){
		function MakeAnsFlowFile(){}
		__class(MakeAnsFlowFile,'test.MakeAnsFlowFile');
		var __proto=MakeAnsFlowFile.prototype;
		__proto.test=function(){
			Laya.loader.load("rules.json",Handler.create(this,this.onLoaded));
		}

		__proto.onLoaded=function(dataO){
			debugger;
			this.parseRulesToAnsFlowFile(dataO);
		}

		__proto.parseRulesToAnsFlowFile=function(dataO){
			var rules;
			rules=dataO.rules;
			var i=0,len=0;
			len=rules.length;
			var actions;
			actions=[];
			for (i=0;i < len;i++){
				actions.push(this.parseOneAction(rules[i]));
			}
			debugger;
			var dataStore;
			dataStore={};
			dataStore.type="AutoCreate";
			dataStore.actions=actions;
			nodetools.devices.FileManager.createJSONFile(nodetools.devices.FileManager.getAppPath("files/Life.ansflow"),dataStore);
		}

		__proto.parseOneAction=function(actionO){
			var rst;
			rst=answerflow.AnswerFlowEditor.createActionData();
			var actionData;
			actionData=rst.data;
			actionData.props.des=actionO.tip;
			actionData.props.label=actionO.name;
			this.parseItemsToArr(actionO.solve.add,actionData.childs[1].childs[0].childs);
			this.parseItemsToArr(actionO.solve.sub,actionData.childs[1].childs[1].childs);
			return rst;
		}

		__proto.parseItemsToArr=function(arr,rstArr){
			if (!arr)return;
			if (!rstArr)return;
			var i=0,len=0;
			len=arr.length;
			for (i=0;i < len;i++){
				rstArr.push(this.parseOneItem(arr[i]));
			}
		}

		__proto.createOneItem=function(name,count){
			var rst;
			rst={
				"type":"ItemData",
				"props":{item:name,count:count },
				"childs":[]
			};
			return rst;
		}

		__proto.parseOneItem=function(item){
			if ((typeof item=='string')){
				return this.createOneItem(item,1);
			}
			if ((item instanceof Array)){
				return this.createOneItem(item[0],item[1]?item[1]:1);
			}
		}

		return MakeAnsFlowFile;
	})()


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
			this.mindMapEditor=new RelationMapEditor();
			this.mindMapEditor.left=this.mindMapEditor.right=this.mindMapEditor.top=this.mindMapEditor.bottom=2;
			this.mindMapEditor.on("save",this,this.onMindMapSave);
			Laya.stage.addChild(this.mindMapEditor);
			this.updateUIContent();
		}

		//testMakeAnsFlowFile();
		__proto.testMakeAnsFlowFile=function(){
			var tt;
			tt=new MakeAnsFlowFile();
			tt.test();
		}

		__proto.onMindMapSave=function(){
			nodetools.devices.FileManager.createJSONFile(this._data.url,this._data.data);
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
			if (!this._data || !this.mindMapEditor)return;
			this.mindMapEditor.setEditType(nodetools.devices.FileTools.getExtensionName(this._data.url));
			this.mindMapEditor.setData(this._data.data);
			this.text.text=JSON.stringify(this._data);
		}

		return TestDemo;
	})(EditorRenderBase)


	//class ui.relationmap.RelationMapEditorUI extends laya.ui.View
	var RelationMapEditorUI=(function(_super){
		function RelationMapEditorUI(){
			this.saveBtn=null;
			this.optionTab=null;
			this.container=null;
			RelationMapEditorUI.__super.call(this);
		}

		__class(RelationMapEditorUI,'ui.relationmap.RelationMapEditorUI',_super);
		var __proto=RelationMapEditorUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(RelationMapEditorUI.uiView);
		}

		RelationMapEditorUI.uiView={"type":"View","props":{"width":600,"height":600},"child":[{"type":"Button","props":{"var":"saveBtn","top":12,"skin":"comp/button.png","right":5,"label":"save"}},{"type":"Tab","props":{"y":10,"x":15,"width":242,"var":"optionTab","skin":"comp/tab.png","labels":"操作,节点,线","labelColors":"#ffffff","height":24}},{"type":"Image","props":{"width":600,"var":"container","top":50,"skin":"comp/blank2.png","sizeGrid":"7,13,9,9","right":0,"left":0,"height":540,"bottom":0}}]};
		return RelationMapEditorUI;
	})(View)


	/**
	*...
	*@author ww
	*/
	//class relationmap.RelationMapEditor extends ui.relationmap.RelationMapEditorUI
	var RelationMapEditor=(function(_super){
		function RelationMapEditor(){
			this.dataO=null;
			RelationMapEditor.__super.call(this);
			this.saveBtn.on("click",this,this.onSaveBtn);
		}

		__class(RelationMapEditor,'relationmap.RelationMapEditor',_super);
		var __proto=RelationMapEditor.prototype;
		__proto.onSaveBtn=function(){
			this.event("save");
		}

		__proto.setData=function(dataO){
			this.dataO=dataO;
			this.freshUI();
		}

		__proto.freshUI=function(){}
		return RelationMapEditor;
	})(RelationMapEditorUI)



	new TestDemo();

})(window,document,Laya);
