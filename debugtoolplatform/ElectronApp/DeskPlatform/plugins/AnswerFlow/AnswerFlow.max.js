
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var Button=laya.ui.Button,ContextMenu=laya.debug.uicomps.ContextMenu,ContextMenuItem=laya.debug.uicomps.ContextMenuItem;
	var EditorRenderBase=viewRender.EditorRenderBase,Event=laya.events.Event,Handler=laya.utils.Handler,Label=laya.ui.Label;
	var List=laya.ui.List,Loader=laya.net.Loader,MindMapTreeBase=commonlayout.mindmaptree.MindMapTreeBase,MindMapViewer=commonlayout.mindmaptree.MindMapViewer;
	var Notice$1=platform.tools.Notice,ObjectTools=laya.debug.tools.ObjectTools,Stage=laya.display.Stage,Text=laya.display.Text;
	var TextInput=laya.ui.TextInput,View=laya.ui.View;
	/**
	*...
	*@author ww
	*/
	//class answerflow.AnswerFlowEvents
	var AnswerFlowEvents=(function(){
		function AnswerFlowEvents(){}
		__class(AnswerFlowEvents,'answerflow.AnswerFlowEvents');
		AnswerFlowEvents.DataChanged="DataChanged";
		return AnswerFlowEvents;
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
			this.mindMapEditor=new AnswerFlowEditor();
			this.mindMapEditor.left=this.mindMapEditor.right=this.mindMapEditor.top=this.mindMapEditor.bottom=2;
			this.mindMapEditor.on("save",this,this.onMindMapSave);
			Laya.stage.addChild(this.mindMapEditor);
			this.updateUIContent();
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
			if (!this._data||!this.mindMapEditor)return;
			this.mindMapEditor.setData(this._data.data);
			this.text.text=JSON.stringify(this._data);
		}

		return TestDemo;
	})(EditorRenderBase)


	//class ui.answerflow.ActionUI extends laya.ui.View
	var ActionUI=(function(_super){
		function ActionUI(){ActionUI.__super.call(this);;
		};

		__class(ActionUI,'ui.answerflow.ActionUI',_super);
		var __proto=ActionUI.prototype;
		__proto.createChildren=function(){
			View.regComponent("ui.answerflow.ItemDataUI",ItemDataUI);
			View.regComponent("ui.answerflow.ActionRootUI",ActionRootUI);
			View.regComponent("ui.answerflow.SimpleNodeUI",SimpleNodeUI);
			View.regComponent("ui.answerflow.AddAbleNodeUI",AddAbleNodeUI);
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(ActionUI.uiView);
		}

		ActionUI.uiView={"type":"View","props":{"width":400,"height":500},"child":[{"type":"ItemData","props":{"y":234,"x":279,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ItemData","props":{"y":280,"x":279,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ItemData","props":{"y":335,"x":279,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ItemData","props":{"y":375,"x":279,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ItemData","props":{"y":417,"x":279,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ItemData","props":{"y":41,"x":188,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ItemData","props":{"y":93,"x":187,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ItemData","props":{"y":141,"x":190,"runtime":"ui.answerflow.ItemDataUI"}},{"type":"ActionRoot","props":{"y":184,"x":11,"runtime":"ui.answerflow.ActionRootUI"}},{"type":"SimpleNode","props":{"y":302,"x":88,"runtime":"ui.answerflow.SimpleNodeUI"}},{"type":"AddAbleNode","props":{"y":98,"x":80,"runtime":"ui.answerflow.AddAbleNodeUI"}},{"type":"AddAbleNode","props":{"y":264,"x":160,"runtime":"ui.answerflow.AddAbleNodeUI"}},{"type":"AddAbleNode","props":{"y":378,"x":155,"runtime":"ui.answerflow.AddAbleNodeUI"}}]};
		return ActionUI;
	})(View)


	//class ui.answerflow.AnswerFlowEditorUI extends laya.ui.View
	var AnswerFlowEditorUI=(function(_super){
		function AnswerFlowEditorUI(){
			this.actionList=null;
			this.actionEditor=null;
			this.saveBtn=null;
			AnswerFlowEditorUI.__super.call(this);
		}

		__class(AnswerFlowEditorUI,'ui.answerflow.AnswerFlowEditorUI',_super);
		var __proto=AnswerFlowEditorUI.prototype;
		__proto.createChildren=function(){
			View.regComponent("answerflow.Action",Action);
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(AnswerFlowEditorUI.uiView);
		}

		AnswerFlowEditorUI.uiView={"type":"View","props":{"width":600,"height":600},"child":[{"type":"Label","props":{"y":6,"x":20,"width":53,"text":"操作","styleSkin":"comp/label.png","height":15,"color":"#ef3431"}},{"type":"List","props":{"x":19,"width":67,"var":"actionList","top":30,"bottom":5},"child":[{"type":"Box","props":{"name":"render"},"child":[{"type":"Label","props":{"width":53,"text":"label","styleSkin":"comp/label.png","name":"label","height":15,"color":"#ef3431"}}]}]},{"type":"Action","props":{"var":"actionEditor","top":30,"runtime":"answerflow.Action","right":20,"left":80,"bottom":20}},{"type":"Button","props":{"var":"saveBtn","top":5,"skin":"comp/button.png","right":5,"label":"save"}}]};
		return AnswerFlowEditorUI;
	})(View)


	/**
	*...
	*@author ww
	*/
	//class answerflow.Action extends ui.answerflow.ActionUI
	var Action=(function(_super){
		function Action(){
			this.viewer=null;
			this._dataO=null;
			Action.__super.call(this);
			this.removeChildren();
			this.viewer=new MindMapViewer();
			var clzList;
			clzList=[ActionRoot,AddAbleNode,DataOperate,SimpleNode,ItemData];
			this.viewer.regItemClassList(clzList);
			this.addChild(this.viewer);
			this.viewer.centerY=0;
			this.viewer.x=100;
			this.on("display",this,this.onDisplayChange);
			this.on("undisplay",this,this.onDisplayChange);
		}

		__class(Action,'answerflow.Action',_super);
		var __proto=Action.prototype;
		__proto.onDisplayChange=function(){
			Notice$1.cancel("DataChanged",this,this.freshUI);
			if (this.displayedInStage){
				Notice$1.listen("DataChanged",this,this.freshUI);
				}else{
			}
		}

		__proto.freshUI=function(){
			this.viewer.setData(this._dataO);
		}

		__proto.setData=function(dataO){
			this._dataO=dataO;
			this.freshUI();
		}

		return Action;
	})(ActionUI)


	//class ui.answerflow.ActionRootUI extends commonlayout.mindmaptree.MindMapTreeBase
	var ActionRootUI=(function(_super){
		function ActionRootUI(){
			this.actionTxt=null;
			this.desTxt=null;
			ActionRootUI.__super.call(this);
		}

		__class(ActionRootUI,'ui.answerflow.ActionRootUI',_super);
		var __proto=ActionRootUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(ActionRootUI.uiView);
		}

		ActionRootUI.uiView={"type":"MindMapTreeBase","props":{"width":63,"height":55},"child":[{"type":"Label","props":{"y":4,"x":0,"width":63,"var":"actionTxt","text":"操作","styleSkin":"comp/label.png","height":21,"color":"#e72320"}},{"type":"Label","props":{"y":34,"x":-2,"width":51,"var":"desTxt","text":"描述","styleSkin":"comp/label.png","height":21,"color":"#e72320"}}]};
		return ActionRootUI;
	})(MindMapTreeBase)


	//class ui.answerflow.AddAbleNodeUI extends commonlayout.mindmaptree.MindMapTreeBase
	var AddAbleNodeUI=(function(_super){
		function AddAbleNodeUI(){
			this.txt=null;
			this.addBtn=null;
			AddAbleNodeUI.__super.call(this);
		}

		__class(AddAbleNodeUI,'ui.answerflow.AddAbleNodeUI',_super);
		var __proto=AddAbleNodeUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(AddAbleNodeUI.uiView);
		}

		AddAbleNodeUI.uiView={"type":"MindMapTreeBase","props":{"width":105,"height":23},"child":[{"type":"Label","props":{"y":2,"x":0,"width":63,"var":"txt","text":"触发方式","styleSkin":"comp/label.png","height":21,"color":"#e72320"}},{"type":"Button","props":{"y":0,"x":79,"width":26,"var":"addBtn","skin":"comp/button.png","label":"+","height":24}}]};
		return AddAbleNodeUI;
	})(MindMapTreeBase)


	//class ui.answerflow.DataOperateUI extends commonlayout.mindmaptree.MindMapTreeBase
	var DataOperateUI=(function(_super){
		function DataOperateUI(){DataOperateUI.__super.call(this);;
		};

		__class(DataOperateUI,'ui.answerflow.DataOperateUI',_super);
		var __proto=DataOperateUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(DataOperateUI.uiView);
		}

		DataOperateUI.uiView={"type":"MindMapTreeBase","props":{"width":240,"height":30},"child":[{"type":"TextInput","props":{"y":4,"x":10,"width":95,"text":"TextInput","skin":"comp/input_22.png","promptColor":"#f31713","height":22,"color":"#e80d09"}},{"type":"ComboBox","props":{"y":5,"x":114,"width":53,"skin":"comp/combobox.png","sizeGrid":"0,31,0,0","selectedIndex":0,"labels":"+,-","height":22}},{"type":"TextInput","props":{"y":5,"x":174,"width":60,"text":"TextInput","skin":"comp/input_22.png","height":22,"color":"#ec130f"}}]};
		return DataOperateUI;
	})(MindMapTreeBase)


	/**
	*...
	*@author ...
	*/
	//class answerflow.AnswerFlowEditor extends ui.answerflow.AnswerFlowEditorUI
	var AnswerFlowEditor=(function(_super){
		function AnswerFlowEditor(){
			this.dataO=null;
			AnswerFlowEditor.__super.call(this);
			this.actionList.renderHandler=new Handler(this,this.itemRender);
			this.actionList.selectEnable=true;
			this.actionList.on("doubleclick",this,this.onDoubleClick);
			Notice$1.listen("DataChanged",this,this.freshUI);
			this.saveBtn.on("click",this,this.onSaveBtn);
		}

		__class(AnswerFlowEditor,'answerflow.AnswerFlowEditor',_super);
		var __proto=AnswerFlowEditor.prototype;
		__proto.onSaveBtn=function(){
			this.event("save");
		}

		__proto.itemRender=function(cell,index){
			var label;
			label=cell.getChildByName("label");
			var dataO;
			dataO=cell.dataSource;
			label.text=dataO.label;
		}

		__proto.onDoubleClick=function(){
			if (this.actionList.selectedItem){
				var dataO;
				dataO=this.actionList.selectedItem;
				switch(dataO.type){
					case "addnew":
						this.addNewAction();
						break ;
					case "Action":
						this.onActionSelect(dataO);
						break ;
					}
			}
		}

		__proto.addNewAction=function(){
			this.dataO.actions.push(this.createActionData());
			this.setData(this.dataO);
		}

		__proto.onActionSelect=function(dataO){
			this.actionEditor.setData(dataO.data);
		}

		__proto.createActionData=function(){
			var rst;
			rst={};
			rst.type="Action";
			rst.label="actionData";
			var actionData;
			actionData={
				"type":"ActionRoot",
				"props":{"des":"描述信息","label":"操作名"},
				"childs":
				[{
					"type":"AddAbleNode",
					"props":{
						"label":"触发方式",
						"tpl":{
							"type":"ItemData",
							"props":{},
							"childs":[]
						}
					},
					"childs":[]
					},{
					"type":"SimpleNode",
					"props":{"label":"影响" },
					"childs":[{
						"type":"AddAbleNode",
						"props":{
							"label":"增加" ,
							"tpl":{
								"type":"ItemData",
								"props":{},
								"childs":[]
							}
						},
						"childs":[]
						},{
						"type":"AddAbleNode",
						"props":{
							"label":"减少",
							"tpl":{
								"type":"ItemData",
								"props":{},
								"childs":[]
							}
						},
						"childs":[]
					}]
				}]
			};
			rst.data=actionData;
			return rst;
		}

		__proto.createAddActionData=function(){
			var rst;
			rst={};
			rst.type="addnew";
			rst.label="addNew";
			return rst;
		}

		__proto.setData=function(dataO){
			this.dataO=dataO;
			this.freshUI();
		}

		__proto.freshUI=function(){
			if (!this.dataO.actions){
				this.dataO.actions=[this.createAddActionData()];
			}
			this.actionList.array=this.dataO.actions;
		}

		return AnswerFlowEditor;
	})(AnswerFlowEditorUI)


	//class ui.answerflow.ItemDataUI extends commonlayout.mindmaptree.MindMapTreeBase
	var ItemDataUI=(function(_super){
		function ItemDataUI(){
			this.item=null;
			this.count=null;
			ItemDataUI.__super.call(this);
		}

		__class(ItemDataUI,'ui.answerflow.ItemDataUI',_super);
		var __proto=ItemDataUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(ItemDataUI.uiView);
		}

		ItemDataUI.uiView={"type":"MindMapTreeBase","props":{"width":168,"height":30},"child":[{"type":"TextInput","props":{"y":4,"x":5,"width":95,"var":"item","text":"物品","skin":"comp/input_22.png","promptColor":"#f31713","height":22,"color":"#e80d09"}},{"type":"TextInput","props":{"y":4,"x":108,"width":60,"var":"count","text":"数量","skin":"comp/input_22.png","height":22,"color":"#ec130f"}}]};
		return ItemDataUI;
	})(MindMapTreeBase)


	//class ui.answerflow.SimpleNodeUI extends commonlayout.mindmaptree.MindMapTreeBase
	var SimpleNodeUI=(function(_super){
		function SimpleNodeUI(){
			this.txt=null;
			SimpleNodeUI.__super.call(this);
		}

		__class(SimpleNodeUI,'ui.answerflow.SimpleNodeUI',_super);
		var __proto=SimpleNodeUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(SimpleNodeUI.uiView);
		}

		SimpleNodeUI.uiView={"type":"MindMapTreeBase","props":{"width":63,"height":21},"child":[{"type":"Label","props":{"width":63,"var":"txt","text":"触发方式","styleSkin":"comp/label.png","height":21,"color":"#e72320"}}]};
		return SimpleNodeUI;
	})(MindMapTreeBase)


	/**
	*...
	*@author ww
	*/
	//class answerflow.ActionRoot extends ui.answerflow.ActionRootUI
	var ActionRoot=(function(_super){
		function ActionRoot(){
			ActionRoot.__super.call(this);
		}

		__class(ActionRoot,'answerflow.ActionRoot',_super);
		var __proto=ActionRoot.prototype;
		__proto.renderByData=function(){
			commonlayout.mindmaptree.MindMapTreeBase.prototype.renderByData.call(this);
			this.desTxt.text=this._dataO.props.des;
			this.actionTxt.text=this._dataO.props.label;
		}

		return ActionRoot;
	})(ActionRootUI)


	/**
	*...
	*@author ww
	*/
	//class answerflow.AddAbleNode extends ui.answerflow.AddAbleNodeUI
	var AddAbleNode=(function(_super){
		function AddAbleNode(){
			AddAbleNode.__super.call(this);
			this.addBtn.on("click",this,this.onAddBtn);
		}

		__class(AddAbleNode,'answerflow.AddAbleNode',_super);
		var __proto=AddAbleNode.prototype;
		__proto.renderByData=function(){
			commonlayout.mindmaptree.MindMapTreeBase.prototype.renderByData.call(this);
			this.txt.text=this._dataO.props.label;
		}

		__proto.onAddBtn=function(){
			if (!this._dataO.props.tpl)return;
			this._dataO.childs.push(ObjectTools.copyObjFast(this._dataO.props.tpl));
			Notice$1.notify("DataChanged");
		}

		return AddAbleNode;
	})(AddAbleNodeUI)


	/**
	*...
	*@author ww
	*/
	//class answerflow.DataOperate extends ui.answerflow.DataOperateUI
	var DataOperate=(function(_super){
		function DataOperate(){
			DataOperate.__super.call(this);
		}

		__class(DataOperate,'answerflow.DataOperate',_super);
		var __proto=DataOperate.prototype;
		__proto.renderByData=function(){
			commonlayout.mindmaptree.MindMapTreeBase.prototype.renderByData.call(this);
		}

		return DataOperate;
	})(DataOperateUI)


	/**
	*...
	*@author ww
	*/
	//class answerflow.ItemData extends ui.answerflow.ItemDataUI
	var ItemData=(function(_super){
		function ItemData(){
			ItemData.__super.call(this);
		}

		__class(ItemData,'answerflow.ItemData',_super);
		var __proto=ItemData.prototype;
		__proto.renderByData=function(){
			commonlayout.mindmaptree.MindMapTreeBase.prototype.renderByData.call(this);
		}

		return ItemData;
	})(ItemDataUI)


	/**
	*...
	*@author ww
	*/
	//class answerflow.SimpleNode extends ui.answerflow.SimpleNodeUI
	var SimpleNode=(function(_super){
		function SimpleNode(){
			SimpleNode.__super.call(this);
		}

		__class(SimpleNode,'answerflow.SimpleNode',_super);
		var __proto=SimpleNode.prototype;
		//this.graphics.drawRect(0,0,100,100,"#ff0000");
		__proto.renderByData=function(){
			commonlayout.mindmaptree.MindMapTreeBase.prototype.renderByData.call(this);
			this.txt.text=this._dataO.props.label;
		}

		return SimpleNode;
	})(SimpleNodeUI)



	new TestDemo();

})(window,document,Laya);
