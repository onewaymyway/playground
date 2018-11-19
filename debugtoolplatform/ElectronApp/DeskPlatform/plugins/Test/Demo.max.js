
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var Box=laya.ui.Box,Button=laya.ui.Button,ContextMenu=laya.debug.uicomps.ContextMenu,ContextMenuItem=laya.debug.uicomps.ContextMenuItem;
	var EditorRenderBase=viewRender.EditorRenderBase,Event=laya.events.Event,Handler=laya.utils.Handler,Loader=laya.net.Loader;
	var Sprite=laya.display.Sprite,Stage=laya.display.Stage,Text=laya.display.Text,TextInput=laya.ui.TextInput;
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
			this.childs=[];
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
			rst=new MindMapNodeData();
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
			this.updateUIContent();
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
			this.mindMapEditor.setData(this._data);
			this.text.text=JSON.stringify(this._data);
		}

		return TestDemo;
	})(EditorRenderBase)


	//class ui.mindmap.MindMapEditorUI extends laya.ui.View
	var MindMapEditorUI=(function(_super){
		function MindMapEditorUI(){
			this.saveBtn=null;
			MindMapEditorUI.__super.call(this);
		}

		__class(MindMapEditorUI,'ui.mindmap.MindMapEditorUI',_super);
		var __proto=MindMapEditorUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(MindMapEditorUI.uiView);
		}

		MindMapEditorUI.uiView={"type":"View","props":{"width":400,"height":300},"child":[{"type":"Button","props":{"var":"saveBtn","top":5,"skin":"comp/button.png","right":5,"label":"保存"}}]};
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
			this.onMenuSelectHandler=null;
			this._userChanged=false;
			this._dataO=null;
			this.mapData=null;
			this.mapNodeData=null;
			MindMapEditor.__super.call(this);
			this._menu=ContextMenu.createMenuByArray(["新建"]);
			this._menu.on("select",this,this.onSelect);
			this.onMenuSelectHandler=new Handler(this,this.onSelect);
			this.nodeContainer=new Box();
			this.nodeContainer.size(1,1);
			this.nodeContainer.hitTestPrior=false;
			this.addChild(this.nodeContainer);
			this.on("resize",this,this.onResize);
			this.onResize();
			this.on("rightmousedown",this,this.onRightDown);
			this.on("rightmouseup",this,this.onRightUp);
			this.saveBtn.on("click",this,this.onActionBtn,["save"]);
		}

		__class(MindMapEditor,'mindmap.MindMapEditor',_super);
		var __proto=MindMapEditor.prototype;
		__proto.onActionBtn=function(type){
			switch(type){
				case "save":
					debugger;
					console.log("save:",this._dataO.url,this.mapNodeData);
					nodetools.devices.FileManager.createJSONFile(this._dataO.url,this.mapNodeData);
					break ;
				}
		}

		__proto.onRightDown=function(e){
			if (this.nodeContainer.contains(e.target)&&e.target!=this.nodeContainer)return;
			this.nodeContainer.startDrag();
			this._userChanged=true;
		}

		__proto.onRightUp=function(e){
			this.nodeContainer.stopDrag();
		}

		__proto.onResize=function(){
			if (this._userChanged)return;
			this.nodeContainer.pos(this.width*0.5,this.height*0.5);
		}

		__proto.onRightClick=function(){
			this._menu.show();
		}

		__proto.onSelect=function(dataO,target){
			console.log("onMenuSelect:",dataO,target);
			var label;
			label=dataO.target.data;
			console.log("Menu:",label);
			switch(label){
				case "新建子":
					target.nodeData.addChild(MindMapNodeData.createByLabel("new"));
					this.freshUI();
					break ;
				}
		}

		__proto.setData=function(dataO){
			this._dataO=dataO;
			this.mapNodeData=MindMapNodeData.createByObj(dataO.data,true);
			this.freshUI();
		}

		__proto.freshUI=function(){
			this.nodeContainer.removeChildren();
			var root;
			root=this.createMapView(this.mapNodeData);
			root.pos(0,0);
			root.layoutAsCenter();
			this.nodeContainer.graphics.clear();
			root.drawConnections(this.nodeContainer);
			console.log("data:",root.nodeData);
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
				tChildItem=this.createMapTree(tChildData);
				rst.addChildNode(tChildItem);
			}
			return rst;
		}

		__proto.createMapTree=function(nodeData){
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
				tChildItem=this.createMapTree(tChildData);
				rst.addChildNode(tChildItem);
			}
			return rst;
		}

		__proto.createMapItem=function(nodeData){
			var rst;
			rst=MindMapItem.createByData(nodeData);
			this.nodeContainer.addChild(rst);
			rst.onMenuSelectHandler=this.onMenuSelectHandler;
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
			this.onMenuSelectHandler=null;
			MindMapItem.__super.call(this);
			this._menu=ContextMenu.createMenuByArray(["新建同级","新建子"]);
			this._menu.on("select",this,this.onSelect);
			this.on("rightmouseup",this,this.onRightMouseUp);
			this.text.editable=true;
			this.text.on("blur",this,this.onInputBlur);
			this.on("mousedown",this,this.onDoubleClick);
		}

		__class(MindMapItem,'mindmap.MindMapItem',_super);
		var __proto=MindMapItem.prototype;
		__proto.onDoubleClick=function(){
			this.text.focus=true;
		}

		__proto.onInputBlur=function(){
			this.nodeData.label=this.text.text;
			this.freshUI();
		}

		__proto.onSelect=function(dataO){
			if (this.onMenuSelectHandler){
				this.onMenuSelectHandler.runWith([dataO,this]);
			}
			console.log("onMenuSelect:",dataO);
			var label;
			label=dataO.target.data;
			console.log("Menu:",label);
		}

		__proto.onRightMouseUp=function(){
			console.log("mindmapitem rightmouseup");
			this._menu.show();
		}

		__proto.freshUI=function(){
			this.text.text=this.nodeData.label||"";
		}

		__proto.drawConnections=function(sprite){
			var i=0,len=0;
			len=this.childNodes.length;
			var tChild;
			for (i=0;i < len;i++){
				tChild=this.childNodes[i];
				tChild.drawConnections(sprite);
				this.drawOneLine(this,tChild,sprite);
			}
		}

		__proto.drawOneLine=function(parentItem,childItem,sprite){
			var leftItem;
			var rightItem;
			if (parentItem.x < childItem.x){
				leftItem=parentItem;
				rightItem=childItem;
				}else{
				leftItem=childItem;
				rightItem=parentItem;
			};
			var lx=NaN,ly=NaN;
			var rx=NaN,ry=NaN;
			lx=leftItem.x+leftItem.width;
			ly=leftItem.y;
			rx=rightItem.x;
			ry=rightItem.y;
			sprite.graphics.drawCurves(0,0,[lx,ly,(lx+rx)/2,ly,rx,ry],"#ff0000");
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
			mid=Math.floor(this.childNodes.length / 2);
			leftChilds=[];
			rightChilds=[];
			var i=0,len=0;
			len=this.childNodes.length;
			for (i=0;i < len;i++){
				if (i < mid){
					leftChilds.push(this.childNodes[i]);
					}else{
					rightChilds.push(this.childNodes[i]);
				}
			}
			this.layoutChilds(leftChilds,this.x,this.y,false,true);
			this.layoutChilds(rightChilds,this.x,this.y,true,true);
		}

		__proto.layoutChilds=function(childNodes,x,y,isRight,lockPos){
			(isRight===void 0)&& (isRight=true);
			(lockPos===void 0)&& (lockPos=false);
			var itemHeight=NaN;
			itemHeight=this.getItemHeight(childNodes);
			if (!lockPos){
				this.pos(x,y+itemHeight *0.5);
				}else{
				this.pos(x,y);
			};
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
			if (lockPos){
				tY-=itemHeight *0.5;
			};
			var childItemHeight=NaN;
			for (i=0;i < len;i++){
				tChild=childNodes[i];
				childItemHeight=tChild.getItemHeight();
				tChild.setPos(childX,tY,isRight);
				tY+=childItemHeight+MindMapItem.YSpace;
			}
		}

		__proto.addChildNode=function(node,addToData){
			(addToData===void 0)&& (addToData=false);
			this.childNodes.push(node);
			if(addToData)
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

		//sprite.graphics.drawLine(leftItem.x+leftItem.width,leftItem.y,rightItem.x,rightItem.y,"#ff0000");
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
