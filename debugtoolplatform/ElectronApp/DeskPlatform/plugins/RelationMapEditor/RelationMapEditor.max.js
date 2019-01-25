
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var AutoScrollRecBox=commonlayout.AutoScrollRecBox,Button=laya.ui.Button,CommonInput=commoncomponent.CommonInput;
	var ContextMenu=laya.debug.uicomps.ContextMenu,ContextMenuItem=laya.debug.uicomps.ContextMenuItem,EditorRenderBase=viewRender.EditorRenderBase;
	var Event=laya.events.Event,EventTools=commontools.EventTools,Graphics=laya.display.Graphics,Handler=laya.utils.Handler;
	var Image=laya.ui.Image,Loader=laya.net.Loader,MindMapTreeBase=commonlayout.mindmaptree.MindMapTreeBase,Point=laya.maths.Point;
	var Radio=laya.ui.Radio,RelationMapItemBase=commonlayout.relationmap.RelationMapItemBase,RelationMapViewer=commonlayout.relationmap.RelationMapViewer;
	var Stage=laya.display.Stage,Tab=laya.ui.Tab,Text=laya.display.Text,View=laya.ui.View;
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


	//class ui.relationmap.RelationLineUI extends commonlayout.relationmap.RelationMapItemBase
	var RelationLineUI=(function(_super){
		function RelationLineUI(){
			this.input=null;
			this.startPoint=null;
			this.endPoint=null;
			RelationLineUI.__super.call(this);
		}

		__class(RelationLineUI,'ui.relationmap.RelationLineUI',_super);
		var __proto=RelationLineUI.prototype;
		__proto.createChildren=function(){
			View.regComponent("commoncomponent.CommonInput",CommonInput);
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(RelationLineUI.uiView);
		}

		RelationLineUI.uiView={"type":"RelationMapItemBase","props":{"width":95,"height":22},"child":[{"type":"TextInput","props":{"width":95,"var":"input","text":"物品","skin":"comp/input_22.png","runtime":"commoncomponent.CommonInput","promptColor":"#f31713","height":22,"color":"#e80d09"}},{"type":"Radio","props":{"y":-29,"x":-35,"var":"startPoint","skin":"comp/radio.png"}},{"type":"Radio","props":{"y":-43,"x":120,"var":"endPoint","skin":"comp/radio.png"}}]};
		return RelationLineUI;
	})(RelationMapItemBase)


	/**
	*...
	*@author ww
	*/
	//class relationmap.RelationMapEditor extends ui.relationmap.RelationMapEditorUI
	var RelationMapEditor=(function(_super){
		function RelationMapEditor(){
			this.editorBox=null;
			this.mapViewer=null;
			this.dataO=null;
			this._tLine=null;
			this._lineStart=null;
			this._lineEnd=null;
			RelationMapEditor.__super.call(this);
			this.optionTab.selectedIndex=0;
			this.saveBtn.on("click",this,this.onSaveBtn);
			this.optionTab.on("change",this,this.onOpTypeChange);
			this.editorBox=new AutoScrollRecBox();
			this.container.addChild(this.editorBox);
			this.mapViewer=new RelationMapViewer();
			this.editorBox.addChild(this.mapViewer);
			this.mapViewer.itemCreater.regItemClassList([RelationLine,RelationNode]);
			this.mapViewer.hitTestPrior=false;
			this.mapViewer.size(1,1);
			this.editorBox.left=this.editorBox.right=this.editorBox.top=this.editorBox.bottom=1;
			this.editorBox.on("click",this,this.onMapMouseDown);
			this.editorBox.on("ItemClicked",this,this.onItemClick);
		}

		__class(RelationMapEditor,'relationmap.RelationMapEditor',_super);
		var __proto=RelationMapEditor.prototype;
		__proto.onItemClick=function(target){
			if ((target instanceof relationmap.RelationNode )){
				console.log("ItemClick:",target.getID(),target);
				if (this.isLineMode()){
					var tNode;
					tNode=target;
					if (!this._lineStart||tNode.getID()==this._lineStart.getID()){
						this._lineStart=tNode;
					}else
					if(!this._lineEnd){
						this._lineEnd=tNode;
						this.onAddLineComplete();
					}
				}
			}
		}

		__proto.onMapMouseDown=function(e){
			if (e.target==this.editorBox){
				this.handleMouseDownAdd();
			}
		}

		__proto.onAddLineComplete=function(){
			var tData;
			tData={};
			tData.type="RelationLine";
			var tProp;
			tProp={start:this._lineStart.getID(),end:this._lineEnd.getID()};
			tProp.startX=this._lineStart.x;
			tProp.startY=this._lineStart.y;
			tProp.endX=this._lineEnd.x;
			tProp.endY=this._lineEnd.y;
			tProp.label="R";
			tData.props=tProp;
			this.dataO.lines.push(tData);
			this.resetLineInfo();
			this.freshUI();
		}

		__proto.handleMouseDownAdd=function(){
			if (this.isOperateMode())return;
			var tPos;
			tPos=this.mapViewer.getMousePoint();
			if (this.isNodeMode()){
				this.addNode(tPos.x,tPos.y);
			}
		}

		__proto.addNode=function(x,y){
			var tData;
			tData={};
			tData.type="RelationNode";
			tData.props={x:x,y:y ,label:"Node"};
			this.dataO.nodes.push(tData);
			this.freshUI();
		}

		__proto.isLineMode=function(){
			return this.optionTab.selectedIndex==2;
		}

		__proto.isNodeMode=function(){
			return this.optionTab.selectedIndex==1;
		}

		__proto.isOperateMode=function(){
			return this.optionTab.selectedIndex==0;
		}

		__proto.onOpTypeChange=function(){
			this.resetLineInfo();
		}

		__proto.onSaveBtn=function(){
			this.event("save");
		}

		__proto.setData=function(dataO){
			this.dataO=dataO;
			this.freshUI();
		}

		__proto.resetLineInfo=function(){
			this._tLine=null;
			this._lineStart=null;
			this._lineEnd=null;
		}

		__proto.freshUI=function(){
			this.resetLineInfo();
			this.mapViewer.setData(this.dataO);
		}

		return RelationMapEditor;
	})(RelationMapEditorUI)


	//class ui.relationmap.RelationNodeUI extends commonlayout.relationmap.RelationMapItemBase
	var RelationNodeUI=(function(_super){
		function RelationNodeUI(){
			this.input=null;
			RelationNodeUI.__super.call(this);
		}

		__class(RelationNodeUI,'ui.relationmap.RelationNodeUI',_super);
		var __proto=RelationNodeUI.prototype;
		__proto.createChildren=function(){
			View.regComponent("commoncomponent.CommonInput",CommonInput);
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(RelationNodeUI.uiView);
		}

		RelationNodeUI.uiView={"type":"RelationMapItemBase","props":{"width":95,"height":22},"child":[{"type":"TextInput","props":{"width":95,"var":"input","text":"物品","skin":"comp/input_22.png","runtime":"commoncomponent.CommonInput","promptColor":"#f31713","height":22,"color":"#e80d09"}}]};
		return RelationNodeUI;
	})(RelationMapItemBase)


	/**
	*...
	*@author ww
	*/
	//class relationmap.RelationLine extends ui.relationmap.RelationLineUI
	var RelationLine=(function(_super){
		function RelationLine(){
			this.propO=null;
			RelationLine.__super.call(this);
		}

		__class(RelationLine,'relationmap.RelationLine',_super);
		var __proto=RelationLine.prototype;
		__proto.renderByData=function(){
			commonlayout.relationmap.RelationMapItemBase.prototype.renderByData.call(this);
			this.propO=this._dataO.props;
			var startNode;
			startNode=this.itemDic.getItemByID(this._dataO.start);
			if (startNode){
				this.propO.startX=startNode.x;
				this.propO.startY=startNode.y;
			};
			var endNode;
			endNode=this.itemDic.getItemByID(this._dataO.end);
			if (endNode){
				this.propO.endX=endNode.x;
				this.propO.endY=endNode.y;
			};
			var mX=NaN,mY=NaN;
			mX=(this.propO.startX+this.propO.endX)*0.5;
			mY=(this.propO.startY+this.propO.endY)*0.5;
			mX=mX || 0;
			mY=mY || 0;
			this.startPoint.visible=false;
			this.endPoint.visible=false;
			this.input.text=this.propO.label||"";
			this.pos(mX,mY);
		}

		__proto.drawLineToGraphics=function(g){
			var startNode;
			startNode=this.itemDic.getItemByID(this.propO.start);
			var endNode;
			endNode=this.itemDic.getItemByID(this.propO.end);
			this.propO.startX=startNode.x;
			this.propO.startY=startNode.y;
			this.propO.endX=endNode.x;
			this.propO.endY=endNode.y;
			var mX=NaN,mY=NaN;
			mX=(this.propO.startX+this.propO.endX)*0.5;
			mY=(this.propO.startY+this.propO.endY)*0.5;
			mX=mX || 0;
			mY=mY || 0;
			this.pos(mX,mY);
			if (startNode && endNode){
				g.drawLine(startNode.x,startNode.y,endNode.x,endNode.y,"#ff0000");
			}
		}

		return RelationLine;
	})(RelationLineUI)


	/**
	*...
	*@author ww
	*/
	//class relationmap.RelationNode extends ui.relationmap.RelationNodeUI
	var RelationNode=(function(_super){
		function RelationNode(){
			RelationNode.__super.call(this);
			this.on("mousedown",this,this.onMouseDown);
			this.on("click",this,this.onMouseClick);
			this.on("dragend",this,this.onEndDrag);
		}

		__class(RelationNode,'relationmap.RelationNode',_super);
		var __proto=RelationNode.prototype;
		__proto.renderByData=function(){
			commonlayout.relationmap.RelationMapItemBase.prototype.renderByData.call(this);
			this.pos(this._dataO.props.x,this._dataO.props.y);
			this.input.text=this._dataO.props.label||"";
		}

		__proto.onMouseClick=function(){
			EventTools.sendEventOnTree(this,"ItemClicked",this);
		}

		__proto.onMouseDown=function(){
			this.startDrag();
		}

		__proto.onEndDrag=function(){
			this._dataO.props.x=this.x;
			this._dataO.props.y=this.y;
		}

		return RelationNode;
	})(RelationNodeUI)



	new TestDemo();

})(window,document,Laya);
