
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var AutoSizeTextInput=commoncomponent.AutoSizeTextInput,Button=laya.ui.Button,CommonInput=commoncomponent.CommonInput;
	var ContextMenu=laya.debug.uicomps.ContextMenu,ContextMenuItem=laya.debug.uicomps.ContextMenuItem,EditorRenderBase=viewRender.EditorRenderBase;
	var Event=laya.events.Event,EventTools=commontools.EventTools,Handler=laya.utils.Handler,Label=laya.ui.Label;
	var List=laya.ui.List,Loader=laya.net.Loader,MindMapTreeBase=commonlayout.mindmaptree.MindMapTreeBase,MindMapViewer=commonlayout.mindmaptree.MindMapViewer;
	var ObjectTools=laya.debug.tools.ObjectTools,Stage=laya.display.Stage,Text=laya.display.Text,TextInput=laya.ui.TextInput;
	var View=laya.ui.View;
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
			rst=AnswerFlowEditor.createActionData();
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
			this.mindMapEditor=new AnswerFlowEditor();
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
			this.actionTipTxt=null;
			this.actionList=null;
			this.actionEditor=null;
			this.saveBtn=null;
			this.itemList=null;
			this.addItemBtn=null;
			this.addActionBtn=null;
			AnswerFlowEditorUI.__super.call(this);
		}

		__class(AnswerFlowEditorUI,'ui.answerflow.AnswerFlowEditorUI',_super);
		var __proto=AnswerFlowEditorUI.prototype;
		__proto.createChildren=function(){
			View.regComponent("answerflow.Action",Action);
			View.regComponent("answerflow.ItemListItem",ItemListItem);
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(AnswerFlowEditorUI.uiView);
		}

		AnswerFlowEditorUI.uiView={"type":"View","props":{"width":600,"height":600},"child":[{"type":"Label","props":{"y":6,"x":20,"width":53,"var":"actionTipTxt","text":"操作","styleSkin":"comp/label.png","height":15,"color":"#ef3431"}},{"type":"List","props":{"x":19,"width":96,"var":"actionList","vScrollBarSkin":"comp/vscroll.png","top":30,"repeatX":1,"height":565,"bottom":5},"child":[{"type":"Box","props":{"name":"render"},"child":[{"type":"Label","props":{"width":53,"text":"label","styleSkin":"comp/label.png","name":"label","height":15,"color":"#ef3431"}}]}]},{"type":"Action","props":{"var":"actionEditor","top":30,"runtime":"answerflow.Action","right":20,"left":131,"bottom":20}},{"type":"Button","props":{"var":"saveBtn","top":5,"skin":"comp/button.png","right":5,"label":"save"}},{"type":"List","props":{"var":"itemList","vScrollBarSkin":"comp/vscroll.png","top":5,"spaceY":5,"spaceX":5,"right":200,"left":132,"height":39},"child":[{"type":"ItemListItem","props":{"runtime":"answerflow.ItemListItem","name":"render"}}]},{"type":"Button","props":{"width":28,"var":"addItemBtn","top":11,"skin":"comp/button.png","right":151,"label":"+","height":24}},{"type":"Button","props":{"x":77,"width":28,"var":"addActionBtn","top":1,"skin":"comp/button.png","label":"+","height":24}}]};
		return AnswerFlowEditorUI;
	})(View)


	//class ui.answerflow.ItemListItemUI extends laya.ui.View
	var ItemListItemUI=(function(_super){
		function ItemListItemUI(){
			this.label=null;
			ItemListItemUI.__super.call(this);
		}

		__class(ItemListItemUI,'ui.answerflow.ItemListItemUI',_super);
		var __proto=ItemListItemUI.prototype;
		__proto.createChildren=function(){
			View.regComponent("commoncomponent.CommonInput",CommonInput);
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(ItemListItemUI.uiView);
		}

		ItemListItemUI.uiView={"type":"View","props":{"width":74,"height":14},"child":[{"type":"TextInput","props":{"y":-1,"x":1,"width":73,"var":"label","text":"label","skin":"comp/input_22.png","runtime":"commoncomponent.CommonInput","height":15,"color":"#ef3431"}}]};
		return ItemListItemUI;
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
			this.on("DataChanged",this,this.freshUI);
		}

		__class(Action,'answerflow.Action',_super);
		var __proto=Action.prototype;
		__proto.onDisplayChange=function(){}
		__proto.freshUI=function(){
			this.viewer.setData(this._dataO);
		}

		__proto.freshLayout=function(){
			this.viewer.freshLayout();
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
			View.regComponent("commoncomponent.AutoSizeTextInput",AutoSizeTextInput);
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(ActionRootUI.uiView);
		}

		ActionRootUI.uiView={"type":"MindMapTreeBase","props":{"width":63,"height":55},"child":[{"type":"TextInput","props":{"x":0,"width":63,"var":"actionTxt","text":"操作","styleSkin":"comp/label.png","skin":"comp/input_22.png","runtime":"commoncomponent.AutoSizeTextInput","height":21,"color":"#e72320"}},{"type":"TextInput","props":{"y":27,"x":0,"width":67,"var":"desTxt","text":"描述","styleSkin":"comp/label.png","skin":"comp/input_22.png","height":27,"color":"#e72320"}}]};
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
			View.regComponent("commoncomponent.AutoSizeTextInput",AutoSizeTextInput);
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(AddAbleNodeUI.uiView);
		}

		AddAbleNodeUI.uiView={"type":"MindMapTreeBase","props":{"width":105,"height":23},"child":[{"type":"TextInput","props":{"y":1,"x":1,"width":71,"var":"txt","text":"触发方式","skin":"comp/input_22.png","runtime":"commoncomponent.AutoSizeTextInput","height":21,"color":"#e72320"}},{"type":"Button","props":{"y":0,"x":79,"width":26,"var":"addBtn","skin":"comp/button.png","label":"+","height":24}}]};
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
			this.itemActionHandler=null;
			this._type=null;
			AnswerFlowEditor.__super.call(this);
			this.actionList.renderHandler=new Handler(this,this.itemRender);
			this.actionList.selectEnable=true;
			this.actionList.on("doubleclick",this,this.onDoubleClick);
			this.on("DataChanged",this,this.freshUI);
			this.saveBtn.on("click",this,this.onSaveBtn);
			this.addItemBtn.on("click",this,this.onAddItemBtn);
			this.addActionBtn.on("click",this,this.addNewAction);
			this.itemList.renderHandler=new Handler(this,this.itemListItemRender);
			this.itemActionHandler=new Handler(this.onItemAction);
		}

		__class(AnswerFlowEditor,'answerflow.AnswerFlowEditor',_super);
		var __proto=AnswerFlowEditor.prototype;
		__proto.onAddItemBtn=function(){
			if (!this.dataO.items){
				this.dataO.items=[];
			}
			this.dataO.items.push({"type":"Item",props:{"label":"new item" }});
			this.freshUI();
		}

		__proto.onSaveBtn=function(){
			this.event("save");
		}

		__proto.itemRender=function(cell,index){
			var label;
			label=cell.getChildByName("label");
			var dataO;
			dataO=cell.dataSource;
			label.text=dataO.label;
			if (dataO.type=="Action"){
				label.text=dataO.data.props.label;
			}
		}

		__proto.itemListItemRender=function(cell,index){
			cell.actionHandler=this.itemActionHandler;
			cell.initByData(cell.dataSource);
		}

		__proto.onItemAction=function(type,item){
			switch(type){
				}
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
			this.dataO.actions.push(this.createDefaultActionData());
			this.setData(this.dataO);
		}

		__proto.onActionSelect=function(dataO){
			this.actionEditor.setData(dataO.data);
		}

		__proto.createDefaultActionData=function(){
			var rst;
			switch(this._type){
				case "ansflow":
					rst=AnswerFlowEditor.createActionData();
					break ;
				case "qgame":
					rst=AnswerFlowEditor.createQGameActionData();
					break ;
				}
			return rst;
		}

		__proto.createAddActionData=function(){
			var rst;
			rst={};
			rst.type="addnew";
			rst.label="addNew";
			return rst;
		}

		__proto.setEditType=function(type){
			console.log("setEditType:",type);
			this._type=type;
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
			if (!this.dataO.items){
				this.itemList.visible=false;
				}else{
				this.itemList.visible=true;
				this.itemList.array=this.dataO.items;
			}
			this.actionTipTxt.text="操作("+this.dataO.actions.length+")";
			if(this.actionEditor.visible)
				this.actionEditor.freshLayout();
		}

		AnswerFlowEditor.createActionData=function(){
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

		AnswerFlowEditor.createQGameActionData=function(){
			var rst;
			rst={};
			rst.type="Action";
			rst.label="actionData";
			var actionData;
			actionData={
				"type":"ActionRoot",
				"props":{"des":"描述信息","label":"问题"},
				"childs":
				[{
					"type":"AddAbleNode",
					"props":{
						"label":"选项",
						"tpl":{
							"type":"AddAbleNode",
							"props":{
								"label":"选项内容" ,
								"editable":true,
								"tpl":{
									"type":"ItemData",
									"props":{},
									"childs":[]
								}
							},
							"childs":[]
						}
					},
					"childs":[]
				}]
			};
			rst.data=actionData;
			return rst;
		}

		AnswerFlowEditor.AnswerFlow="ansflow";
		AnswerFlowEditor.QGame="qgame";
		return AnswerFlowEditor;
	})(AnswerFlowEditorUI)


	//class ui.answerflow.ItemDataUI extends commonlayout.mindmaptree.MindMapTreeBase
	var ItemDataUI=(function(_super){
		function ItemDataUI(){
			this.item=null;
			this.count=null;
			this.removeBtn=null;
			ItemDataUI.__super.call(this);
		}

		__class(ItemDataUI,'ui.answerflow.ItemDataUI',_super);
		var __proto=ItemDataUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(ItemDataUI.uiView);
		}

		ItemDataUI.uiView={"type":"MindMapTreeBase","props":{"width":200,"height":30},"child":[{"type":"TextInput","props":{"y":4,"x":5,"width":95,"var":"item","text":"物品","skin":"comp/input_22.png","promptColor":"#f31713","height":22,"color":"#e80d09"}},{"type":"TextInput","props":{"y":4,"x":108,"width":60,"var":"count","text":"数量","skin":"comp/input_22.png","height":22,"color":"#ec130f"}},{"type":"Button","props":{"y":3,"x":173,"width":26,"var":"removeBtn","skin":"comp/button.png","label":"-","height":24}}]};
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
	//class answerflow.ItemListItem extends ui.answerflow.ItemListItemUI
	var ItemListItem=(function(_super){
		function ItemListItem(){
			this.actionHandler=null;
			this._dataO=null;
			ItemListItem.__super.call(this);
			this.setUpTextInput(this.label,"label");
		}

		__class(ItemListItem,'answerflow.ItemListItem',_super);
		var __proto=ItemListItem.prototype;
		__proto.initByData=function(dataO){
			this._dataO=dataO;
			this.label.text=dataO.props.label;
		}

		__proto.setUpTextInput=function(input,key){
			input.on("blur",this,this.onTextInputChange,[input,key]);
		}

		__proto.onTextInputChange=function(input,key){
			if (this._dataO.props[key]==input.text)return;
			this._dataO.props[key]=input.text;
		}

		return ItemListItem;
	})(ItemListItemUI)


	/**
	*...
	*@author ww
	*/
	//class answerflow.ActionRoot extends ui.answerflow.ActionRootUI
	var ActionRoot=(function(_super){
		function ActionRoot(){
			ActionRoot.__super.call(this);
			this.setUpTextInput(this.desTxt,"des");
			this.setUpTextInput(this.actionTxt,"label");
		}

		__class(ActionRoot,'answerflow.ActionRoot',_super);
		var __proto=ActionRoot.prototype;
		__proto.renderByData=function(){
			commonlayout.mindmaptree.MindMapTreeBase.prototype.renderByData.call(this);
			this.desTxt.text=this._dataO.props.des;
			this.actionTxt.text=this._dataO.props.label;
			this.width=Math.max(this.desTxt.width,this.actionTxt.width);
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
			this.setUpTextInput(this.txt,"label");
		}

		__class(AddAbleNode,'answerflow.AddAbleNode',_super);
		var __proto=AddAbleNode.prototype;
		__proto.renderByData=function(){
			commonlayout.mindmaptree.MindMapTreeBase.prototype.renderByData.call(this);
			this.txt.text=this._dataO.props.label;
			this.txt.editable=this._dataO.props.editable==true;
			this.addBtn.x=this.txt.x+this.txt.width+10;
			this.width=this.addBtn.x+this.addBtn.width+5;
		}

		__proto.onAddBtn=function(){
			if (!this._dataO.props.tpl)return;
			this._dataO.childs.push(ObjectTools.copyObjFast(this._dataO.props.tpl));
			EventTools.sendEventOnTree(this,"DataChanged");
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
			this.setUpTextInput(this.item,"item");
			this.setUpTextInput(this.count,"count");
			this.removeBtn.on("click",this,this.removeFromParent);
		}

		__class(ItemData,'answerflow.ItemData',_super);
		var __proto=ItemData.prototype;
		__proto.renderByData=function(){
			commonlayout.mindmaptree.MindMapTreeBase.prototype.renderByData.call(this);
			this.item.text=this._dataO.props["item"] || "";
			this.count.text=this._dataO.props["count"] || "";
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
