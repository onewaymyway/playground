
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var Box=laya.ui.Box,Browser=laya.utils.Browser,Button=laya.ui.Button,CMDShell=nodetools.devices.CMDShell;
	var CheckBox=laya.ui.CheckBox,Clip=laya.ui.Clip,Component=laya.ui.Component,ContextMenu$1=electrontools.menus.ContextMenu;
	var Device=nodetools.devices.Device,Dialog=laya.ui.Dialog,DisControlTool=laya.debug.tools.DisControlTool;
	var DragEvent=electrontools.drags.DragEvent,DragManager=electrontools.drags.DragManager,Event=laya.events.Event;
	var EventDispatcher=laya.events.EventDispatcher,File=nodetools.devices.File,FileManager=nodetools.devices.FileManager;
	var FileTools=nodetools.devices.FileTools,FocusManager=extendui.FocusManager,Handler=laya.utils.Handler,Image=laya.ui.Image;
	var Input=laya.display.Input,JSTools=laya.debug.tools.JSTools,KeyManager=extendui.KeyManager,Keyboard=laya.events.Keyboard;
	var Label=laya.ui.Label,List=laya.ui.List,ListBase$1=extendui.ui.ListBase,ListEx=extendui.ui.ListEx,Loader=laya.net.Loader;
	var MessageManager=electrontools.MessageManager,Node=laya.display.Node,NodeTree$1=extendui.ui.NodeTree,NodeUtils=laya.debug.view.nodeInfo.NodeUtils;
	var OSInfo=nodetools.devices.OSInfo,Paths=nodetools.devices.Paths,Point=laya.maths.Point,PythonTools=nodetools.devices.PythonTools;
	var RenderContext=laya.renders.RenderContext,Sprite=laya.display.Sprite,Stage=laya.display.Stage,StringTool=laya.debug.tools.StringTool;
	var Styles=laya.ui.Styles,Sys=nodetools.devices.Sys,SystemDragOverManager=electrontools.drags.SystemDragOverManager;
	var SystemSetting=nodetools.devices.SystemSetting,TextInput=laya.ui.TextInput,TreeBase$1=extendui.ui.TreeBase;
	var TreeEx=extendui.ui.TreeEx,UIConfig=Laya.UIConfig,Utils=laya.utils.Utils,View=laya.ui.View;
	/**
	*IDE可视化编辑样式
	*/
	//class configs.StyleConsts
	var StyleConsts=(function(){
		function StyleConsts(){};
		__class(StyleConsts,'configs.StyleConsts');
		StyleConsts.StageBgColor="#ffffff";
		StyleConsts.DefaultTextColor="#c5c5c5";
		StyleConsts.CheckBoxLabelColors="#c5c5c5,#c5c5c5,#c5c5c5,#c5c5c5";
		StyleConsts.ComboBoxLabelColors="#c5c5c5,#c5c5c5,#c5c5c5,#c5c5c5";
		StyleConsts.ComboBoxItemColors="#d5dee3,#61737C,#61737C,#EFF4F7,#e2e7e9";
		StyleConsts.TextInputColor="#ff0000";
		StyleConsts.ButtonLabelColors="#efefef,#ffffff,#c5c5c5,#c5c5c5";
		StyleConsts.TabLabelColors="#efefef,#ffffff,#c5c5c5,#c5c5c5";
		StyleConsts.TreeFolderColor="#c5c5c5";
		StyleConsts.TreeItemColor="#c5c5c5";
		StyleConsts.TreeSelectColor="#ffffff";
		StyleConsts.LayoutTabTitleBtnColors="#8a8a8a,#c8c8c8,#c8c8c8,#c8c8c8";
		StyleConsts.SkinBtnLabelColors="#44a7ff,#44a7ff,#44a7ff,#44a7ff";
		StyleConsts.BroswerButtonLabelColors="#c5c5c5,#c5c5c5,#c5c5c5";
		StyleConsts.SelectItemInfoColor="#9f9f9f";
		StyleConsts.PanelTipTextColor="#00cc00";
		StyleConsts.PanelTipTextColor2="#cccc00";
		StyleConsts.RuleGridLineColor="#696969";
		StyleConsts.RuleGridTextColor="#696969";
		StyleConsts.RuleRangeColor="#dddddd";
		StyleConsts.AutoAlignLineColor="#ff0000";
		StyleConsts.ReferLineColor="#00ffff";
		StyleConsts.TimelineTitleColor="#d8d8d8";
		StyleConsts.PropPanelTitleColor="#44a7ff";
		StyleConsts.PropLabelColor="#8a8a8a";
		StyleConsts.fileNameRestrict="0-9a-zA-Z_";
		StyleConsts.NumberRestrict="0-9.-";
		StyleConsts.IntRestrict="0-9-";
		StyleConsts.DisplayIconWidth=14;
		StyleConsts.DisplayIconHeight=14;
		StyleConsts.PropLabelBindSuc="#ffff00";
		StyleConsts.PropLabelBindWrong="#ff0000";
		StyleConsts.Prop_PromptColor="#414141";
		StyleConsts.DisplayTreeItemLoseScriptColor="#ff0000";
		StyleConsts.DisplayTreeItemPrefabColor="#ff6400";
		StyleConsts.InputSkin="comp/input_20.png";
		StyleConsts.PropInputWithIconPadding="1,52,1,5";
		StyleConsts.PropInputPadding="";
		StyleConsts.PropInputHeight=20;
		StyleConsts.ComboxSkin="comp/combo_20.png";
		return StyleConsts;
	})()


	/**
	*...
	*@author ww
	*/
	//class DeskPlatform
	var DeskPlatform=(function(){
		function DeskPlatform(){
			Laya.init(800,600);
			Laya.stage.scaleMode="full";
			Laya.stage.bgColor="#ffffff";
			UIConfig.touchScrollEnable=false;
			Styles.buttonLabelColors=["#ffffff","#32cc6b","#ff0000","#C0C0C0"];
			View.regComponent("TreeEx",TreeEx);
			View.regComponent("List",ListBase$1);
			View.regComponent("Tree",TreeBase$1);
			View.regComponent("ListEx",ListEx);
			this.init();
			var resList;
			resList=[ {"url":"res/atlas/comp.json","type":"atlas" }];
			resList.push({"url":"res/atlas/view.json","type":"atlas" });
			resList.push({"url":"res/atlas/play.json","type":"atlas"});
			Laya.loader.load(resList,new Handler(this,this.test));
		}

		__class(DeskPlatform,'DeskPlatform');
		var __proto=DeskPlatform.prototype;
		__proto.init=function(){
			Device.Buffer=Buffer;
			Device.init();
			SystemSetting.isCMDVer=false;
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
			this.testResPanel();
			return;
			var mainView;
			mainView=new MainView();
			mainView.left=mainView.right=mainView.top=mainView.bottom=5;
			Laya.stage.addChild(mainView);
		}

		__proto.testResPanel=function(){
			SystemSetting.assetsPath="D:/codes/playground.git/trunk/debugtoolplatform/deskplatform";
			ResPanel.instance.init(SystemSetting.assetsPath);
			ResPanel.instance.top=0;
			ResPanel.instance.bottom=0;
			Laya.stage.addChild(ResPanel.instance);
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


	//class ui.deskplatform.ResPanelUI extends laya.ui.View
	var ResPanelUI=(function(_super){
		function ResPanelUI(){
			this.resTree=null;
			this.resViewer=null;
			this.opBox=null;
			this.fliterTxt=null;
			this.clearSearchBtn=null;
			this.sizeTxt=null;
			ResPanelUI.__super.call(this);
		}

		__class(ResPanelUI,'ui.deskplatform.ResPanelUI',_super);
		var __proto=ResPanelUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(ResPanelUI.uiView);
		}

		ResPanelUI.uiView={"type":"View","props":{"width":200,"title":"资源","scenecolor":"#dddddd","hitTestPrior":true,"height":300},"child":[{"type":"Image","props":{"y":48,"x":415,"width":200,"top":0,"skin":"view/bg_panel.png","right":0,"left":0,"height":300,"bottom":0}},{"type":"TreeEx","props":{"y":552,"x":173,"width":196,"var":"resTree","top":112,"scrollBarSkin":"comp/vscroll.png","right":2,"left":2,"hitTestPrior":true,"height":136,"bottom":29},"child":[{"type":"Box","props":{"right":0,"name":"render","left":0},"child":[{"type":"Clip","props":{"y":0,"x":13,"skin":"comp/clip_selectBox.png","right":0,"name":"selectBox","left":9,"height":25,"clipY":2}},{"type":"Image","props":{"y":4,"x":14,"skin":"comp/folder.png","name":"icon","width":16,"height":16}},{"type":"Label","props":{"y":1,"width":150,"text":"label","right":0,"padding":"4,0,0,0","name":"label","left":38,"height":22,"color":"#d8d8d8"}},{"type":"Clip","props":{"y":6,"x":0,"skin":"comp/clip_tree.png","name":"arrow","clipY":2,"width":11,"height":12}}]}]},{"type":"Image","props":{"y":3,"x":222,"width":198,"var":"resViewer","right":1,"left":1,"height":100}},{"type":"Image","props":{"y":106,"x":2,"skin":"comp/line.png","right":0,"left":0,"height":1}},{"type":"Box","props":{"y":271,"x":1,"width":198,"var":"opBox","right":0,"left":0,"height":28,"bottom":0},"child":[{"type":"Image","props":{"width":191,"top":0,"skin":"view/bg_panel_bar.png","right":0,"left":0,"bottom":0}},{"type":"TextInput","props":{"y":4,"x":80,"width":148,"var":"fliterTxt","toolTip":"输入关键词过滤","skin":"comp/input_filter.png","right":5,"padding":"0,10,0,20","left":80,"color":"#dddddd","sizeGrid":"0,3,0,3"}},{"type":"Button","props":{"y":3,"x":3,"toolTip":"打开所在目录","stateNum":3,"skin":"view/login2.png","name":"openDirBtn","scaleX":0.5,"scaleY":0.5}},{"type":"Button","props":{"y":3,"x":29,"toolTip":"设置默认属性","stateNum":3,"skin":"view/settings2.png","name":"setPropBtn","scaleX":0.5,"scaleY":0.5}},{"type":"Button","props":{"y":4,"x":55,"toolTip":"刷新资源树","stateNum":3,"skin":"view/refresh2.png","name":"refreshBtn","scaleX":0.5,"scaleY":0.5}},{"type":"Clip","props":{"y":7,"x":82,"skin":"view/search.png","clipY":1,"index":0,"scaleX":0.5,"scaleY":0.5}},{"type":"Button","props":{"y":12,"var":"clearSearchBtn","skin":"view/btn_close1.png","right":9,"scaleX":0.5,"scaleY":0.5,"stateNum":2}}]},{"type":"Label","props":{"y":82,"x":6,"width":162,"var":"sizeTxt","text":"512*512","padding":"4,0,0,0","name":"label","height":19,"color":"#d8d8d8","align":"left"}}]};
		return ResPanelUI;
	})(View)


	//class ui.deskplatform.AlertUI extends laya.ui.Dialog
	var AlertUI=(function(_super){
		function AlertUI(){
			this.titleLbl=null;
			this.msgLbl=null;
			AlertUI.__super.call(this);
		}

		__class(AlertUI,'ui.deskplatform.AlertUI',_super);
		var __proto=AlertUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(AlertUI.uiView);
		}

		AlertUI.uiView={"type":"Dialog","props":{"width":500,"scenecolor":"#dddddd","height":250},"child":[{"type":"Image","props":{"y":0,"x":0,"width":500,"skin":"view/bg_dialog.png","height":250,"sizeGrid":"47,20,22,37"}},{"type":"Button","props":{"x":404,"skin":"view/btn_close.png","name":"close","scaleX":0.5,"scaleY":0.5,"right":11,"y":7}},{"type":"Image","props":{"y":7,"x":9,"width":442,"skin":"comp/blank_title_dragrec.png","name":"drag","height":36}},{"type":"Label","props":{"x":28,"var":"titleLbl","text":"提示","styleSkin":"comp/label_panel_title.png","fontSize":14,"align":"center","color":"#ffffff","centerX":0,"y":16}},{"type":"Label","props":{"y":80,"x":39,"wordWrap":true,"width":422,"var":"msgLbl","valign":"middle","text":"确认内容","styleSkin":"comp/label_intro.png","multiline":true,"mouseEnabled":false,"mouseChildren":false,"isHtml":true,"height":65,"align":"center","fontSize":14,"color":"#C8C8C8"}},{"type":"Button","props":{"y":173,"x":190,"skin":"comp/button.png","name":"sure","label":"确定","labelColors":"#FFFFFF,#FFFFFF,#FFFFFF,#c5c5c5","labelSize":16,"sizeGrid":"0,4,0,4"}}]};
		return AlertUI;
	})(Dialog)


	//class ui.deskplatform.ConfirmUI extends laya.ui.Dialog
	var ConfirmUI=(function(_super){
		function ConfirmUI(){
			this.titleLbl=null;
			this.msgLbl=null;
			this.cancelBtn=null;
			this.okBtn=null;
			ConfirmUI.__super.call(this);
		}

		__class(ConfirmUI,'ui.deskplatform.ConfirmUI',_super);
		var __proto=ConfirmUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(ConfirmUI.uiView);
		}

		ConfirmUI.uiView={"type":"Dialog","props":{"width":500,"scenecolor":"#dddddd","height":250},"child":[{"type":"Image","props":{"y":0,"x":0,"width":500,"skin":"view/bg_dialog.png","height":250,"sizeGrid":"47,20,22,37"}},{"type":"Button","props":{"x":404,"skin":"view/btn_close.png","name":"close","scaleX":0.5,"scaleY":0.5,"right":11,"y":7}},{"type":"Image","props":{"y":7,"x":9,"width":441,"skin":"comp/blank_title_dragrec.png","name":"drag","height":36}},{"type":"Label","props":{"x":21,"var":"titleLbl","text":"确认框","styleSkin":"comp/label_panel_title.png","fontSize":14,"align":"center","color":"#ffffff","centerX":0,"y":16}},{"type":"Label","props":{"y":68,"x":36,"wordWrap":true,"width":427,"var":"msgLbl","valign":"middle","text":"确认内容","styleSkin":"comp/label_intro.png","multiline":true,"mouseEnabled":false,"mouseChildren":false,"isHtml":true,"height":76,"align":"center","fontSize":14,"color":"#C8C8C8"}},{"type":"Button","props":{"y":165,"x":288,"var":"cancelBtn","skin":"comp/btn.png","name":"cancel","label":"取消","labelColors":"#FFFFFF,#FFFFFF,#FFFFFF,#c5c5c5","labelSize":16,"sizeGrid":"0,4,0,4"}},{"type":"Button","props":{"y":165,"x":98,"var":"okBtn","skin":"comp/button.png","name":"sure","label":"确定","labelColors":"#FFFFFF,#FFFFFF,#FFFFFF,#c5c5c5","labelSize":16,"sizeGrid":"0,4,0,4"}}]};
		return ConfirmUI;
	})(Dialog)


	//class ui.deskplatform.RenameResUI extends laya.ui.Dialog
	var RenameResUI=(function(_super){
		function RenameResUI(){
			this.nameTxt=null;
			this.updateCheck=null;
			this.resLbl=null;
			RenameResUI.__super.call(this);
		}

		__class(RenameResUI,'ui.deskplatform.RenameResUI',_super);
		var __proto=RenameResUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(RenameResUI.uiView);
		}

		RenameResUI.uiView={"type":"Dialog","props":{"width":500,"scenecolor":"#dddddd","height":250},"child":[{"type":"Image","props":{"y":0,"x":0,"width":500,"skin":"view/bg_dialog.png","height":250,"sizeGrid":"47,20,22,37"}},{"type":"Button","props":{"skin":"view/btn_close.png","name":"close","scaleX":0.5,"scaleY":0.5,"right":11,"y":7}},{"type":"Image","props":{"y":7,"x":9,"width":446,"skin":"comp/blank_title_dragrec.png","name":"drag","height":36}},{"type":"Label","props":{"x":28,"text":"重命名资源","styleSkin":"comp/label_panel_title.png","fontSize":14,"align":"center","color":"#ffffff","centerX":0,"y":16}},{"type":"Label","props":{"y":104,"x":4,"width":127,"text":"新名称：","styleSkin":"comp/label_intro.png","height":18,"align":"right","fontSize":14,"color":"#C8C8C8"}},{"type":"TextInput","props":{"y":99,"x":135,"width":300,"var":"nameTxt","skin":"comp/input_32.png","sizeGrid":"0,3,0,3","color":"#CCCCCC","fontSize":14,"padding":"0,4,0,4","height":32}},{"type":"CheckBox","props":{"y":146,"x":87,"width":314,"var":"updateCheck","skin":"comp/checkbox_16.png","selected":true,"label":"是否更新页面引用(不选择能提高性能)","height":16,"labelColors":"#CCCCCC","labelSize":14,"labelPadding":"0,0,0,6"}},{"type":"Label","props":{"y":65,"x":8,"width":123,"text":"原名称：","styleSkin":"comp/label_intro.png","height":18,"align":"right","fontSize":14,"color":"#C8C8C8"}},{"type":"Label","props":{"y":65,"x":135,"width":214,"var":"resLbl","text":"资源内容","styleSkin":"comp/label_highlight.png","height":20,"color":"#cccc00","fontSize":14}},{"type":"Button","props":{"y":178,"x":85,"skin":"comp/button.png","name":"sure","label":"确定","labelColors":"#FFFFFF,#FFFFFF,#FFFFFF,#c5c5c5","labelSize":16,"sizeGrid":"0,4,0,4"}},{"type":"Button","props":{"y":178,"x":295,"skin":"comp/btn.png","name":"cancel","label":"取消","labelColors":"#FFFFFF,#FFFFFF,#FFFFFF,#c5c5c5","labelSize":16,"sizeGrid":"0,4,0,4"}}]};
		return RenameResUI;
	})(Dialog)


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


	/**资源面板
	*@author yung
	*/
	//class view.ResPanel extends ui.deskplatform.ResPanelUI
	var ResPanel=(function(_super){
		function ResPanel(){
			this._resPath=null;
			this._refreshComplete=null;
			this._mouseIndex=0;
			this._dirWatcherWrap=null;
			this.isRefreshing=false;
			this._withTip=true;
			this._menu=null;
			this._mutiMenu=null;
			this._menuDir=null;
			ResPanel.__super.call(this);
			this.initPanel();
			this.resTree.spaceLeft=15;
			this.resTree.mList.onlySameParentSelect=true;
		}

		__class(ResPanel,'view.ResPanel',_super);
		var __proto=ResPanel.prototype;
		__proto.onDirFileChanged=function(){
			this.refresh(null,false,false);
		}

		__proto.initListener=function(){}
		/**刷新资源树*/
		__proto.init=function(resPath,complete){
			var force=false;
			force=this._resPath==resPath;
			this._resPath=resPath;
			this.refresh(complete,force);
		}

		__proto.onTreeMouse=function(e,index){
			var cell=this.resTree.list.getCell(index);
			if(!cell)return;
			var label=cell.getChildByName("label");
			if (e.type=="mouseover"){
				label.color=StyleConsts.TreeSelectColor;
			}else
			if (e.type=="mouseout"){
				var item=cell.dataSource;
				if (!item)return;
				label.color=item.hasChild?StyleConsts.TreeFolderColor:StyleConsts.TreeItemColor;
			}
		}

		__proto.selecteByFile=function(file){
			var arr;
			arr=this.resTree.source;
			this.parseOpen(arr,file.split("/"),null,true);
			this.resTree.fresh();
		}

		__proto.parseOpen=function(tree,arr,parentPath,flashSelected){
			(flashSelected===void 0)&& (flashSelected=false);
			if(arr.length<1)return;
			var tStr=arr.shift();
			var i=0,len=0;
			len=tree.length;
			var tItem;
			if(!parentPath){
				parentPath=this._resPath;
			};
			var tPath;
			tPath=FileManager.getPath(parentPath,tStr);
			tPath=FileManager.adptToCommonUrl(tPath);
			for(i=0;i<len;i++){
				tItem=tree[i];
				if(tItem.label==tStr)
					if(FileManager.adptToCommonUrl(tItem.path)==tPath){
					if(arr.length>0){
						tItem.isOpen=true;
						this.resTree.fresh();
						this.parseOpen(tItem.childs,arr,tPath,flashSelected);
						}else{
						this.resTree.selectedItem=tItem;
						if(flashSelected){
							if(this.resTree.mList.selection)
								FocusManager.flashItem(this.resTree.mList.selection);
						}
					}
					return;
				}
			}
		}

		/**刷新*/
		__proto.refresh=function(refreshComplete,force,withTip){
			(force===void 0)&& (force=false);
			(withTip===void 0)&& (withTip=true);
			if(this.isRefreshing&&!force)return;
			this._refreshComplete=refreshComplete;
			this.isRefreshing=true;
			this._withTip=withTip;
			this.createComplete();
		}

		//createComplete(null);
		__proto.createComplete=function(){
			this.isRefreshing=false;
			var arr;
			arr=FileTools.getFileTreeArr(SystemSetting.assetsPath);
			var i=0,len=0;
			this.resTree.array=arr;
			this.onFliterTxtChange(null);
			this.onResTreeChange(null);
			if (this._refreshComplete !=null){
				this._refreshComplete.run();
				}else {
				if(this.displayedInStage&&this._withTip)
					MessageManager.I.show(Sys.lang("资源刷新完毕"));
			}
		}

		__proto.initPanel=function(){
			this.resTree.array=[];
			this.resTree.on("doubleclick",this,this.onResTreeDoubleClick);
			this.resTree.on("rightclick",this,this.onResTreeRightMouseDown);
			this.resTree.mouseHandler=new Handler(this,this.onResTreeMouse);
			var menu=ContextMenu$1.createMenu("设置默认属性","打开所在目录","查找引用","替换选中对象","","重命名","删除");
			menu.on("select",this,this.onEmunSelect);
			this._menu=menu;
			this._menuDir=ContextMenu$1.createMenu("设置默认属性","打开所在目录","","重命名","删除");
			this._menuDir.on("select",this,this.onEmunSelect);
			this._mutiMenu=ContextMenu$1.createMenu("设置默认属性","删除");
			this._mutiMenu.on("select",this,this.onEmunSelect);
			this.fliterTxt.on("input",this,this.onFliterTxtChange);
			this.fliterTxt.color=StyleConsts.TextInputColor;
			this.opBox.on("click",this,this.onOpBoxClick);
			this.resTree.on("change",this,this.onResTreeChange);
			this.resTree.renderHandler=new Handler(this,this.resTreeRender);
			this.resTree.on("keydown",this,this.onResTreeKeyDown);
			this.on("dragDrop",this,this.onResTreeDragDrop);
			this.resTree.on("keydown",this,this.onTreeKeyDown);
			this.on("click",this,this.onClick);
			this.clearSearchBtn.on("mousedown",this,this.onClearSearch);
		}

		__proto.onClearSearch=function(){
			if(this.fliterTxt.text!=""){
				this.fliterTxt.text="";
				this.onFliterTxtChange(null);
			}
		}

		__proto.onClick=function(e){
			var target=e.target;
			if (!DisControlTool.isChildE(this,target)||target==this.resTree.mList.content){
				this.resTree.mList.clearSelect(true);
			}
		}

		__proto.systemDrag=function(data,dir){
			var files;
			files=data.files;
			var i=0,len=files.length;
			for(i=0;i<len;i++){
				var tFile;
				tFile=files[i].path;
				var fileName;
				fileName=files[i].name;
				FileTools.copyE(tFile,FileManager.getPath(dir,fileName));
			}
			this.refresh();
		}

		__proto.onResTreeDragDrop=function(e){
			if (!e.data)return;
			if (!(e.data.type=="res" || e.data.type=="resDir"||e.data.type=="multiResFile"||e.data.type=="displayDrag"||e.data.type=="SystemDrag"))return;
			var targetFile;
			debugger;
			var hitList;
			hitList=e.hitList;
			var i=0,len=0;
			len=hitList.length;
			for (i=0;i < len;i++){
				if (hitList[i].dataSource && hitList[i].dataSource.path){
					targetFile=new File(hitList[i].dataSource.path);
					break ;
				}
			};
			var targetDir;
			if (!targetFile){
				targetFile=targetDir=new File(this._resPath);
				}else{
				targetDir=targetFile.isDirectory ? targetFile :targetFile.parent;
			}
			if(e.data.type=="SystemDrag"){
				this.systemDrag(e.data,targetDir.nativePath);
				return;
			};
			var selectList;
			selectList=this.resTree.mList.selectItems;
			len=selectList.length;
			var fileList;
			fileList=[];
			var tFile;
			var tarForder;
			tarForder=FileManager.adptToCommonUrl(targetDir.nativePath);
			for(i=0;i<len;i++){
				tFile=selectList[i].path;
				fileList.push(tFile);
				if(FileTools.getFolder(tFile)==tarForder){
					return;
				}
				if(targetDir.nativePath.indexOf(tFile)>=0){
					MessageManager.I.show(Sys.lang("不能把文件拖动到子文件夹中"));
					return;
				}
			}
			if(!fileList||fileList.length<1)return;
			if(fileList.length==1){
			}
			this.resTree.mList.clearSelect();
			this.moveFileList(fileList,targetDir.nativePath);
		}

		/**移动资源*/
		__proto.move=function(oldFile,newFile,isUpdate){
			oldFile.moveTo(newFile.nativePath);
			this.refresh();
		}

		__proto.moveByFilePath=function(oldPath,tarDir,isUpdate){
			(isUpdate===void 0)&& (isUpdate=true);
			var oldFile=new File(oldPath);
			var newFile=new File(FileManager.getPath(tarDir,oldFile.name));
			this.move(oldFile,newFile,isUpdate);
		}

		__proto.moveFileList=function(fileList,tarDir,isUpdate){
			(isUpdate===void 0)&& (isUpdate=true);
			var i=0,len=0;
			len=fileList.length;
			for(i=0;i<len;i++){
				this.moveByFilePath(fileList[i],tarDir,isUpdate);
			}
		}

		/**快捷键*/
		__proto.onResTreeKeyDown=function(e){
			if (e.keyCode==46||e.keyCode==Keyboard.MacDELETE){
				this.deleteRes();
			}
			if (e.keyCode==113){
				this.checkRename();
			}
		}

		/**删除资源*/
		__proto.deleteRes=function(){
			if(this.resTree.mList.selectItems&&this.resTree.mList.selectItems.length>1){
				Confirm.show(Sys.lang("确定要删除所选的文件吗？(删除后可以在回收站里找回)"),Sys.lang("确定删除资源吗"),Utils.bind(this.delSelectItems,this));
				return;
			}
			if (Boolean(this.resTree.selectedPath)){
				var filePath=FileManager.getRelativePath(this._resPath,this.resTree.selectedPath);
				var type=this.resTree.selectedItem.isDirectory ? Sys.lang("目录"):Sys.lang("资源");
				Confirm.show(Sys.lang("确定要删除{0}({1})吗？(删除后可以在回收站里找回)",type,filePath),Sys.lang("确定删除资源吗"),Utils.bind(this.delBack,this));
			}
		}

		/**处理资源删除*/
		__proto.delBack=function(sure){
			if (sure){
				FileManager.removeFile(this.resTree.selectedPath);
				this.refresh();
			}
			Laya.stage.focus=this.resTree;
		}

		__proto.delSelectItems=function(sure){
			if (sure){
				var selectList;
				selectList=this.resTree.mList.plainSelectItems;
				var i=0,len=0;
				len=selectList.length;
				for(i=0;i<len;i++){
					FileManager.removeFile(selectList[i].path);
				}
				this.resTree.mList.clearSelect();
				this.refresh();
			}
			Laya.stage.focus=this.resTree;
		}

		__proto.onResTreeChange=function(e){
			this.cleanViewer();
			if (this.resTree.selectedItem && !this.resTree.selectedItem.isDirectory){
				var asset=this.resTree.selectedItem.path;
				var extension;
				extension=FileTools.getExtensionName(asset);
				extension=extension.toLocaleLowerCase();
				if (extension !="jpg" && extension !="png")return;
				var img=new Image();
				img.visible=false;
				img.once("loaded",this,this.setResSize,[img]);
				var tImgPath;
				tImgPath=FileTools.getAbsPath(asset);
				var changeTime;
				changeTime=FileTools.getMTime(tImgPath).toString();
				img.skin=tImgPath+"?v="+changeTime;
				this.resViewer.addChild(img);
			}
		}

		/**设置资源大小*/
		__proto.setResSize=function(target){
			var scale=Math.min(this.resViewer.width / target.width,this.resViewer.height / target.height,1);
			target.scaleX=target.scaleY=scale;
			target.x=(this.resViewer.width-scale*target.width)/ 2;
			target.y=(this.resViewer.height-scale*target.height)/ 2;
			this.sizeTxt.text=target.width+" x "+target.height;
			target.visible=true;
		}

		__proto.changeSize=function(){
			laya.ui.Component.prototype.changeSize.call(this);
			if(this.resViewer&&this.resViewer.numChildren>0){
				this.setResSize(this.resViewer.getChildAt(0));
			}
		}

		/**清理resViewer*/
		__proto.cleanViewer=function(){
			this.sizeTxt.text="";
			for (var i=this.resViewer.numChildren-1;i >-1;i--){
				this.resViewer.removeChildAt(i).offAll("resize");
			}
		}

		__proto.onOpBoxClick=function(e){
			var btn=e.target;
			if (btn){
				switch (btn.name){
					case "openDirBtn":
						this.openCurrDirectory();
						break ;
					case "refreshBtn":
						this.refresh();
						break ;
					}
			}
		}

		/**打开当前资源所在的文件夹*/
		__proto.openCurrDirectory=function(){
			FileTools.openItem(this.currDirectory);
		}

		__proto.openCurrPath=function(){
			var directory=this._resPath;
			if (this.resTree.selectedItem !=null){
				var path=this.resTree.selectedItem.path;
				FileTools.showItemInFolder(path);
				return;
			}
			FileTools.openItem(directory);
		}

		__proto.onFliterTxtChange=function(e){
			this.resTree.filter(this.fliterTxt.text);
		}

		__proto.onEmunSelect=function(name){
			switch (name){
				case "设置默认属性":
					break ;
				case "打开所在目录":
					this.openCurrPath();
					break ;
				case "重命名":
					this.checkRename();
					break ;
				case "删除":
					this.deleteRes();
					break ;
				}
		}

		__proto.checkRename=function(){
			if (Boolean(this.resTree.selectedPath)){
				var fileName=this.resTree.selectedItem.path;
				RenameRes.instance.start(fileName);
				}else {
				Alert.show(Sys.lang("当前资源为SWF资源，不能直接重命名"));
			}
		}

		__proto.rename=function(prePath,newName,isUpdate){
			if (!Boolean(newName)){
				return Alert.show(Sys.lang("新名称不能为空"));
			};
			var oldFile=new File(this.resTree.selectedPath);
			if (!oldFile.isDirectory){
				newName+="."+oldFile.extension;
			};
			var oldName=this.resTree.selectedItem.label;
			if (oldFile.name !=newName){
				var oldPath=oldFile.nativePath;
				var newPath=(oldPath+"##").replace(oldFile.name+"##",newName);
				if (this.hasFile(newPath)){
					Alert.show(Sys.lang("已经有同名字的资源了，请换个名字试试"),Sys.lang("命名重复"));
					}else {
					FileManager.rename(oldPath,newPath);
					this.refresh();
				}
			}
		}

		/**是否已经存在同路径文件*/
		__proto.hasFile=function(path){
			var arr=this.resTree.source;
			var item;
			for(var $each_item in arr){
				item=arr[$each_item];
				if (item.path==path){
					return true;
				}
			}
			return false;
		}

		__proto.getSelectFiles=function(){
			var i=0,len=0;
			var selectList;
			selectList=this.resTree.mList.selectItems;
			len=selectList.length;
			var fileList;
			fileList=[];
			var tFile;
			for(i=0;i<len;i++){
				tFile=selectList[i].path;
				fileList.push(tFile);
			}
			return fileList;
		}

		__proto.onResTreeMouse=function(e,index){
			if (e.type=="mousedown"){
				Laya.stage.focus=this.resTree;
				this._mouseIndex=index;
				var clip=new Clip("",1,3);
				clip.index=2;
				if(this.resTree.mList.selectItems&&this.resTree.mList.selectItems.length>1){
					DragManager.I.doDrag(e.currentTarget,clip,{type:"multiResFile",fileList:this.getSelectFiles()},DragManager.dragOffset);
					return;
				};
				var asset=this.resTree.array[index].path;
				if (this.resTree.array[index].isDirectory){
					DragManager.I.doDrag(e.currentTarget,clip,{type:"resDir",asset:asset},DragManager.dragOffset);
					}else {
					var dragType;
					dragType="res";
					if(/*no*/this.compType=="Props"){
						dragType="Props";
					}
					DragManager.I.doDrag(e.currentTarget,clip,{type:dragType,asset:asset},DragManager.dragOffset);
				}
			};
			var cell=this.resTree.list.getCell(index);
			var label=cell.getChildByName("label");
			if (e.type=="mouseover"){
				TreeEx.onItemCellMouseOver(index,cell,this.resTree);
				label.color=StyleConsts.TreeSelectColor;
			}else
			if (e.type=="mouseout"){
				var item=cell.dataSource;
				if (!item)return;
				label.color=item.hasChild?StyleConsts.TreeFolderColor:StyleConsts.TreeItemColor;
			}
		}

		__proto.onResTreeRightMouseDown=function(e){
			if(this.resTree.mList.selectItems&&this.resTree.mList.selectItems.length>1){
				this._mutiMenu.show();
				return;
			};
			var comp=e.target;
			if (comp && comp.dataSource){
				this.resTree.selectedItem=comp.dataSource;
			}
			if(this.resTree.selectedPath&&FileTools.isDirectory(this.resTree.selectedPath)){
				this._menuDir.show();
				return;
			}
			this._menu.show();
		}

		__proto.onResTreeDoubleClick=function(e){
			if (e.target.parent==this.resTree.list.content){
			}
		}

		/**页面快捷键*/
		__proto.onTreeKeyDown=function(e){
			if(KeyManager.isABC(e.keyCode)&&!KeyManager.I.isCommandKeyDown){
				ListEx.dealAbcKey(e.keyCode,this.resTree.list);
			}
			switch(e.keyCode){
				case 46:
				case Keyboard.MacDELETE:
					break ;
				case 113:
					this.checkRename();
					break ;
				case 37:
					this.resTree.setItemState(this.resTree.list.selectedIndex,false);
					break ;
				case 39:
					this.resTree.setItemState(this.resTree.list.selectedIndex,true);
					break ;
				case 38:
					if (this.resTree.list.selectedIndex > 0){
						this.resTree.list.selectedIndex--;
					}
					break ;
				case 40:
					if (this.resTree.list.selectedIndex < this.resTree.list.length-1){
						this.resTree.list.selectedIndex++;
					}
					break ;
				}
		}

		/**属性更改后，属性列表*/
		__proto.refreshProp=function(){
			this.resTree.array=this.resTree.source;
		}

		__proto.resTreeRender=function(cell,index){
			var item=cell.dataSource;
			var compStr;
			if (item){
				var icon=cell.getChildByName("icon");
				var isDirectory=item.child || item.isDirectory;
				var label=cell.getChildByName("label");
				icon.width=StyleConsts.DisplayIconWidth;
				icon.height=StyleConsts.DisplayIconHeight;
				if (isDirectory){
					if(item.isOpen){
						icon.skin="view/folder_open.png";
						}else{
						icon.skin="view/folder_close.png";
					}
					label.color=StyleConsts.TreeFolderColor;
					compStr=FileManager.adptToCommonUrl(FileManager.getResRelativePath(item.path));
					}else {
					label.text=item.label;
					compStr=FileManager.adptToCommonUrl(FileManager.getResRelativePath(item.path));
					label.color=StyleConsts.TreeItemColor;
					icon.skin="view/ui.png";
				}
			}
		}

		__getset(0,__proto,'visible',function(){
			return _super.prototype._$get_visible.call(this);
			},function(value){
			_super.prototype._$set_visible.call(this,value);
		});

		/**获取当前目录*/
		__getset(0,__proto,'currDirectory',function(){
			var directory=this._resPath;
			if (this.resTree.selectedItem !=null){
				var path=this.resTree.selectedItem.path;
				return FileTools.getFileDir(path);
			}
			return directory;
		});

		__getset(0,__proto,'dataSource',_super.prototype._$get_dataSource,function(value){
			_super.prototype._$set_dataSource.call(this,value);
		});

		__getset(1,ResPanel,'instance',function(){
			return ResPanel._instance ? ResPanel._instance :ResPanel._instance=new ResPanel();
		},ui.deskplatform.ResPanelUI._$SET_instance);

		ResPanel._instance=null
		return ResPanel;
	})(ResPanelUI)


	/**提示框
	*@author yung
	*/
	//class view.Alert extends ui.deskplatform.AlertUI
	var Alert=(function(_super){
		function Alert(){Alert.__super.call(this);;
		};

		__class(Alert,'view.Alert',_super);
		var __proto=Alert.prototype;
		__proto.start=function(msg,title){
			this.titleLbl.text=title;
			this.msgLbl.text=msg;
			this.popup();
		}

		__getset(1,Alert,'instance',function(){
			return Alert._instance?Alert._instance:Alert._instance=new Alert();
		},ui.deskplatform.AlertUI._$SET_instance);

		Alert.show=function(msg,title){
			(title===void 0)&& (title="提示");
			if(title=="提示"){
				title=/*no*/this.Sys.lang("提示");
			}
			Alert.instance.start(msg,title);
		}

		Alert._instance=null
		return Alert;
	})(AlertUI)


	/**确认框
	*@author yung
	*/
	//class view.Confirm extends ui.deskplatform.ConfirmUI
	var Confirm=(function(_super){
		function Confirm(){
			this._handler=null;
			this._args=null;
			Confirm.__super.call(this);
			this.on("keydown",this,this.onKeyDown);
		}

		__class(Confirm,'view.Confirm',_super);
		var __proto=Confirm.prototype;
		__proto.start=function(msg,title,handler,args){
			this.titleLbl.text=title;
			this.msgLbl.text=msg;
			this._handler=handler;
			this._args=args;
			this.popup();
			KeyManager.setNewFocus(this);
		}

		__proto.close=function(type){
			laya.ui.Dialog.prototype.close.call(this,type);
			if (this._handler !=null){
				var data=[type=="sure",type];
				if((this._handler instanceof laya.utils.Handler )){
					(this._handler).runWith(data);
				}else
				this._handler.apply(null,this._args ? this._args.concat(data):data);
			}
			KeyManager.restoreFocus();
		}

		__proto.onKeyDown=function(e){
			switch(e.keyCode){
				case 13:
					this.close("sure");
					break ;
				case 27:
					this.close("cancel");
					break ;
				}
		}

		__getset(1,Confirm,'instance',function(){
			return Confirm._instance ? Confirm._instance :Confirm._instance=new Confirm();
		},ui.deskplatform.ConfirmUI._$SET_instance);

		Confirm.show=function(msg,title,handler,args,okName,cancelName){
			if(!okName)okName=/*no*/this.Sys.lang("确定");
			if(!cancelName)cancelName=/*no*/this.Sys.lang("取消");
			Confirm.instance.okBtn.label=okName;
			Confirm.instance.cancelBtn.label=cancelName;
			Confirm.instance.start(msg,title,handler,args);
		}

		Confirm._instance=null
		return Confirm;
	})(ConfirmUI)


	/**重命名资源
	*@author yung
	*/
	//class view.RenameRes extends ui.deskplatform.RenameResUI
	var RenameRes=(function(_super){
		function RenameRes(){
			this._oldPath=null;
			RenameRes.__super.call(this);
		}

		__class(RenameRes,'view.RenameRes',_super);
		var __proto=RenameRes.prototype;
		__proto.initListener=function(){}
		__proto.start=function(oldPath){
			this._oldPath=oldPath;
			var oldName;
			oldName=FileManager.getFileName(oldPath);
			this.resLbl.text=oldName;
			this.nameTxt.restrict=StyleConsts.fileNameRestrict;
			this.nameTxt.text=oldName;
			this.updateCheck.selected=true;
			this.updateCheck.visible=false;
			this.popup();
			Laya.stage.focus=this.nameTxt.textField;
		}

		__proto.close=function(type){
			if (type=="sure"){
				if(StringTool.isOkFileName(this.nameTxt.text)){
					if(/*no*/this.FileTools.isPathSame(this.nameTxt.text,this.resLbl.text)){
						laya.editor.comonents.Alert.show(/*no*/this.Sys.lang("文件名不能相同！！"));
						return;
					}
					laya.ui.Dialog.prototype.close.call(this,type);
					}else{
					laya.editor.comonents.Alert.show(/*no*/this.Sys.lang("文件名不合法"));
				}
				}else{
				laya.ui.Dialog.prototype.close.call(this,type);
			}
		}

		__getset(1,RenameRes,'instance',function(){
			return RenameRes._instance ? RenameRes._instance :RenameRes._instance=new RenameRes();
		},ui.deskplatform.RenameResUI._$SET_instance);

		RenameRes._instance=null
		return RenameRes;
	})(RenameResUI)



	new DeskPlatform();

})(window,document,Laya);
