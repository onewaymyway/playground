
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var Box=laya.ui.Box,Browser=laya.utils.Browser,CMDShell=nodetools.devices.CMDShell,ContextMenu$1=electrontools.menus.ContextMenu;
	var Device=nodetools.devices.Device,Event=laya.events.Event,EventDispatcher=laya.events.EventDispatcher,FileManager=nodetools.devices.FileManager;
	var FileTools=nodetools.devices.FileTools,Handler=laya.utils.Handler,Input=laya.display.Input,JSTools=laya.debug.tools.JSTools;
	var Label=laya.ui.Label,List=laya.ui.List,Loader=laya.net.Loader,NodeUtils=laya.debug.view.nodeInfo.NodeUtils;
	var OSInfo=nodetools.devices.OSInfo,Paths=nodetools.devices.Paths,Point=laya.maths.Point,PythonTools=nodetools.devices.PythonTools;
	var RenderContext=laya.renders.RenderContext,Stage=laya.display.Stage,Styles=laya.ui.Styles,SystemDragOverManager=electrontools.drags.SystemDragOverManager;
	var SystemSetting=nodetools.devices.SystemSetting,UIConfig=Laya.UIConfig,View=laya.ui.View;
	/**
	*...
	*@author ww
	*/
	//class DeskPlatform
	var DeskPlatform=(function(){
		function DeskPlatform(){
			Laya.init(800,600);
			Laya.stage.scaleMode="full";
			UIConfig.touchScrollEnable=false;
			Styles.buttonLabelColors=["#ffffff","#32cc6b","#ff0000","#C0C0C0"];
			this.init();
			var resList;
			resList=[{"url":"res/atlas/comp.json","type":"atlas"}];
			Laya.loader.load(resList,new Handler(this,this.test));
		}

		__class(DeskPlatform,'DeskPlatform');
		var __proto=DeskPlatform.prototype;
		__proto.init=function(){
			Device.Buffer=Buffer;
			Device.init();
			SystemSetting.isCMDVer=true;
			OSInfo.init();
			FileTools.init2();
			CMDShell.init();
			PythonTools.PythonFolder=FileTools.getAppPath("pythontools")+"/";
			Paths.tempPath=FileTools.getAppPath("tempdata")+"/";
			Paths.dataPath=FileTools.getAppPath("data")+"/";
			SystemDragOverManager.init();
			ContextMenu$1.init();
			SystemSetting.appPath=FileTools.appPath;
		}

		__proto.test=function(){
			console.log("AppPath:",FileTools.appPath);
			var mainView;
			mainView=new MainView();
			mainView.left=mainView.right=mainView.top=mainView.bottom=5;
			Laya.stage.addChild(mainView);
		}

		return DeskPlatform;
	})()


	/**
	*
	*@author ww
	*@version 1.0
	*
	*@created 2016-8-10 下午4:21:23
	*/
	//class platform.extenddisplay.HtmlZIndexManager
	var HtmlZIndexManager=(function(){
		function HtmlZIndexManager(){}
		__class(HtmlZIndexManager,'platform.extenddisplay.HtmlZIndexManager');
		HtmlZIndexManager.init=function(){
			Laya.stage.on("mousedown",null,HtmlZIndexManager.onMouseDown);
			Laya.stage.on("mouseup",null,HtmlZIndexManager.onMouseUp);
		}

		HtmlZIndexManager.onMouseDown=function(){
			HtmlZIndexManager.isMouseDown=true;
			HtmlZIndexManager.prePos.setTo(Laya.stage.mouseX,Laya.stage.mouseY);
			HtmlZIndexManager.isDrag=false;
			Laya.stage.on("mousemove",null,HtmlZIndexManager.onMouseMove);
		}

		HtmlZIndexManager.onMouseMove=function(){
			if(Math.abs(HtmlZIndexManager.prePos.x-Laya.stage.mouseX)+Math.abs(HtmlZIndexManager.prePos.y-Laya.stage.mouseY)>5){
				Notice.notify("DisableOverlays");
				HtmlZIndexManager.setHtmlEnable(false);
				HtmlZIndexManager.isDrag=true;
				Laya.stage.off("mousemove",null,HtmlZIndexManager.onMouseMove);
			}
		}

		HtmlZIndexManager.onMouseUp=function(){
			HtmlZIndexManager.isMouseDown=false;
			Laya.stage.off("mousemove",null,HtmlZIndexManager.onMouseMove);
			if(!HtmlZIndexManager.preValue){
				Notice.notify("EnableOverlays");
				HtmlZIndexManager.setHtmlEnable(true);
			}
			HtmlZIndexManager.isDrag=false;
		}

		HtmlZIndexManager.setHtmlEnable=function(enable){
			HtmlZIndexManager.preValue=enable;
			var i=0,len=0;
			len=HtmlZIndexManager.htmlList.length;
			for(i=0;i<len;i++){
				if(HtmlZIndexManager.htmlList[i].disableAutoControl)continue ;
				JSTools.setMouseEnable(HtmlZIndexManager.htmlList[i],enable);
			}
		}

		HtmlZIndexManager.addHtml=function(html){
			if(!html)return;
			if(!HtmlZIndexManager.htmlList.indexOf(html)>=0){
				HtmlZIndexManager.htmlList.push(html);
			}
		}

		HtmlZIndexManager.removeHtml=function(html){
			if(!html)return;
			var index=0;
			index=HtmlZIndexManager.htmlList.indexOf(html);
			if(index>=0){
				HtmlZIndexManager.htmlList.splice(index,1);
			}
		}

		HtmlZIndexManager.DisableOverlays="DisableOverlays";
		HtmlZIndexManager.EnableOverlays="EnableOverlays";
		HtmlZIndexManager.isDrag=false;
		HtmlZIndexManager.isMouseDown=false;
		HtmlZIndexManager.preValue=true;
		HtmlZIndexManager.htmlList=[];
		__static(HtmlZIndexManager,
		['prePos',function(){return this.prePos=new Point();}
		]);
		return HtmlZIndexManager;
	})()


	/**
	*
	*@author ww
	*@version 1.0
	*
	*@created 2015-11-16 下午1:26:53
	*/
	//class platform.tools.Notices
	var Notices=(function(){
		function Notices(){}
		__class(Notices,'platform.tools.Notices');
		Notices.RENDER_INITED="RenderInited";
		Notices.DROP_RENDER="DROP_RENDER";
		Notices.OPEN_PLUGIN="OPEN_PLUGIN";
		return Notices;
	})()


	/**
	*本类用于模块间消息传递
	*@author ww
	*/
	//class platform.tools.Notice extends laya.events.EventDispatcher
	var Notice=(function(_super){
		function Notice(){
			Notice.__super.call(this);
		}

		__class(Notice,'platform.tools.Notice',_super);
		Notice.notify=function(type,data){
			Notice.I.event(type,data);
		}

		Notice.listen=function(type,_scope,fun,args,cancelBefore){
			(cancelBefore===void 0)&& (cancelBefore=false);
			if(cancelBefore)Notice.cancel(type,_scope,fun);
			Notice.I.on(type,_scope,fun,args);
		}

		Notice.cancel=function(type,_scope,fun){
			Notice.I.off(type,_scope,fun);
		}

		__static(Notice,
		['I',function(){return this.I=new Notice();}
		]);
		return Notice;
	})(EventDispatcher)


	/**
	*
	*@author ww
	*@version 1.0
	*
	*@created 2016-8-9 上午11:59:23
	*/
	//class platform.extenddisplay.HtmlSprite extends laya.ui.Box
	var HtmlSprite=(function(_super){
		function HtmlSprite(){
			this.canClose=true;
			this.disableAutoControl=true;
			this.div=null;
			this.prePoint=new Point();
			var _$this=this;
			HtmlSprite.__super.call(this);
			HtmlSprite.parentNode=Browser.container;
			this.mouseEnabled=true;
			this.createHtml();
			this.size(100,100);
			this.on("display",this,this._$5__onDisplay);
			this.on("undisplay",this,this._$5__onDisplay);
			this.setZIndex(101);
			this.on("mouseover",this,this.renderMouseHandler);
			this.on("mousedown",this,this.onMyMouseDown);
			JSTools.setMouseEnable(this.div,false);
			this.div.addEventListener("mouseout",function(e){
				_$this.divMouseOut();
			})
		}

		__class(HtmlSprite,'platform.extenddisplay.HtmlSprite',_super);
		var __proto=HtmlSprite.prototype;
		__proto.onMyMouseDown=function(){
			if(!JSTools.getMouseEnable(this.div)){
				JSTools.setMouseEnable(this.div,true);
			}
		}

		__proto.divMouseOut=function(){
			JSTools.setMouseEnable(this.div,false);
		}

		__proto.renderMouseHandler=function(e){
			if(Input.isInputting){
				HtmlZIndexManager.isMouseDown=false;
			}
			if(HtmlZIndexManager.isMouseDown)return;
			JSTools.setMouseEnable(this.div,true);
		}

		__proto.createHtml=function(){
			this.div=Browser.createElement("div");
		}

		__proto.setHtmlTxt=function(html){
			this.div.innerHTML=html;
		}

		__proto.setZIndex=function(zIndex){
			(zIndex===void 0)&& (zIndex=101);
			JSTools.setZIndex(this.div,zIndex);
		}

		/**@private */
		__proto._$5__onDisplay=function(){
			if(this.displayedInStage){
				Laya.timer.frameLoop(1,this,this.updateMyPos);
				if(!this.disableAutoControl)
					HtmlZIndexManager.addHtml(this.div);
				}else{
				Laya.timer.clear(this,this.updateMyPos);
				JSTools.removeElement(this.div);
				HtmlZIndexManager.removeHtml(this.div);
			}
		}

		__proto.render=function(context,x,y){
			laya.display.Sprite.prototype.render.call(this,context,x,y);
		}

		// updateMyPos();
		__proto.updateMyPos=function(){
			if(this.displayedInStage&&this.visible){
				var point;
				point=NodeUtils.getGPos(this);
				if(!JSTools.isElementInDom(this.div)){
					JSTools.showToParent(this.div,point.x,point.y,HtmlSprite.parentNode);
					this.prePoint.setTo(point.x,point.y);
					}else{
					if(this.prePoint.x!=point.x||this.prePoint.y!=point.y){
						JSTools.setPos(this.div,point.x,point.y);
						this.prePoint.setTo(point.x,point.y);
					}
				}
				}else{
				JSTools.removeElement(this.div);
			}
		}

		__proto.changeSize=function(){
			laya.ui.Component.prototype.changeSize.call(this);
			JSTools.setSize(this.div,this.width,this.height);
		}

		HtmlSprite.testDiv="";
		HtmlSprite.parentNode=null
		return HtmlSprite;
	})(Box)


	/**
	*
	*@author ww
	*@version 1.0
	*
	*@created 2016-8-12 上午11:35:20
	*/
	//class platform.extenddisplay.IFrameSprite extends platform.extenddisplay.HtmlSprite
	var IFrameSprite=(function(_super){
		function IFrameSprite(){
			IFrameSprite.__super.call(this);
		}

		__class(IFrameSprite,'platform.extenddisplay.IFrameSprite',_super);
		var __proto=IFrameSprite.prototype;
		__proto.createHtml=function(){
			this.div=Browser.createElement("iframe");
			this.div.style.border="0px";
		}

		__proto.setUrl=function(path){
			this.div.src=path;
		}

		return IFrameSprite;
	})(HtmlSprite)


	//class ui.deskplatform.MainViewItemUI extends laya.ui.View
	var MainViewItemUI=(function(_super){
		function MainViewItemUI(){
			this.label=null;
			MainViewItemUI.__super.call(this);
		}

		__class(MainViewItemUI,'ui.deskplatform.MainViewItemUI',_super);
		var __proto=MainViewItemUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(MainViewItemUI.uiView);
		}

		MainViewItemUI.uiView={"type":"View","props":{"width":98,"height":21},"child":[{"type":"Label","props":{"y":0,"x":0,"width":98,"var":"label","text":"label","styleSkin":"comp/label.png","height":21,"color":"#d2201d"}}]};
		return MainViewItemUI;
	})(View)


	//class ui.deskplatform.MainViewUI extends laya.ui.View
	var MainViewUI=(function(_super){
		function MainViewUI(){
			this.itemList=null;
			this.contentBox=null;
			MainViewUI.__super.call(this);
		}

		__class(MainViewUI,'ui.deskplatform.MainViewUI',_super);
		var __proto=MainViewUI.prototype;
		__proto.createChildren=function(){
			View.regComponent("view.MainViewItem",MainViewItem);
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(MainViewUI.uiView);
		}

		MainViewUI.uiView={"type":"View","props":{"width":400,"height":300},"child":[{"type":"List","props":{"x":5,"width":126,"var":"itemList","vScrollBarSkin":"comp/vscroll.png","top":5,"scrollBarSkin":"comp/vscroll.png","repeatX":1,"bottom":5},"child":[{"type":"MainViewItem","props":{"y":0,"x":0,"runtime":"view.MainViewItem","name":"render"}}]},{"type":"Box","props":{"var":"contentBox","top":5,"skin":"comp/blank.png","right":5,"left":150,"bottom":5}}]};
		return MainViewUI;
	})(View)


	/**
	*...
	*@author ww
	*/
	//class view.MainViewItem extends ui.deskplatform.MainViewItemUI
	var MainViewItem=(function(_super){
		function MainViewItem(){
			this._dataO=null;
			MainViewItem.__super.call(this);
			this.on("click",this,this.onClick);
		}

		__class(MainViewItem,'view.MainViewItem',_super);
		var __proto=MainViewItem.prototype;
		__proto.initByData=function(dataO){
			this._dataO=dataO;
			this.label.text=dataO.name;
		}

		__proto.onClick=function(){
			console.log("onClick:",this._dataO);
			Notice.notify("OPEN_PLUGIN",this._dataO.path);
		}

		return MainViewItem;
	})(MainViewItemUI)


	/**
	*...
	*@author ww
	*/
	//class view.MainView extends ui.deskplatform.MainViewUI
	var MainView=(function(_super){
		function MainView(){
			this.iframeSprite=null;
			MainView.__super.call(this);
			this.iframeSprite=new IFrameSprite();
			this.iframeSprite.left=this.iframeSprite.right=this.iframeSprite.top=this.iframeSprite.bottom=0;
			this.itemList.renderHandler=new Handler(this,this.itemRender);
			this.init();
			Notice.listen("OPEN_PLUGIN",this,this.onOpenPlugin);
		}

		__class(MainView,'view.MainView',_super);
		var __proto=MainView.prototype;
		__proto.onOpenPlugin=function(path){
			console.log("onOpenPlugin:",path);
			this.iframeSprite.setUrl(path+"/index.html");
			this.contentBox.addChild(this.iframeSprite);
		}

		__proto.init=function(){
			var pluginFolder;
			pluginFolder=FileManager.getAppPath("plugins/");
			console.log("pluginFolder:",pluginFolder);
			if (!FileManager.exists(pluginFolder))return;
			var folders;
			folders=FileTools.getDirChildDirs(pluginFolder);
			var i=0,len=0;
			len=folders.length;
			var items;
			items=[];
			var tItem;
			var tFile;
			for (i=0;i < len;i++){
				tFile=folders[i];
				console.log("Plugin:",folders[i]);
				tItem={};
				tItem.name=FileTools.getFileName(tFile);
				tItem.path=tFile;
				items.push(tItem);
			}
			this.itemList.array=items;
		}

		__proto.itemRender=function(cell,index){
			(cell).initByData(cell.dataSource);
		}

		return MainView;
	})(MainViewUI)



	new DeskPlatform();

})(window,document,Laya);
