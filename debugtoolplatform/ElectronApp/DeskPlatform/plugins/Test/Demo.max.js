
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var Box=laya.ui.Box,ContextMenu=laya.debug.uicomps.ContextMenu,ContextMenuItem=laya.debug.uicomps.ContextMenuItem;
	var DebugPanel=laya.debug.DebugPanel,EditorRenderBase=viewRender.EditorRenderBase,Event=laya.events.Event;
	var Handler=laya.utils.Handler,Loader=laya.net.Loader,Stage=laya.display.Stage,Text=laya.display.Text,TextInput=laya.ui.TextInput;
	var View=laya.ui.View;
	/**
	*...
	*@author ww
	*/
	//class mindmap.MindMapData
	var MindMapData=(function(){
		function MindMapData(){
			this._mapData=null;
			this._nodeList=null;
			this._idDic={};
		}

		__class(MindMapData,'mindmap.MindMapData');
		var __proto=MindMapData.prototype;
		__proto.initByObj=function(obj){
			this._mapData=obj;
			this.adptMapData();
		}

		__proto.adptMapData=function(){
			if (!this._mapData.nodeList)this._mapData.nodeList=[];
			this._nodeList=this._mapData.nodeList;
		}

		__proto.addNode=function(node){}
		__proto.removeNode=function(){}
		__proto.getNodeByID=function(id){}
		__proto.getNodeList=function(){
			return this._nodeList;
		}

		MindMapData.createByObj=function(obj){
			var mapData;
			mapData=new MindMapData();
			mapData.initByObj(obj);
			return mapData;
		}

		return MindMapData;
	})()


	/**
	*...
	*@author ww
	*/
	//class mindmap.MindMapNodeData
	var MindMapNodeData=(function(){
		function MindMapNodeData(){
			this.id=0;
			this.label=null;
			this.parent=0;
			this.childs=null;
			this.isOpen=false;
		}

		__class(MindMapNodeData,'mindmap.MindMapNodeData');
		var __proto=MindMapNodeData.prototype;
		__proto.addChild=function(child){
			this.childs.push(child);
			child.parent=this.id;
		}

		__proto.removeChild=function(child){
			var i=0,len=0;
			len=this.childs.length;
			for (i=0;i < len;i++){
				if (this.childs[i].id==child.id){
					this.childs.splice(i,1);
					return;
				}
			}
		}

		__proto.initByObject=function(obj){
			this.id=obj.id;
			this.label=obj.label;
			this.childs=obj.childs||[];
			this.parent=obj.parent;
			this.isOpen=obj.isOpen;
			return this;
		}

		MindMapNodeData.createByObj=function(obj,createChild){
			(createChild===void 0)&& (createChild=false);
			if ((obj instanceof mindmap.MindMapNodeData ))return obj;
			var rst;
			rst=new MindMapNodeData();
			rst.initByObject(obj);
			if (createChild){
				var i=0,len=0;
				var childs;
				childs=rst.childs;
				len=childs.length;
				for (i=0;i < len;i++){
					childs[i]=MindMapNodeData.createByObj(childs[i],true);
				}
			}
			return rst;
		}

		MindMapNodeData.createByLabel=function(label){
			var rst;
			rst=new MindMapData();
			rst.label=label;
			return rst;
		}

		return MindMapNodeData;
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


	//class ui.mindmap.MapItemUI extends laya.ui.View
	var MapItemUI=(function(_super){
		function MapItemUI(){
			this.text=null;
			MapItemUI.__super.call(this);
		}

		__class(MapItemUI,'ui.mindmap.MapItemUI',_super);
		var __proto=MapItemUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(MapItemUI.uiView);
		}

		MapItemUI.uiView={"type":"View","props":{"width":129,"height":23},"child":[{"type":"TextInput","props":{"var":"text","text":"TextInput","skin":"comp/textinput.png","color":"#93eedf","align":"center"}}]};
		return MapItemUI;
	})(View)


	/**
	*...
	*@author ww
	*/
	//class mindmap.MindMapEditor extends ui.mindmap.MindMapEditorUI
	var MindMapEditor=(function(_super){
		function MindMapEditor(){
			this._menu=null;
			this.nodeContainer=null;
			this._dataO=null;
			this.mapData=null;
			this.mapNodeData=null;
			MindMapEditor.__super.call(this);
			this._menu=ContextMenu.createMenuByArray(["新建"]);
			this._menu.on("select",this,this.onSelect);
			this.nodeContainer=new Box();
			this.nodeContainer.left=this.nodeContainer.right=this.nodeContainer.top=this.nodeContainer.bottom=0;
			this.addChild(this.nodeContainer);
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
			this.mapNodeData=MindMapNodeData.createByObj(dataO);
			this.freshUI();
		}

		__proto.freshUI=function(){
			this.nodeContainer.removeChildren();
			var root;
			root=this.createMapView(this.mapNodeData);
			debugger;
			root.pos(this.width*0.5,this.height*0.5);
			root.layoutAsCenter();
		}

		__proto.createMapView=function(nodeData){
			var rst;
			rst=this.createMapItem(nodeData);
			var childs;
			childs=nodeData.childs;
			var i=0,len=0;
			len=childs.length;
			var tChildData;
			var tChildItem;
			for (i=0;i < len;i++){
				tChildData=childs[i];
				tChildItem=this.createMapItem(tChildData);
				rst.addChildNode(tChildItem);
			}
			return rst;
		}

		__proto.createMapItem=function(nodeData){
			var rst;
			rst=MindMapItem.createByData(nodeData);
			this.nodeContainer.addChild(rst);
			return rst;
		}

		return MindMapEditor;
	})(MindMapEditorUI)


	/**
	*...
	*@author ww
	*/
	//class mindmap.MindMapItem extends ui.mindmap.MapItemUI
	var MindMapItem=(function(_super){
		function MindMapItem(){
			this.nodeData=null;
			this.childNodes=[];
			this._menu=null;
			MindMapItem.__super.call(this);
			this._menu=ContextMenu.createMenuByArray(["新建同级"]);
			this._menu.on("select",this,this.onSelect);
			this.on("rightmouseup",this,this.onRightMouseUp);
		}

		__class(MindMapItem,'mindmap.MindMapItem',_super);
		var __proto=MindMapItem.prototype;
		__proto.onSelect=function(dataO){
			console.log("onMenuSelect:",dataO);
			var label;
			label=dataO.target.data;
			console.log("Menu:",label);
			switch(label){
				case "":
					break ;
				}
		}

		__proto.onRightMouseUp=function(){
			console.log("mindmapitem rightmouseup");
			this._menu.show();
		}

		__proto.freshUI=function(){
			this.text.text=this.nodeData.label;
		}

		__proto.getItemHeight=function(childNodes){
			if (!childNodes)childNodes=this.childNodes;
			if (!childNodes || !childNodes.length)return this.height;
			var i=0,len=0;
			len=childNodes.length;
			var tChild;
			var tHeight=0;
			var totalHeight=NaN;
			totalHeight=0;
			for (i=0;i < len;i++){
				tChild=childNodes[i];
				tHeight=tChild.getItemHeight();
				totalHeight+=tHeight;
			}
			totalHeight+=MindMapItem.YSpace *(len-1);
			return totalHeight;
		}

		__proto.setPos=function(x,y,isRight){
			(isRight===void 0)&& (isRight=true);
			this.layoutChilds(this.childNodes,x,y,isRight);
		}

		__proto.layoutAsCenter=function(){
			if (this.childNodes.length <=1){
				this.layoutChilds(this.childNodes,this.x,this.y,true);
				return;
			};
			var leftChilds;
			var rightChilds;
			var mid=0;
			mid=Math.round(this.childNodes.length / 2);
			leftChilds=[];
			rightChilds=[];
			var i=0,len=0;
			len=this.childNodes.length;
			for (i=0;i < len;i++){
				if (i <=mid){
					leftChilds.push(this.childNodes[i]);
					}else{
					rightChilds.push(this.childNodes[i]);
				}
			}
			this.layoutChilds(leftChilds,this.x,this.y,false);
			this.layoutChilds(rightChilds,this.x,this.y,true);
		}

		__proto.layoutChilds=function(childNodes,x,y,isRight){
			(isRight===void 0)&& (isRight=true);
			var itemHeight=NaN;
			itemHeight=this.getItemHeight(childNodes);
			this.pos(x,y+itemHeight *0.5);
			var i=0,len=0;
			len=childNodes.length;
			var childX=NaN;
			if (isRight){
				childX=x+this.width+MindMapItem.XSpace;
				}else{
				childX=x-this.width-MindMapItem.XSpace;
			};
			var tChild;
			var tY=NaN;
			tY=y;
			for (i=0;i < len;i++){
				tChild=childNodes[i];
				tChild.setPos(childX,tY,isRight);
				tY+=tChild.height+MindMapItem.YSpace;
			}
		}

		__proto.addChildNode=function(node){
			this.childNodes.push(node);
			this.nodeData.addChild(node.nodeData);
		}

		__proto.removeChildNode=function(node){
			var i=0,len=0;
			len=this.childNodes.length;
			var tChild;
			for (i=0;i < len;i++){
				tChild=this.childNodes.length;
				if (tChild.ID==node.ID){
					this.childNodes.splice(i,1);
					this.nodeData.removeChild(node.nodeData);
					return;
				}
			}
		}

		__getset(0,__proto,'ID',function(){
			return this.nodeData.id;
		});

		MindMapItem.createByData=function(mindMapNodeData,autoBuildTree){
			(autoBuildTree===void 0)&& (autoBuildTree=false);
			var rst;
			rst=new MindMapItem();
			rst.nodeData=mindMapNodeData;
			rst.freshUI();
			return rst;
		}

		MindMapItem.YSpace=20;
		MindMapItem.XSpace=20;
		return MindMapItem;
	})(MapItemUI)



	new TestDemo();

})(window,document,Laya);
