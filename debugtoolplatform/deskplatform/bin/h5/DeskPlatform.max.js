
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var Box=laya.ui.Box,Browser=laya.utils.Browser,Button=laya.ui.Button,CMDShell=nodetools.devices.CMDShell;
	var CheckBox=laya.ui.CheckBox,ClassTool=laya.debug.tools.ClassTool,Clip=laya.ui.Clip,Component=laya.ui.Component;
	var ContextMenu$1=electrontools.menus.ContextMenu,Device=nodetools.devices.Device,Dialog=laya.ui.Dialog,DisControlTool=laya.debug.tools.DisControlTool;
	var DisResizer=laya.debug.tools.resizer.DisResizer,DisTools=electrontools.DisTools,DragEvent=electrontools.drags.DragEvent;
	var DragManager=electrontools.drags.DragManager,Ease=laya.utils.Ease,Event=laya.events.Event,EventDispatcher=laya.events.EventDispatcher;
	var File=nodetools.devices.File,FileManager=nodetools.devices.FileManager,FileTools=nodetools.devices.FileTools;
	var FocusManager=extendui.FocusManager,Graphics=laya.display.Graphics,Handler=laya.utils.Handler,HitArea=laya.utils.HitArea;
	var IDTools=laya.debug.tools.IDTools,Image=laya.ui.Image,Input=laya.display.Input,JSTools=laya.debug.tools.JSTools;
	var JsonTool=laya.debug.tools.JsonTool,KeyManager=extendui.KeyManager,Keyboard=laya.events.Keyboard,Label=laya.ui.Label;
	var List=laya.ui.List,ListBase$1=extendui.ui.ListBase,ListEx=extendui.ui.ListEx,Loader=laya.net.Loader,MathUtil=laya.maths.MathUtil;
	var MessageManager=electrontools.MessageManager,Node=laya.display.Node,NodeTree$1=extendui.ui.NodeTree,NodeUtils=laya.debug.view.nodeInfo.NodeUtils;
	var OSInfo=nodetools.devices.OSInfo,ObjectTools=laya.debug.tools.ObjectTools,Paths$1=nodetools.devices.Paths;
	var Point=laya.maths.Point,PythonTools=nodetools.devices.PythonTools,Rectangle=laya.maths.Rectangle,RelativePos=extendui.layout.RelativePos;
	var Render=laya.renders.Render,RenderContext=laya.renders.RenderContext,Sprite=laya.display.Sprite,Stage=laya.display.Stage;
	var StringTool=laya.debug.tools.StringTool,Styles=laya.ui.Styles,Sys=nodetools.devices.Sys,SystemDragOverManager=electrontools.drags.SystemDragOverManager;
	var SystemSetting=nodetools.devices.SystemSetting,Tab=laya.ui.Tab,TabEx=extendui.ui.TabEx,TextField=extendui.ui.TextField;
	var TextInput=laya.ui.TextInput,TreeBase$1=extendui.ui.TreeBase,TreeEx=extendui.ui.TreeEx,Tween=laya.utils.Tween;
	var UIConfig=Laya.UIConfig,Utils=laya.utils.Utils,View=laya.ui.View;
	Laya.interface('platform.editzone.IEditViewer');
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
			View.regComponent("Tab",TabEx);
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
			Paths$1.tempPath=FileTools.getAppPath("tempdata")+"/";
			Paths$1.dataPath=FileTools.getAppPath("data")+"/";
			SystemDragOverManager.init();
			ContextMenu$1.init();
			SystemSetting.appPath=FileTools.appPath;
		}

		__proto.test=function(){
			console.log("AppPath:",FileTools.appPath);
			this.initApp();
			return;
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

		__proto.initApp=function(){
			EditRenderManager.init();
			NoticeRouter.init();
			CursorManager.init();
			SystemSetting.assetsPath=FileManager.getAppPath("files");;
			ResPanel.instance.init(SystemSetting.assetsPath);
			LayerManager.init();
			LayoutRecManager.init();
			LayoutRecManager.createDefault();
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
	*路径定义
	*@author ww
	*/
	//class platform.interfaces.Paths
	var Paths=(function(){
		function Paths(){}
		__class(Paths,'platform.interfaces.Paths');
		Paths.LogFile="log.txt";
		Paths.LayoutFile_Default="layout/layout.config";
		Paths.LayoutFile_Static="laya/tpls/default.config";
		return Paths;
	})()


	/**
	*...
	*@author ww
	*/
	//class platform.interfaces.PlatformEvents
	var PlatformEvents=(function(){
		function PlatformEvents(){}
		__class(PlatformEvents,'platform.interfaces.PlatformEvents');
		PlatformEvents.PAGE_CHANGED="pageChanged";
		PlatformEvents.CLOSE_PAGE="closePage";
		PlatformEvents.OPEN_PAGE="openPAGE";
		PlatformEvents.FOCUS_DESIGN="Focus_design";
		PlatformEvents.DESIGN_DATACHANGED="DESIGN_DATACHANGED";
		PlatformEvents.FRESH_CURVIEW="FRESH_CurView";
		PlatformEvents.SHOW_LAYOUTTAB_BY_NAME="SHOW_LayoutTab_By_Name";
		PlatformEvents.WebViewReady="WebViewReady";
		PlatformEvents.OPEN_ADDDIR="open_adddir";
		PlatformEvents.ADD_DIR="adddir";
		PlatformEvents.OPEN_ADD_COMMON_RES_DIALOG="OPEN_ADD_COMMON_RES_DIALOG";
		PlatformEvents.ADD_COMMON_RES="ADD_COMMON_RES";
		return PlatformEvents;
	})()


	/**
	*...
	*@author ww
	*/
	//class platform.interfaces.PlatformVars
	var PlatformVars=(function(){
		function PlatformVars(){}
		__class(PlatformVars,'platform.interfaces.PlatformVars');
		PlatformVars.isDragingLayout=false;
		PlatformVars.disableTabDrag=true;
		return PlatformVars;
	})()


	/**
	*皮肤定义
	*@author ww
	*/
	//class platform.interfaces.SkinDefines
	var SkinDefines=(function(){
		function SkinDefines(){}
		__class(SkinDefines,'platform.interfaces.SkinDefines');
		SkinDefines.DisDragIcon="comp/clip_folder.png";
		SkinDefines.PageDragIcon="comp/clip_folder.png";
		SkinDefines.ResDragIcon="comp/clip_folder.png";
		SkinDefines.LayoutRecDragIcon="comp/clip_folder.png";
		SkinDefines.LayoutTabDragIcon="comp/clip_folder.png";
		return SkinDefines;
	})()


	/**
	*布局管理类
	*@author ww
	*/
	//class platform.layout.LayoutRecManager
	var LayoutRecManager=(function(){
		function LayoutRecManager(){}
		__class(LayoutRecManager,'platform.layout.LayoutRecManager');
		var __proto=LayoutRecManager.prototype;
		__proto.saveDragBarInfo=function(dragBar){}
		__getset(1,LayoutRecManager,'containerBox',function(){
			return LayoutRecManager._ct;
		});

		__getset(1,LayoutRecManager,'tLayoutFile',function(){
			return LayoutRecManager._layoutFile?LayoutRecManager._layoutFile:"layout/layout.config";
		});

		LayoutRecManager.popLocked=function(){
			return false;
		}

		LayoutRecManager.onMouseDown=function(e){
			LayoutRecManager.target=e.currentTarget;
			LayoutRecManager.dragItem(LayoutRecManager.target,LayoutRecManager.target["type"]);
			LayerManager.stage.on("mouseup",null,LayoutRecManager.onMouseUp);
			LayerManager.stage.on("mousemove",null,LayoutRecManager.onMouseMove);
		}

		LayoutRecManager.dragItem=function(target,type){
			(type===void 0)&& (type=0);
			var option={};
			var area=new Rectangle();
			if (type==0){
				area=(target).getDragArea();
			}
			else if (type==1){
				area=(target).getDragArea();
			}
			else{
				return;
			}
			option.area=area;
			DisControlTool.setTop(target);
			target.startDrag(area,false,0,300,{useDlen:true});
		}

		LayoutRecManager.onMouseUp=function(e){
			LayerManager.stage.off("mouseup",null,LayoutRecManager.onMouseUp);
			LayerManager.stage.off("mousemove",null,LayoutRecManager.onMouseMove);
			LayoutRecManager.doLayOut();
			LayoutRecManager.target.stopDrag();
			LayoutRecManager.target.left=Math.ceil(LayoutRecManager.target.x);
			LayoutRecManager.target.top=Math.ceil(LayoutRecManager.target.y);
		}

		LayoutRecManager.onMouseMove=function(e){
			Laya.timer.callLater(this,LayoutRecManager.updateTargetPosAndDoLayout);
		}

		LayoutRecManager.updateTargetPosAndDoLayout=function(){
			LayoutRecManager.target.left=Math.ceil(LayoutRecManager.target.x);
			LayoutRecManager.target.top=Math.ceil(LayoutRecManager.target.y);
			LayoutRecManager.doLayOut();
		}

		LayoutRecManager.doLayOut=function(){
			(LayoutRecManager.target).updates();
		}

		LayoutRecManager.init=function(){
			LayoutRecManager._ct=new Box();
			LayoutRecManager._ct.mouseEnabled=true;
			LayoutRecManager._ct.name="LayoutRecManager_Container";
			LayoutRecManager._ct.width=800;
			LayoutRecManager._ct.height=800;
			LayerManager.stage.addChild(LayoutRecManager._ct);
			LayerManager.stage.on("resize",null,LayoutRecManager.resizeWork);
			LayoutRecManager._ct.on("dragDrop",null,LayoutRecManager.onDragDrop);
		}

		LayoutRecManager.resizeWork=function(e){
			LayoutRecManager._ct.x=LayoutRecManager.ctOffSetX;
			LayoutRecManager._ct.y=LayoutRecManager.ctOffSetY;
			Laya.timer.once(50,null,LayoutRecManager.tryResizeSafe,null,true);
			return;
		}

		LayoutRecManager.tryResizeSafe=function(){
			try{
				LayoutRecManager.tryResizeNoScale();
				}catch(e){
				LayoutRecManager.createDefault();
			}
		}

		LayoutRecManager.scaleResize=function(){
			var nW=LayerManager.stage.width-LayoutRecManager.ctOffSetX;
			var nH=LayerManager.stage.height-30+LayoutRecManager.ctOffHeight;
			if ((nW *nH *LayoutRecManager._ct.width *LayoutRecManager._ct.height)!=0){
				var scaleX=nW / LayoutRecManager._ct.width;
				var scaleY=nH / LayoutRecManager._ct.height;
				LayoutRecManager.adptScales(scaleX,scaleY);
			}
			LayoutRecManager._ct.width=LayerManager.stage.width-LayoutRecManager.ctOffSetX;
			LayoutRecManager._ct.height=LayerManager.stage.height-LayoutRecManager._ct.y+LayoutRecManager.ctOffHeight;
			Laya.timer.once(100,null,LayoutRecManager.adptAll);
		}

		LayoutRecManager.tryResizeNoScale=function(){
			var items;
			items=DisControlTool.getAllChild(LayoutRecManager._ct);
			var i=0,len=0;
			len=items.length;
			var tRec;
			var tRecHeight=0;
			var maxFree;
			for (i=0;i < len;i++){
				tRec=items[i];
				if ((tRec instanceof platform.layout.LayoutRec )){
					if(tRec.sizeFree){
						if(!maxFree||maxFree.height<tRec.height){
							maxFree=tRec;
						}
					}
				}
			}
			tRec=maxFree;
			if(!tRec||!tRec.sizeFree){
				LayoutRecManager.scaleResize();
				return;
				}else{
			};
			var nW=LayerManager.stage.width-LayoutRecManager.ctOffSetX+3;
			var nH=LayerManager.stage.height-LayoutRecManager._ct.y+LayoutRecManager.ctOffHeight;
			var pW=LayoutRecManager._ct.width;
			var pH=LayoutRecManager._ct.height;
			var dW=NaN;
			var dH=NaN;
			dW=nW-pW;
			dH=nH-pH;
			if ((nW *nH *pW *pH)!=0){
				if(dW+tRec.width<0){
					console.log("width not availeble");
					LayoutRecManager.scaleResize();
					return;
				}
				if(dH+tRec.height<0){
					console.log("height not availeble");
					LayoutRecManager.scaleResize();
					return;
				}
				}else{
				console.log("wrong size");
				LayoutRecManager.scaleResize();
				return;
			};
			var tDragBar;
			var barList;
			barList=[];
			var resizeStruct;
			resizeStruct=new ResizeRecStruct();
			var workDragBar;
			for (i=0;i < len;i++){
				tDragBar=items[i];
				if ((tDragBar instanceof platform.layout.LayoutDragBar )){
					tDragBar.walked=false;
					if(tDragBar.cusorType=="e-resize"){
						if(tDragBar.x>=tRec.x+10){
							barList.push(tDragBar);
						}
					}
					if(tDragBar.type==2){
						workDragBar=tDragBar;
						switch(tDragBar.getSideType()){
							case "right":
								resizeStruct.rightSide=tDragBar;
								break ;
							case "left":
								resizeStruct.leftSide=tDragBar;
								break ;
							case "up":
								resizeStruct.upSide=tDragBar;
								break ;
							case "down":
								resizeStruct.downSide=tDragBar;
								break ;
							}
					}
				}
			}
			resizeStruct.isRoot=true;
			resizeStruct.resizeItems=[];
			resizeStruct.tryMoveRight(dW);
			barList=[];
			for (i=0;i < len;i++){
				tDragBar=items[i];
				if ((tDragBar instanceof platform.layout.LayoutDragBar )){
					tDragBar.walked=false;
					if(tDragBar.cusorType=="n-resize"){
						if(tDragBar.y>=tRec.y+tRec.height||tDragBar.y+200>nH){
							barList.push(tDragBar);
							tDragBar.top+=dH;
						}
						if(tDragBar.type==2&&tDragBar.getSideType()=="down"&&tDragBar.cusorType=="n-resize"){
							workDragBar=tDragBar;
						}
					}
				}
			}
			if(workDragBar){
			}
			LayoutRecManager._ct.width=nW;
			LayoutRecManager._ct.height=nH;
			Laya.timer.once(100,null,LayoutRecManager.adptAll);
		}

		LayoutRecManager.adptDis=function(dis,scaleX,scaleY){
			dis.left *=scaleX;
			dis.right *=scaleX;
			dis.top *=scaleY;
			dis.bottom *=scaleY;
		}

		LayoutRecManager.adptScales=function(scaleX,scaleY){
			var items;
			items=DisControlTool.getAllChild(LayoutRecManager._ct);
			var i=0,len=0;
			len=items.length;
			var tDragBar;
			for (i=0;i < len;i++){
				tDragBar=items[i];
				if ((tDragBar instanceof platform.layout.LayoutDragBar )){
					LayoutRecManager.adptDis(tDragBar,scaleX,scaleY);
				}
			}
		}

		LayoutRecManager.getAllDragBars=function(type){
			var rst;
			rst=[];
			var items;
			items=DisControlTool.getAllChild(LayoutRecManager._ct);
			var i=0,len=0;
			len=items.length;
			var tDragBar;
			for (i=0;i < len;i++){
				tDragBar=items[i];
				if ((tDragBar instanceof platform.layout.LayoutDragBar )){
					if(tDragBar.type==type)
						rst.push(tDragBar);
				}
			}
			return rst;
		}

		LayoutRecManager.adptAll=function(){
			var items;
			items=DisControlTool.getAllChild(LayoutRecManager._ct);
			var i=0,len=0;
			len=items.length;
			var tDragBar;
			for (i=0;i < len;i++){
				tDragBar=items[i];
				if ((tDragBar instanceof platform.layout.LayoutDragBar )){
					tDragBar.updates();
				}
			}
		}

		LayoutRecManager.saveLayoutInfo=function(){
			var items;
			items=DisControlTool.getAllChild(LayoutRecManager._ct);
			var i=0,len=0;
			len=items.length;
			for (i=0;i < len;i++){
				IDTools.idObj(items[i]);
			};
			var rst=[];
			var tDis;
			for (i=0;i < len;i++){
				tDis=items[i];
				if ((tDis instanceof platform.layout.LayoutDragBar )){
					rst.push(LayoutRecManager.getInfoO(tDis));
				}
				else if ((tDis instanceof platform.layout.LayoutRec )){
					rst.push(LayoutRecManager.saveRecInfo(tDis));
				}
			};
			var saveO;
			saveO={};
			saveO.width=LayoutRecManager._ct.width;
			saveO.height=LayoutRecManager._ct.height;
			saveO.items=rst;
			FileManager.createTxtFile(FileManager.getDataPath(LayoutRecManager.tLayoutFile),ObjectTools.getJsonString(saveO));
		}

		LayoutRecManager.showPanelByClassName=function(className){
			if(LayoutRecManager.popLocked())return;
			LayoutRecManager.initClassToUIO();
			var tPanel;
			tPanel=LayoutRecManager.classToUIO[className];
			LayoutRecManager.showPanelToStage(tPanel);
		}

		LayoutRecManager.showPanelToStage=function(tPanel){
			if (!tPanel)
				return;
			if (LayoutRecManager.isPanelInStage(tPanel))
				return;
			var rec=new LayoutRec();
			if (tPanel.width > 0 && tPanel.height > 0 && 0){
				rec.width=tPanel.width+5;
				rec.height=tPanel.height+20;
			}
			else{
				rec.width=tPanel["minWidth"]? tPanel["minWidth"]:200;
				if(rec.width<200)rec.width=200;
				rec.height=300;
			}
			LayoutRecManager.addPanelToRec(tPanel,rec);
			DisTools.showToCenter(rec,LayerManager.stage);
		}

		LayoutRecManager.removePanel=function(tPanel){
			var rec;
			rec=LayoutRecManager.findPanelRec(tPanel);
			if(rec){
				rec.removeUI(tPanel,true);
			}
		}

		LayoutRecManager.isPanelInStage=function(panel){
			var i=0,len=0;
			var childs;
			var layouts;
			layouts=[];
			childs=DisControlTool.getAllChild(LayoutRecManager._ct);
			len=childs.length;
			for (i=0;i < len;i++){
				if (((childs[i])instanceof platform.layout.LayoutRec )){
					ObjectTools.concatArr(layouts,childs[i].getUIs());
				}
			}
			childs=DisControlTool.getAllChild(LayerManager.stage);
			len=childs.length;
			for (i=0;i < len;i++){
				if (((childs[i])instanceof platform.layout.LayoutRec )){
					ObjectTools.concatArr(layouts,childs[i].getUIs());
				}
			}
			len=layouts.length;
			for (i=0;i < len;i++){
				if (layouts[i]==panel)
					return true;
			}
			return false;
		}

		LayoutRecManager.findPanelRec=function(panel){
			var i=0,len=0;
			var childs;
			var layouts;
			layouts=[];
			childs=DisControlTool.getAllChild(LayoutRecManager._ct);
			len=childs.length;
			for (i=0;i < len;i++){
				if (((childs[i])instanceof platform.layout.LayoutRec )){
					if(LayoutRecManager.isPanelInRec(panel,childs[i])){
						return childs[i];
					}
				}
			}
			childs=DisControlTool.getAllChild(LayerManager.stage);
			len=childs.length;
			for (i=0;i < len;i++){
				if (((childs[i])instanceof platform.layout.LayoutRec )){
					if(LayoutRecManager.isPanelInRec(panel,childs[i])){
						return childs[i];
					}
				}
			}
			return null;
		}

		LayoutRecManager.isPanelInRec=function(panel,rec){
			var layouts;
			layouts=rec.getUIs();
			if(!layouts)return false;
			return layouts.indexOf(panel)>=0;
		}

		LayoutRecManager.initClassToUIO=function(){
			if (!LayoutRecManager._classInited){
				LayoutRecManager._classInited=true;
				LayoutRecManager.classToUIO["ResPanel"]=ResPanel.instance;
			}
		}

		LayoutRecManager.regLayoutPanel=function(name,panel){
			LayoutRecManager.classToUIO[name]=panel;
		}

		LayoutRecManager.recoverLayoutInfo=function(layoutFile,force,isDebug){
			(layoutFile===void 0)&& (layoutFile="layout/layout.config");
			(force===void 0)&& (force=false);
			(isDebug===void 0)&& (isDebug=false);
			if((!force)&&(LayoutRecManager._layoutFile==layoutFile))return;
			if(LayoutRecManager._layoutFile){
				LayoutRecManager.saveLayoutInfo();
			}
			LayoutRecManager.clearAll();
			LayoutRecManager.initClassToUIO();
			LayoutRecManager._layoutFile=layoutFile;
			var path;
			path=FileManager.getDataPath(LayoutRecManager.tLayoutFile);
			if (!FileTools.exist(path)){
				LayoutRecManager.createDefault();
				return;
			}
			LayoutRecManager.layoutByLayoutFile(path);
		}

		LayoutRecManager.layoutByLayoutFile=function(path){
			var layoutO;
			layoutO=ObjectTools.getObj(FileManager.readTxtFile(path));
			LayoutRecManager._ct.width=layoutO.width;
			LayoutRecManager._ct.height=layoutO.height;
			var itemList;
			itemList=layoutO.items;
			var i=0,len=0;
			len=itemList.length;
			var tO;
			var tDis;
			var tClass;
			var objDic={};
			for (i=0;i < len;i++){
				tO=itemList[i];
				tClass=LayoutRecManager.itemClassO[tO.className];
				if (!tClass)
					continue ;
				if (tClass==LayoutDragBar){
					var type=tO.width < tO.height ? "R" :"T";
					tDis=LayoutRecManager.getADragBar(type);
				}
				else{
					tDis=new tClass();
				}
				ObjectTools.copyValueByArr(tDis,tO,LayoutRecManager.sizeInfos);
				objDic[tO.id]=tDis;
				if ((tDis instanceof platform.layout.LayoutDragBar )){
				}
				if ((tDis instanceof platform.layout.LayoutRec )){
					LayoutRecManager.recoverLayoutRec(tDis,tO);
				}
				LayoutRecManager._ct.addChild(tDis);
			};
			var key;
			var tar;
			var relativeO;
			for (i=0;i < len;i++){
				tO=itemList[i];
				tDis=objDic[tO.id];
				relativeO=tO.relativeO;
				if (relativeO){
					for (key in relativeO){
						tar=objDic[relativeO[key]];
						if (tar){
							RelativePos.addRelative(tDis,tar,key);
						}
						else{
							console.log("tar not find");
						}
					}
				}
				else{
					console.log("relativeO not find");
				}
				ObjectTools.copyValueByArr(tDis,tO,LayoutRecManager.sizeInfos);
			}
			LayoutRecManager.adptAll();
			LayoutRecManager.resizeWork();
		}

		LayoutRecManager.recoverLayoutRec=function(rec,data){
			var i=0,len=0;
			var uiList;
			uiList=data.uiList;
			len=uiList.length;
			var tUI;
			for (i=0;i < len;i++){
				tUI=LayoutRecManager.classToUIO[uiList[i]];
				if (tUI){
					LayoutRecManager.addPanelToRec(tUI,rec);
				}
			}
			if(parseInt(data.select)>0){
				rec.tab.selectedIndex=data.select;
				}else{
				rec.tab.selectedIndex=0;
			}
			if(data.disMode){
				rec.disMode=data.disMode;
			}
			if(data.preMoveLen){
				rec.preMoveLen=data.preMoveLen;
			}
			if(rec.tab.items.length<1){
				Laya.timer.once(1000,null,LayoutRecManager.removeRec,[rec]);
			}
		}

		LayoutRecManager.saveRecInfo=function(rec){
			var rst;
			rst=LayoutRecManager.getInfoO(rec);
			var uiList;
			var i=0,len=0;
			uiList=rec.tab.items;
			var saveList;
			len=uiList.length;
			var tab;
			saveList=[];
			for (i=0;i < len;i++){
				tab=uiList[i];
				saveList.push(ClassTool.getClassName(tab.ui));
			}
			rst.disMode=rec.disMode;
			rst.preMoveLen=rec.preMoveLen;
			rst.select=rec.tab.selectedIndex;
			rst.uiList=saveList;
			return rst;
		}

		LayoutRecManager.getInfoO=function(obj){
			var rst;
			rst={};
			ObjectTools.copyValueByArr(rst,obj,LayoutRecManager.sizeInfos);
			rst.className=ClassTool.getClassName(obj);
			rst.id=IDTools.getObjID(obj);
			rst.relativeO=RelativePos.saveRelative(obj);
			return rst;
		}

		LayoutRecManager.onDragDrop=function(e){
			if (!e.data)
				return;
			var tType;
			tType=e.data.type;
			if (tType !="LayoutRec" && tType !="LayoutTab")
				return;
			var src;
			src=e.data.target;
			if (!src)
				return;
			var hitList;
			hitList=e.hitList;
			var i=0,len=0;
			len=hitList.length;
			var tTarget;
			if (hitList.indexOf(src)>=0){
				tTarget=src;
				if (tType !="LayoutTab"){
					if (tType=="LayoutRec"){
						LayoutRecManager.popRec(src);
						return;
					}
				}
			}
			else{
				for (i=0;i < len;i++){
					tTarget=hitList[i];
					if ((tTarget instanceof platform.layout.LayoutRec )){
						if(RelativePos.getDisMouseRelativePos(tTarget)!="out"){
							break ;
						}
					}
				}
			}
			if (!((tTarget instanceof platform.layout.LayoutRec )))
				return;
			if(tTarget.parent!=LayoutRecManager._ct)return;
			if (src !=tTarget || tType=="LayoutTab"){
				var posType;
				posType=RelativePos.getDisMouseRelativePos(tTarget);
				if (tType=="LayoutRec"){
					switch (posType){
						case "up":
							LayoutRecManager.removeRec(src);
							LayoutRecManager.insetToBarV(RelativePos.getBar(tTarget,"up"),src);
							break ;
						case "down":
							LayoutRecManager.removeRec(src);
							LayoutRecManager.insertV(tTarget,src);
							break ;
						case "left":
							LayoutRecManager.removeRec(src);
							LayoutRecManager.insertL(tTarget,src);
							break ;
						case "center":
							if(src.parent==LayerManager.stage)return;
						case "right":
							LayoutRecManager.removeRec(src);
							LayoutRecManager.insert(tTarget,src);
							break ;
						default :
							return;
						}
				}
				else if (tType=="LayoutTab"){
					var tTab;
					tTab=e.dragInitiator;
					var tRec;
					tRec=tTarget;
					if (src==tTarget){
						if (src.tab.items.length <=1){
							LayoutRecManager.popRec(src);
							return;
						}
						else{
							if (posType=="center"){
								src.removeTab(tTab);
								tRec=new LayoutRec();
								tRec.pos(src.x,src.y);
								src.parent.addChild(tRec);
								tRec.addTab(tTab);
								LayoutRecManager.popRec(tRec);
								return;
							}
						}
					}
					switch (posType){
						case "down":
							src.removeTab(tTab);
							tRec=new LayoutRec();
							tRec.addTab(tTab);
							LayoutRecManager.insertV(tTarget,tRec);
							break ;
						case "right":
							src.removeTab(tTab);
							tRec=new LayoutRec();
							tRec.addTab(tTab);
							LayoutRecManager.insert(tTarget,tRec);
							break ;
						case "left":
							src.removeTab(tTab);
							tRec=new LayoutRec();
							tRec.addTab(tTab);
							LayoutRecManager.insertL(tTarget,tRec);
							break ;
						case "center":
						case "up":
							if(!tRec.canAddTab)return;
							if (src !=tRec){
								src.removeTab(tTab);
								tRec.addTab(tTab);
							}
							else{
								return;
								src.removeTab(tTab);
								tRec=new LayoutRec();
								tRec.addTab(tTab);
								LayoutRecManager.popRec(tRec);
							}
							break ;
						default :
							return;
						}
					if (src.tab.items.length < 1){
						LayoutRecManager.removeRec(src);
					}
				}
			}
		}

		LayoutRecManager.test=function(){
			var _leftBar;
			var _rightBar;
			var _upBar;
			var _downBar;
			_leftBar=LayoutRecManager.getADragBar("R");
			_leftBar.width=0;
			_leftBar.left=0;
			_leftBar.top=0;
			_leftBar.bottom=0;
			_leftBar.type=2;
			LayoutRecManager._ct.addChild(_leftBar);
			_rightBar=LayoutRecManager.getADragBar("R");
			_rightBar.width=0;
			_rightBar.right=0;
			_rightBar.top=0;
			_rightBar.bottom=0;
			_rightBar.type=2;
			LayoutRecManager._ct.addChild(_rightBar);
			_upBar=LayoutRecManager.getADragBar("T");
			_upBar.height=0;
			_upBar.left=0;
			_upBar.top=0;
			_upBar.right=0;
			_upBar.type=2;
			LayoutRecManager._ct.addChild(_upBar);
			_downBar=LayoutRecManager.getADragBar("T");
			_downBar.height=0;
			_downBar.left=0;
			_downBar.bottom=0;
			_downBar.right=0;
			_downBar.type=2;
			LayoutRecManager._ct.addChild(_downBar);
			var rec=LayoutRecManager.getARec();
			LayoutRecManager._ct.addChild(rec);
			rec.left=0;
			rec.right=0;
			rec.top=0;
			rec.bottom=0;
			RelativePos.addRelative(rec,_leftBar,"left");
			RelativePos.addRelative(rec,_rightBar,"right");
			RelativePos.addRelative(rec,_upBar,"up");
			RelativePos.addRelative(rec,_downBar,"down");
			LayoutRecManager.insert(rec,LayoutRecManager.getARec());
			var tRec;
			tRec=LayoutRecManager.getARec();
			LayoutRecManager.insertV(rec,tRec);
			LayoutRecManager.insert(tRec,LayoutRecManager.getARec());
			console.log("onlySide:",RelativePos.getOnlySide(tRec));
			LayoutRecManager.insertV(tRec,LayoutRecManager.getARec());
			console.log("onlySide:",RelativePos.getOnlySide(tRec));
		}

		LayoutRecManager.clearAll=function(){
			LayoutRecManager.clearLayoutsOfContainer(LayoutRecManager._ct);
			LayoutRecManager.clearLayoutsOfContainer(LayerManager.stage);
		}

		LayoutRecManager.clearLayoutsOfContainer=function(_ct){
			var items;
			items=DisControlTool.getAllChild(_ct);
			var i=0,len=0;
			len=items.length;
			var tDis;
			for (i=0;i < len;i++){
				tDis=items[i];
				if ((tDis instanceof platform.layout.LayoutDragBar )){
					(tDis).clears();
					tDis.removeSelf();
				}
				else if ((tDis instanceof platform.layout.LayoutRec )){
					(tDis).clears();
					tDis.removeSelf();
				}
			}
		}

		LayoutRecManager.createDefault=function(){
			LayoutRecManager.clearAll();
			LayoutRecManager.resizeWork();
			var path;
			path=FileManager.getAppPath("laya/tpls/default.config");
			if(FileTools.exist(path)){
				LayoutRecManager.layoutByLayoutFile(path);
				return;
			};
			var _leftBar;
			var _rightBar;
			var _upBar;
			var _downBar;
			_leftBar=LayoutRecManager.getADragBar("R");
			_leftBar.width=0;
			_leftBar.left=0;
			_leftBar.top=0;
			_leftBar.bottom=0;
			_leftBar.type=2;
			LayoutRecManager._ct.addChild(_leftBar);
			_rightBar=LayoutRecManager.getADragBar("R");
			_rightBar.width=0;
			_rightBar.right=0;
			_rightBar.top=0;
			_rightBar.bottom=0;
			_rightBar.type=2;
			LayoutRecManager._ct.addChild(_rightBar);
			_upBar=LayoutRecManager.getADragBar("T");
			_upBar.height=0;
			_upBar.left=0;
			_upBar.top=0;
			_upBar.right=0;
			_upBar.type=2;
			LayoutRecManager._ct.addChild(_upBar);
			_downBar=LayoutRecManager.getADragBar("T");
			_downBar.height=0;
			_downBar.left=0;
			_downBar.bottom=0;
			_downBar.right=0;
			_downBar.type=2;
			LayoutRecManager._ct.addChild(_downBar);
			RelativePos.addRelative(_upBar,_leftBar,"left");
			RelativePos.addRelative(_upBar,_rightBar,"right");
			RelativePos.addRelative(_downBar,_leftBar,"left");
			RelativePos.addRelative(_downBar,_rightBar,"right");
			RelativePos.addRelative(_leftBar,_upBar,"up");
			RelativePos.addRelative(_leftBar,_downBar,"down");
			RelativePos.addRelative(_rightBar,_upBar,"up");
			RelativePos.addRelative(_rightBar,_downBar,"down");
			var rec=new LayoutRec();
			LayoutRecManager._ct.addChild(rec);
			rec.left=0;
			rec.right=0;
			rec.top=0;
			rec.bottom=0;
			RelativePos.addRelative(rec,_leftBar,"left");
			RelativePos.addRelative(rec,_rightBar,"right");
			RelativePos.addRelative(rec,_upBar,"up");
			RelativePos.addRelative(rec,_downBar,"down");
			debugger;
			LayoutRecManager.addPanelToRec(ResPanel.instance,rec);
			var uiRec;
			uiRec=new LayoutRec();
			LayoutRecManager.insert(rec,uiRec,0.8);
			LayoutRecManager.addPanelToRec(EditZone.instance,uiRec);
			return;
			var resRec;
			resRec=new LayoutRec();
			LayoutRecManager.insertV(rec,resRec);
			LayoutRecManager.addPanelToRec(/*no*/this.CompPanel.instance,resRec);
			LayoutRecManager.addPanelToRec(ResPanel.instance,resRec);
			var propRec;
			propRec=new LayoutRec();
			LayoutRecManager.insert(uiRec,propRec,0.3);
			LayoutRecManager.addPanelToRec(/*no*/this.PropPanel.instance,propRec);
			var disTreeRec;
			disTreeRec=new LayoutRec();
			LayoutRecManager.insertV(propRec,disTreeRec);
			LayoutRecManager.addPanelToRec(/*no*/this.DisplayTreePanel.instance,disTreeRec);
		}

		LayoutRecManager.popRec=function(tar){
			if (tar.parent==LayerManager.stage)
				return;
			var point;
			point=new Point();
			point=tar.localToGlobal(point);
			point=LayerManager.stage.globalToLocal(point);
			var posInfo={};
			ObjectTools.copyValueByArr(posInfo,tar,LayoutRecManager.sizePosKeys);
			posInfo.x=point.x+DragManager.dPos.x;
			posInfo.y=point.y+DragManager.dPos.y;
			LayoutRecManager.removeRec(tar);
			DisControlTool.clearItemRelativeInfo(tar);
			LayoutRecManager.addToStageLater(tar,posInfo);
		}

		LayoutRecManager.addToStageLater=function(tar,posInfo){
			LayerManager.stage.addChild(tar);
			if(posInfo.height<200)posInfo.height=200;
			tar.x=posInfo.x-10;
			tar.y=posInfo.y-10;
			tar.width=posInfo.width+20;
			tar.height=posInfo.height+20;
		}

		LayoutRecManager.clearRelativePosition=function(tar){
			tar.top=NaN;
			tar.bottom=NaN;
			tar.left=NaN;
			tar.right=NaN;
		}

		LayoutRecManager.removeRec=function(tar){
			var onlySide;
			onlySide=RelativePos.getOnlySide(tar);
			if (!onlySide){
				console.log("无可拖动条");
				tar.removeSelf();
				RelativePos.clearBar(tar);
				return;
			};
			var onlyBar;
			onlyBar=RelativePos.getBar(tar,onlySide);
			var otherSide;
			otherSide=RelativePos.getOtherSide(onlySide);
			var otherBar;
			otherBar=RelativePos.getBar(tar,otherSide);
			if (onlyBar && otherBar){
				otherBar.mergeUpdates(onlyBar);
				onlyBar.removeSelf();
				onlyBar.clears();
				RelativePos.clearBar(onlyBar);
				tar.removeSelf();
				RelativePos.clearBar(tar);
			}
			LayoutRecManager.adptAll();
		}

		LayoutRecManager.minToBottom=function(tar){
			if(LayoutRecManager.isTweening)return;
			var topBar;
			var bottomBar;
			topBar=RelativePos.getBar(tar,"up");
			bottomBar=RelativePos.getBar(tar,"down");
			if(tar.disMode==1){
				tar.disMode=2;
				LayoutRecManager.recTween(topBar,{"_dragY":bottomBar.y-tar.preMoveLen});
				}else{
				tar.disMode=1;
				tar.preMoveLen=bottomBar.y-topBar.y;
				LayoutRecManager.recTween(topBar,{"_dragY":bottomBar.y-22});
			}
		}

		LayoutRecManager.minToRight=function(tar){
			if(LayoutRecManager.isTweening)return;
			var rightBar;
			var leftBar;
			rightBar=RelativePos.getBar(tar,"right");
			leftBar=RelativePos.getBar(tar,"left");
			if(tar.disMode==1){
				tar.disMode=2;
				LayoutRecManager.recTween(leftBar,{"_dragX":rightBar.x-tar.preMoveLen});
				}else{
				tar.disMode=1;
				tar.preMoveLen=rightBar.x-leftBar.x;
				LayoutRecManager.recTween(leftBar,{"_dragX":rightBar.x-22});
			}
		}

		LayoutRecManager.minToLeft=function(tar){
			if(LayoutRecManager.isTweening)return;
			var rightBar;
			var leftBar;
			rightBar=RelativePos.getBar(tar,"right");
			leftBar=RelativePos.getBar(tar,"left");
			if(tar.disMode==1){
				tar.disMode=2;
				LayoutRecManager.recTween(rightBar,{"_dragX":leftBar.x+tar.preMoveLen});
				}else{
				tar.disMode=1;
				tar.preMoveLen=rightBar.x-leftBar.x;
				LayoutRecManager.recTween(rightBar,{"_dragX":leftBar.x+22});
			}
		}

		LayoutRecManager.recTween=function(tar,props){
			if(!LayoutRecManager.tweenCompleteHandler)LayoutRecManager.tweenCompleteHandler=new Handler(null,LayoutRecManager.onTweenComplete);
			LayoutRecManager.isTweening=true;
			Tween.to(tar,props,150,Ease.circInOut,LayoutRecManager.tweenCompleteHandler);
		}

		LayoutRecManager.onTweenComplete=function(){
			LayoutRecManager.isTweening=false;
		}

		LayoutRecManager.minRec=function(tar){
			var onlySide;
			onlySide=RelativePos.getOnlySide(tar);
			if (!onlySide)
				return;
			var onlyBar;
			onlyBar=RelativePos.getBar(tar,onlySide);
			var otherSide;
			otherSide=RelativePos.getOtherSide(onlySide);
			var otherBar;
			otherBar=RelativePos.getBar(tar,otherSide);
			if (onlyBar && otherBar){
				switch (onlySide){
					case "right":
						onlyBar.left-=tar.width-4;
						break ;
					case "left":
						onlyBar.left+=tar.width-4;
						break ;
					case "up":
						onlyBar.top+=tar.height-4;
						break ;
					case "down":
						onlyBar.top-=tar.height-4;
						break ;
					}
			}
			onlyBar.updates();
		}

		LayoutRecManager.recoverRec=function(tar){
			var onlySide;
			onlySide=RelativePos.getOnlySide(tar);
			if (!onlySide)
				return;
			var onlyBar;
			onlyBar=RelativePos.getBar(tar,onlySide);
			var otherSide;
			otherSide=RelativePos.getOtherSide(onlySide);
			var otherBar;
			otherBar=RelativePos.getBar(tar,otherSide);
			if (onlyBar && otherBar){
				switch (onlySide){
					case "right":
						onlyBar.left-=tar.width-tar.preWidth;
						break ;
					case "left":
						onlyBar.left+=tar.width-tar.preWidth;
						break ;
					case "up":
						onlyBar.top+=tar.height-tar.preHeight;
						break ;
					case "down":
						onlyBar.top-=tar.height-tar.preHeight;
						break ;
					}
			}
			onlyBar.updates();
		}

		LayoutRecManager.adptTo=function(tar){
			var onlySide;
			onlySide=RelativePos.getOnlySide(tar);
			if (!onlySide)
				return;
			var onlyBar;
			onlyBar=RelativePos.getBar(tar,onlySide);
			var otherSide;
			otherSide=RelativePos.getOtherSide(onlySide);
			var otherBar;
			otherBar=RelativePos.getBar(tar,otherSide);
			if (onlyBar && otherBar){
				switch (onlySide){
					case "right":
						onlyBar.left=tar.left+tar.width;
						break ;
					case "left":
						onlyBar.left=tar.left-onlyBar.width;
						break ;
					case "up":
						onlyBar.top=tar.top-onlyBar.height;
						break ;
					case "down":
						onlyBar.top=tar.top+tar.height;
						break ;
					}
			}
			onlyBar.updates();
		}

		LayoutRecManager.insetToBar=function(tar,insert,rate){
			(rate===void 0)&& (rate=0.4);
			var rec;
			rec=tar.getDragArea();
			rec.width=200;
			if (rec.width < 20)
				return;
			var tLen=0;
			tLen=rec.width;
			var dragBar;
			dragBar=LayoutRecManager.getADragBar("R");
			dragBar.size(0,tar.height);
			dragBar.right=tar.right;
			dragBar.left=tar.left
			dragBar.top=tar.top;
			dragBar.bottom=tar.bottom;
			dragBar.type=0;
			dragBar.mergeUpdates(tar);
			tar.clear();
			dragBar.left+=rate *tLen;
			RelativePos.clearBar(insert);
			insert.left=tar.left
			insert.top=tar.top;
			insert.bottom=tar.bottom;
			if (RelativePos.getBar(tar,"right")){
				RelativePos.copyRelative(dragBar,tar,"right");
			}
			RelativePos.addRelative(insert,tar,"left");
			RelativePos.addRelative(insert,dragBar,"right");
			RelativePos.copyRelative(insert,tar,"down");
			RelativePos.copyRelative(dragBar,tar,"down");
			RelativePos.copyRelative(insert,tar,"up");
			RelativePos.copyRelative(dragBar,tar,"up");
			LayoutRecManager._ct.addChild(dragBar);
			LayoutRecManager._ct.addChild(insert);
			LayoutRecManager.adptAll();
		}

		LayoutRecManager.insetToBarV=function(tar,insert,rate){
			(rate===void 0)&& (rate=0.4);
			var rec;
			rec=tar.getDragArea();
			rec.height=200;
			if (rec.height < 20)
				return;
			var tLen=0;
			tLen=rec.height;
			var dragBar;
			dragBar=LayoutRecManager.getADragBar("T");
			dragBar.size(tar.width,0);
			dragBar.right=tar.right;
			dragBar.left=tar.left
			dragBar.top=tar.top;
			dragBar.bottom=tar.bottom;
			dragBar.type=1;
			dragBar.copyUpdates(tar,"up");
			dragBar.top+=rate *tLen;
			RelativePos.clearBar(insert);
			insert.right=tar.right;
			insert.left=tar.left
			insert.top=tar.top;
			insert.bottom=tar.bottom;
			if (RelativePos.getBar(tar,"down")){
				RelativePos.copyRelative(dragBar,tar,"down");
				RelativePos.cancelRelative(tar,"down");
			}
			RelativePos.addRelative(insert,tar,"up");
			RelativePos.addRelative(insert,dragBar,"down");
			RelativePos.copyRelative(insert,tar,"right");
			RelativePos.copyRelative(dragBar,tar,"right");
			RelativePos.copyRelative(insert,tar,"left");
			RelativePos.copyRelative(dragBar,tar,"left");
			LayoutRecManager._ct.addChild(dragBar);
			LayoutRecManager._ct.addChild(insert);
			LayoutRecManager.adptAll();
		}

		LayoutRecManager.insert=function(tar,insert,rate){
			(rate===void 0)&& (rate=0.4);
			var tLen=0;
			tLen=tar.width;
			insert.right=tar.right;
			tar.right+=tLen *rate;
			insert.left=tar.x+tar.width;
			insert.top=tar.top;
			insert.bottom=tar.bottom;
			var dragBar;
			dragBar=LayoutRecManager.getADragBar("R");
			dragBar.size(0,tar.height);
			dragBar.left=tar.x+tar.width;
			dragBar.top=tar.top;
			dragBar.bottom=tar.bottom;
			if (RelativePos.getBar(tar,"right")){
				RelativePos.copyRelative(insert,tar,"right");
				RelativePos.cancelRelative(tar,"right");
			}
			RelativePos.addRelative(tar,dragBar,"right");
			RelativePos.addRelative(insert,dragBar,"left");
			RelativePos.copyRelative(insert,tar,"down");
			RelativePos.copyRelative(dragBar,tar,"down");
			RelativePos.copyRelative(insert,tar,"up");
			RelativePos.copyRelative(dragBar,tar,"up");
			tar.parent.addChild(dragBar);
			tar.parent.addChild(insert);
			DisControlTool.setTop(dragBar);
			dragBar.type=0;
			LayoutRecManager.adptAll();
		}

		LayoutRecManager.insertL=function(tar,insert,rate){
			(rate===void 0)&& (rate=0.4);
			var tLen=0;
			tLen=tar.width;
			insert.right=tar.right;
			insert.left=tar.left;
			tar.left+=tLen *rate;
			insert.top=tar.top;
			insert.bottom=tar.bottom;
			var dragBar;
			dragBar=LayoutRecManager.getADragBar("R");
			dragBar.size(0,tar.height);
			dragBar.left=tar.x;
			dragBar.top=tar.top;
			dragBar.bottom=tar.bottom;
			if (RelativePos.getBar(tar,"left")){
				RelativePos.copyRelative(insert,tar,"left");
				RelativePos.cancelRelative(tar,"left");
			}
			RelativePos.addRelative(tar,dragBar,"left");
			RelativePos.addRelative(insert,dragBar,"right");
			RelativePos.copyRelative(insert,tar,"down");
			RelativePos.copyRelative(dragBar,tar,"down");
			RelativePos.copyRelative(insert,tar,"up");
			RelativePos.copyRelative(dragBar,tar,"up");
			tar.parent.addChild(dragBar);
			tar.parent.addChild(insert);
			DisControlTool.setTop(dragBar);
			dragBar.type=0;
			LayoutRecManager.adptAll();
		}

		LayoutRecManager.insertV=function(tar,insert,rate){
			(rate===void 0)&& (rate=0.4);
			if(tar.height<150){
				var downBar;
				downBar=RelativePos.getBar(tar,"down");
				if(downBar.type!=2){
					LayoutRecManager.insetToBarV(downBar,insert);
					return;
				}
			};
			var tLen=0;
			tLen=tar.height;
			insert.right=tar.right;
			insert.bottom=tar.bottom;
			tar.bottom+=tLen *rate;
			insert.left=tar.left;
			insert.top=tar.y+tar.height;
			var dragBar;
			dragBar=LayoutRecManager.getADragBar("T");
			dragBar.size(tar.width,0);
			dragBar.left=tar.x;
			dragBar.top=tar.y+tar.height;
			if (RelativePos.getBar(tar,"down")){
				RelativePos.copyRelative(insert,tar,"down");
				RelativePos.cancelRelative(tar,"down");
			}
			RelativePos.addRelative(tar,dragBar,"down");
			RelativePos.addRelative(insert,dragBar,"up");
			RelativePos.copyRelative(insert,tar,"right");
			RelativePos.copyRelative(dragBar,tar,"right");
			RelativePos.copyRelative(insert,tar,"left");
			RelativePos.copyRelative(dragBar,tar,"left");
			tar.parent.addChild(dragBar);
			tar.parent.addChild(insert);
			DisControlTool.setTop(dragBar);
			dragBar.type=1;
			LayoutRecManager.adptAll();
		}

		LayoutRecManager.getADragBar=function(type){
			var dragBar=new LayoutDragBar(type);
			dragBar.on("mousedown",null,LayoutRecManager.onMouseDown);
			return dragBar;
		}

		LayoutRecManager.addPanelToRec=function(panel,rec){
			panel.top=20;
			panel.left=0;
			panel.right=0;
			panel.bottom=0;
			rec.addUI(panel);
		}

		LayoutRecManager.getARec=function(){
			var rec=new LayoutRec();
			rec.addUI(LayoutRecManager.getAUI("#ff00ff"));
			rec.addUI(LayoutRecManager.getAUI("#ff000f"));
			return rec;
		}

		LayoutRecManager.getAUI=function(color){
			(color===void 0)&& (color="#ff00ff");
			var box=new Box();
			box.graphics.drawRect(0,0,20,20,color);
			box.width=20;
			box.height=20;
			box.left=5;
			box.right=5;
			box["title"]="tt:"+Math.ceil(Math.random()*10);
			return box;
		}

		LayoutRecManager.target=null
		LayoutRecManager.Side=2;
		LayoutRecManager.Vertical=1;
		LayoutRecManager.Horizon=0;
		LayoutRecManager._ct=null
		LayoutRecManager.ctOffSetX=0;
		LayoutRecManager.ctOffSetY=0;
		LayoutRecManager.ctOffHeight=5;
		LayoutRecManager.classToUIO={};
		LayoutRecManager._classInited=false;
		LayoutRecManager._layoutFile=null;
		LayoutRecManager.minRecLen=4;
		LayoutRecManager.RecTweenTime=150;
		LayoutRecManager.tweenCompleteHandler=null
		LayoutRecManager.isTweening=false;
		LayoutRecManager.DragBarWidth=0;
		__static(LayoutRecManager,
		['itemClassO',function(){return this.itemClassO={"LayoutDragBar":LayoutDragBar,"LayoutRec":LayoutRec};},'sizeInfos',function(){return this.sizeInfos=["height","width","left","right","bottom","top","x","y","type"];},'sizePosKeys',function(){return this.sizePosKeys=["x","y","width","height"];},'emptyLayoutO',function(){return this.emptyLayoutO={"top":NaN,"bottom":NaN,"left":NaN,"right":NaN};}
		]);
		return LayoutRecManager;
	})()


	/**
	*调整布局的功能
	*@author ww
	*@version 1.0
	*
	*@created 2016-6-27 上午10:10:36
	*/
	//class platform.layout.ResizeRecStruct
	var ResizeRecStruct=(function(){
		function ResizeRecStruct(){
			this.upSide=null;
			this.downSide=null;
			this.leftSide=null;
			this.rightSide=null;
			this.isRoot=false;
			this.resizeItems=null;
			this.mDis=NaN;
			this.sortByXFun=MathUtil.sortByKey("x",false,true);
			this.sortByYFun=MathUtil.sortByKey("y",false,true);
		}

		__class(ResizeRecStruct,'platform.layout.ResizeRecStruct');
		var __proto=ResizeRecStruct.prototype;
		__proto.reset=function(){
			this.upSide=null;
			this.downSide=null;
			this.leftSide=null;
			this.rightSide=null;
		}

		__proto.setBars=function(left,right,up,down){
			this.upSide=up;
			this.downSide=down;
			this.leftSide=left;
			this.rightSide=right;
		}

		__proto.isSame=function(left,right,up,down){
			return this.upSide==up&&this.downSide==down&&this.leftSide==left&&this.rightSide==right;
		}

		__proto.isSameStruct=function(st){
			return this.upSide==st.upSide&&this.downSide==st.downSide&&this.leftSide==st.leftSide&&this.rightSide==st.rightSide;
		}

		__proto.traceMyInfo=function(){
			console.log("up:",this.upSide.getDragBarInfo("up"));
			console.log("down:",this.downSide.getDragBarInfo("down"));
			console.log("left:",this.leftSide.getDragBarInfo("left"));
			console.log("right:",this.rightSide.getDragBarInfo("right"));
		}

		/**
		*调整垂直方向的拖动条
		*@param dis
		*@return
		*
		*/
		__proto.tryMoveRight=function(dis){
			this.mDis=dis;
			var i=0,len=0;
			var _updaters;
			_updaters=this.upSide._updaters;
			len=_updaters.length;
			var tR;
			var dragBarList;
			dragBarList=[];
			var tDragBar;
			for (i=len-1;i >=0;i--){
				tR=_updaters[i];
				if((tR.tar instanceof platform.layout.LayoutDragBar )){
					tDragBar=tR.tar;
					if(tDragBar.cusorType=="e-resize"&&RelativePos.getTypeByFun(tR._fun)=="up"){
						if(this.downSide.findTarType(tDragBar)!=null){
							if(tDragBar.x>=this.leftSide.x&&tDragBar.x<=this.rightSide.x)
								dragBarList.push(tDragBar);
						}
					}
				}
			}
			dragBarList.sort(this.sortByXFun);
			if(dragBarList[0]!=this.leftSide){
				dragBarList.unshift(this.leftSide);
			}
			if(dragBarList[dragBarList.length-1]!=this.rightSide){
				dragBarList.push(this.rightSide);
			}
			if(dragBarList.length<2){
				return false;
			};
			var tWidth=NaN;
			tWidth=0;
			var maxWidth=NaN;
			maxWidth=0;
			var tSelecteDragBar;
			len=dragBarList.length;
			for(i=1;i<len;i++){
				tWidth=dragBarList[i].x-dragBarList[i-1].x;
				if(tWidth>maxWidth){
					maxWidth=tWidth;
					tSelecteDragBar=dragBarList[i];
				}
				if(tWidth+dis>150&&LayoutDragBar.hasFreeTar((dragBarList [i]).getTarsByType("right"))){
					tSelecteDragBar=dragBarList[i];
					break ;
				}
			}
			if(tSelecteDragBar){
				this.moveRightWork(tSelecteDragBar,dragBarList,dis)
				}else{
				debugger;
			}
			return true;
		}

		/**
		*调整水平方向的拖动条
		*@param dis
		*
		*/
		__proto.moveRightWork=function(selectBar,barList,dis){
			var i=0,len=0;
			var rightIndex=0;
			rightIndex=barList.indexOf(selectBar);
			var tLeftBar;
			var tRightBar;
			if(rightIndex>=1){
				tLeftBar=barList[rightIndex-1];
				tRightBar=barList[rightIndex];
				if(tLeftBar==this.leftSide&&tRightBar==this.rightSide){
					}else{
				}
				this.resizeSmallRec(tLeftBar,tRightBar);
			}
			len=barList.length;
			if(this.isRoot){
				len=this.resizeItems.length;
				for(i=0;i<len;i++){
					if(!this.resizeItems[i].walked){
						this.resizeItems[i].left+=dis;
						this.resizeItems[i].walked=true;
					}
				}
				}else{
				for(i=rightIndex;i<len;i++){
					this.resizeItems.push(barList[i]);
				}
			}
		}

		__proto.resizeSmallRec=function(tLeftBar,tRightBar){
			var i=0,len=0;
			var _updaters;
			_updaters=tRightBar._updaters;
			len=_updaters.length;
			var tR;
			var dragBarList;
			dragBarList=[];
			var tDragBar;
			for (i=len-1;i >=0;i--){
				tR=_updaters[i];
				if((tR.tar instanceof platform.layout.LayoutDragBar )){
					tDragBar=tR.tar;
					if(tDragBar.cusorType=="n-resize"&&RelativePos.getTypeByFun(tR._fun)=="right"){
						if(this.leftSide.findTarType(tDragBar)!=null){
							if(tDragBar.y>=this.upSide.y&&tDragBar.y<=this.downSide.y)
								dragBarList.push(tDragBar);
						}
					}
				}
			};
			var tSelecteDragBar;
			dragBarList.sort(this.sortByYFun);
			if(dragBarList[0]!=this.upSide){
				dragBarList.unshift(this.upSide);
			}
			if(dragBarList[dragBarList.length-1]!=this.downSide){
				dragBarList.push(this.downSide);
			}
			len=dragBarList.length;
			var resizeRec;
			for(i=1;i<len;i++){
				resizeRec=new ResizeRecStruct();
				resizeRec.resizeItems=this.resizeItems;
				resizeRec.setBars(tLeftBar,tRightBar,dragBarList[i-1],dragBarList[i]);
				if(this.isSameStruct(resizeRec)){
					}else{
					resizeRec.tryMoveRight(this.mDis);
				}
			}
		}

		return ResizeRecStruct;
	})()


	/**
	*本类控制鼠标光标样式
	*@author ww
	*/
	//class platform.managers.CursorManager
	var CursorManager=(function(){
		function CursorManager(){}
		__class(CursorManager,'platform.managers.CursorManager');
		CursorManager.init=function(){
			CursorManager._style=Browser.document.body.style;
			CursorManager.setType("default");
		}

		CursorManager.setType=function(type){
			CursorManager._style.cursor=type;
		}

		CursorManager.Auto="default";
		CursorManager.Hand="all-scroll";
		CursorManager.HResize="e-resize";
		CursorManager.VResize="n-resize";
		CursorManager._style=null
		return CursorManager;
	})()


	/**
	*编辑区渲染器管理器
	*@author ww
	*@version 1.0
	*
	*@created 2018-5-25 上午10:45:03
	*/
	//class platform.managers.EditRenderManager
	var EditRenderManager=(function(){
		function EditRenderManager(){}
		__class(EditRenderManager,'platform.managers.EditRenderManager');
		EditRenderManager.regRenderClass=function(extension,clz){
			EditRenderManager.renderDic[extension]=clz;
		}

		EditRenderManager.regRender=function(extension,renderPath){
			EditRenderManager.renderDic[extension]=renderPath;
		}

		EditRenderManager.regRenderClassByType=function(type,clz){
			var extension;
			extension=/*no*/this.TypeManager.getExtension(type);
			EditRenderManager.regRenderClass(extension,clz);
		}

		EditRenderManager.getCustomRenderByExtension=function(extension){
			return EditRenderManager.renderDic[extension];
		}

		EditRenderManager.hasCustomRenderByPath=function(filePath){
			if(!filePath)return false;
			if(! (typeof filePath=='string'))return false;
			var extension;
			extension=FileTools.getExtensionName(filePath);
			return EditRenderManager.renderDic.hasOwnProperty(extension);
		}

		EditRenderManager.createCustomRenderByPath=function(filePath){
			var extension;
			extension=FileTools.getExtensionName(filePath);
			var extensionPath;
			extensionPath=EditRenderManager.getCustomRenderByExtension(extension);
			if(! (typeof extensionPath=='string')){
				var renderI;
				var renderClz=EditRenderManager.getCustomRenderByExtension(extension);
				return new renderClz();
			};
			var rst;
			rst=new CustomIFrameRender();
			rst.renderPagePath=extensionPath;
			rst.initIframe();
			return rst;
		}

		EditRenderManager.init=function(){
			EditRenderManager.regIDERenders();
			var customDesignPath;
			customDesignPath=FileManager.getAppPath("plugins/");
			var folders;
			folders=FileTools.getDirChildDirs(customDesignPath);
			var i=0,len=0;
			len=folders.length;
			for(i=0;i<len;i++){
				EditRenderManager.addCustomDesignByFolder(folders[i]);
			}
		}

		EditRenderManager.regIDERenders=function(){}
		EditRenderManager.addCustomDesignByFolder=function(folder){
			if(!FileManager.exists(folder))return;
			var configPath;
			configPath=FileManager.getPath(folder,"render.cfg");
			if (!FileManager.exists(configPath))return;
			console.log("addCustomDesignByFolder:",configPath);
			var configO;
			try{
				configO=FileManager.readJSONFile(configPath);
				if(!configO)return;
				if(configO.extension&&configO.url){
					var renderPath;
					renderPath=FileManager.getPath(folder,configO.url);
					if(FileManager.exists(renderPath)){
						EditRenderManager.regRender(configO.extension,renderPath);
					}
				}
				if (configO.createMenus){
					EditRenderManager.addCreateMenus(folder,configO.createMenus);
				}
				}catch(e){
			}
		}

		EditRenderManager.addCreateMenus=function(rootPath,menus){
			var i=0,len=0;
			len=menus.length;
			for (i=0;i < len;i++){
				EditRenderManager.addCreateMenu(rootPath,menus[i]);
			}
		}

		EditRenderManager.addCreateMenu=function(rootPath,menuO){
			menuO.tplFile=FileManager.getPath(rootPath,menuO.file);
			EditRenderManager._createMenuS.push(menuO);
		}

		EditRenderManager.renderDic={};
		EditRenderManager._createMenuS=[];
		return EditRenderManager;
	})()


	/**
	*
	*@author ww
	*@version 1.0
	*
	*@created 2015-12-25 上午10:19:18
	*/
	//class platform.managers.LayerManager
	var LayerManager=(function(){
		function LayerManager(){}
		__class(LayerManager,'platform.managers.LayerManager');
		LayerManager.init=function(){
			LayerManager.stage=new Box();
			LayerManager.stage.mouseEnabled=true;
			Laya.stage.addChild(LayerManager.stage);
			LayerManager.onStage();
			Laya.stage.on("resize",null,LayerManager.onStage);
		}

		LayerManager.onStage=function(){
			if (Browser.pixelRatio !=1){
				Laya.stage._width=Browser.clientWidth;
				Laya.stage._height=Browser.clientHeight;
				Laya.stage.scale(Browser.pixelRatio,Browser.pixelRatio);
			}
			LayerManager.stage.width=Laya.stage._width>900?Laya.stage._width:900;
			LayerManager.stage.height=Laya.stage._height>700?Laya.stage._height:700;
			LayerManager.stage.height-=1;
			LayerManager.stage.width+=2;
		}

		LayerManager.stage=null
		LayerManager.minWidth=900;
		LayerManager.minHeight=700;
		return LayerManager;
	})()


	/**
	*本类集中初始化各个模块监听的消息
	*@author ww
	*@version 1.0
	*
	*@created 2015-10-26 上午10:39:45
	*/
	//class platform.managers.NoticeRouter
	var NoticeRouter=(function(){
		function NoticeRouter(){}
		__class(NoticeRouter,'platform.managers.NoticeRouter');
		NoticeRouter.init=function(){
			NoticeRouter._initsList=[];
			NoticeRouter._initsList.push(ResPanel.instance);
			NoticeRouter._initsList.push(EditZone.instance);
			NoticeRouter._initsList.push(AddDirectory.instance);
			NoticeRouter._initsList.push(AddResCommomDialog.instance);
			var i=0,len=NoticeRouter._initsList.length;
			for (i=0;i < len;i++){
				NoticeRouter._initsList[i].initListener();
			}
		}

		NoticeRouter._initsList=null
		return NoticeRouter;
	})()


	/**
	*历史状态管理类
	*@author ww
	*/
	//class platform.managers.state.State
	var State=(function(){
		function State(){
			this._stateList=[];
			this._tI=-1;
		}

		__class(State,'platform.managers.state.State');
		var __proto=State.prototype;
		/**
		*添加状态 ，直接使用传入的状态值
		*@param data
		*
		*/
		__proto.add=function(data){
			this.traceState();
			if(this._tI!=this._stateList.length-1){
				this._stateList.length=this._tI+1;
			}
			this._stateList.push(data);
			if(this._stateList.length>150){
				this._stateList.shift();
			}
			this._tI=this._stateList.length-1;
			this.traceState();
		}

		__proto.getLastCache=function(){
			if(this._stateList.length>1){
				return this._stateList[this._stateList.length-2];
			}
			return null;
		}

		__proto.traceState=function(){}
		/**
		*添加状态 ，会拷贝一个副本数据存入
		*@param data
		*
		*/
		__proto.addE=function(data){
			this.add(ObjectTools.copyObj(data));
		}

		/**
		*获取当前状态
		*@return
		*
		*/
		__proto.now=function(){
			return ObjectTools.copyObj(this._stateList[this._tI]);
		}

		/**
		*向后回退
		*@return
		*
		*/
		__proto.back=function(){
			if(this._tI<=0)return null;
			this._tI--;
			this.traceState();
			return this.now();
		}

		/**
		*向前重做
		*@return
		*
		*/
		__proto.forward=function(){
			if(this._tI>=this._stateList.length-1)return null;
			this._tI++;
			this.traceState();
			return this.now();
		}

		State.MaxLen=150;
		return State;
	})()


	/**
	*状态管理类
	*@author ww
	*@version 1.0
	*
	*@created 2015-10-22 下午7:45:51
	*/
	//class platform.managers.StateManager
	var StateManager=(function(){
		function StateManager(){}
		__class(StateManager,'platform.managers.StateManager');
		StateManager.has=function(sign){
			return StateManager._stateDic.hasOwnProperty(sign);
		}

		StateManager.getState=function(sign){
			if(!StateManager._stateDic[sign])StateManager._stateDic[sign]=new State();
			return StateManager._stateDic[sign];
		}

		StateManager.updateState=function(sign,data){
			StateManager.setChangeState(sign,StateManager.has(sign));
			StateManager.getState(sign).addE(data);
		}

		StateManager.removeState=function(sign){
			delete StateManager._stateDic[sign];
			delete StateManager._changeDic[sign];
		}

		StateManager.renameState=function(sign,newSign){
			if(StateManager._stateDic[sign]){
				StateManager._stateDic[newSign]=StateManager._stateDic[sign];
				delete StateManager._stateDic[sign];
			}
			if(StateManager._changeDic[sign]){
				StateManager._changeDic[newSign]=StateManager._changeDic[sign];
				delete StateManager._changeDic[sign];
			}
		}

		StateManager.hasChange=function(sign){
			return StateManager._changeDic[sign];
		}

		StateManager.setChangeState=function(sign,changed){
			StateManager._changeDic[sign]=changed;
		}

		StateManager._stateDic={};
		StateManager._changeDic={};
		return StateManager;
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


	/**对象工具集*/
	//class platform.tools.ObjectUtils
	var ObjectUtils=(function(){
		function ObjectUtils(){};
		__class(ObjectUtils,'platform.tools.ObjectUtils');
		ObjectUtils.addFilter=function(target,filter){
			var filters=target.filters || [];
			filters.push(filter);
			target.filters=filters;
		}

		ObjectUtils.clearFilter=function(target,filterType){
			var filters=target.filters;
			if (filters !=null && filters.length > 0){
				for (var i=filters.length-1;i >-1;i--){
					var filter=filters[i];
					if (Laya.__typeof(filter,filterType)){
						filters.splice(i,1);
					}
				}
				target.filters=filters;
			}
		}

		ObjectUtils.getTextField=function(format,text){
			(text===void 0)&& (text="Test");
			ObjectUtils._tf.align="left";
			ObjectUtils._tf.text=text;
			return ObjectUtils._tf;
		}

		ObjectUtils.measureTextWidth=function(format,text){
			(text===void 0)&& (text="Test");
			return ObjectUtils.getTextField(format,text).width;
		}

		__static(ObjectUtils,
		['_tf',function(){return this._tf=new TextField();}
		]);
		return ObjectUtils;
	})()


	/**
	*
	*@author ww
	*@version 1.0
	*
	*@created 2018-6-13 上午11:49:38
	*/
	//class platform.viewers.IFrameRenderItem
	var IFrameRenderItem=(function(){
		function IFrameRenderItem(){
			this.renderFrame=null;
			this.render=null;
			this.style=null;
			this.iframeWindow=null;
			this.eDispatcher=null;
			this.renderHit=null;
			this.hitBounds=null;
			this.isLoaded=false;
			this.targetParent=null;
			this.eDispatcher=new EventDispatcher();
			this.renderHit=new Sprite();
			this.hitBounds=new Rectangle(0,0);
			IFrameRenderItem.offPos=new Point();
			this.init();
			this.adpt();
		}

		__class(IFrameRenderItem,'platform.viewers.IFrameRenderItem');
		var __proto=IFrameRenderItem.prototype;
		__proto.onRenderHitDown=function(){
			Laya.stage.focus=this.renderHit;
		}

		__proto.onRenderHitMouseOver=function(){
			if(SystemSetting.autoFocsEditRect)
				Laya.stage.focus=this.renderHit;
		}

		__proto.init=function(){
			var _$this=this;
			if (this.renderFrame)return;
			this.renderHit.name="renderHit";
			this.renderHit.mouseEnabled=true;
			this.renderHit.on("dragDrop",this,this.renderDragDrop);
			this.renderFrame=Browser.createElement("iframe");
			this.renderHit.on("mousedown",this,this.onRenderHitDown);
			this.renderHit.on("rightmousedown",this,this.onRenderHitDown);
			this.renderHit.on("mouseover",this,this.onRenderHitMouseOver);
			this.renderFrame.id="viewrender";
			this.renderFrame.width="400";
			this.renderFrame.height="300";
			this.renderFrame.left="400";
			this.renderFrame.top="400";
			this.style=this.renderFrame.style;
			this.style.position="absolute";
			this.style.top="100px";
			this.style.left="220px";
			this.style["z-index"]=101;
			this.style.border="0";
			this.render=this.renderFrame.contentWindow;
			var passEventList=["mousedown","mousemove","mouseup","keydown","keypress","keyup"];
			this.renderFrame.addEventListener("load",onRenderFrameloaded,false)
			function onRenderFrameloaded (){
				_$this.render=_$this.renderFrame.contentWindow.renderBinds;
				_$this.iframeWindow=_$this.renderFrame.contentWindow;
				var i=0,len=0;
				len=passEventList.length;
				for(i=0;i<len;i++){
					_$this.iframeWindow.document.removeEventListener(passEventList[i],_$this.passEvent);
					_$this.iframeWindow.document.addEventListener(passEventList[i],_$this.passEvent);
				}
				_$this.loaded();
			};
			var idePassEventList=["keydown","keypress","keyup"];
			var i=0,len=0;
			len=idePassEventList.length;
			for(i=0;i<len;i++){
				Laya.stage.on(idePassEventList[i],this,this.passEvent2);
			}
		}

		__proto.passEvent=function(e){
			var evt;
			evt=Browser.document.createEvent("Events");
			evt.initEvent(e.type,true,true);
			var key;
			for(key in e){
				if(!((typeof (e[key])=='function'))){
					evt[key]=e[key];
				}
			}
			evt.isFromIDE=true;
			evt.clientX+=IFrameRenderItem.offPos.x;
			evt.clientY+=IFrameRenderItem.offPos.y;
			evt.pageX=0;
			evt.pageY=0;
			if(e.type=="mousedown"){
				if(Browser.window.uicodeMenuDiv){
					Browser.window.uicodeMenuDiv.hide();
				}
			}
			if(!IFrameRenderItem.isFromMe)
				Render.canvas.dispatchEvent(evt);
		}

		__proto.passEvent2=function(e){
			if(!this.iframeWindow)return;
			if(Input.isInputting)return;
			e=e.nativeEvent;
			if(e.isFromIDE)return;
			var evt;
			evt=Browser.document.createEvent("Events");
			evt.initEvent(e.type,true,true);
			var key;
			for(key in e){
				if(!((typeof (e[key])=='function'))){
					evt[key]=e[key];
				}
			}
			IFrameRenderItem.isFromMe=true;
			this.iframeWindow.document.dispatchEvent(evt);
			IFrameRenderItem.isFromMe=false;
		}

		__proto.insertClassList=function(clsList,tarWindow){
			if(!tarWindow)tarWindow=this.iframeWindow;
			var i=0,len=0;
			len=clsList.length;
			var tClz;
			for(i=0;i<len;i++){
				tClz=clsList[i];
				this.insertClass(tClz,tarWindow);
			}
		}

		__proto.insertClass=function(clz,tarWindow){
			if(!tarWindow)tarWindow=this.iframeWindow;
			var tName;
			tName=clz.__className;
			var pathList
			pathList=tName.split(".");
			var i=0,len=0;
			len=pathList.length;
			var tPath;
			var tO;
			tO=tarWindow;
			for(i=0;i<len-1;i++){
				tPath=pathList[i];
				if(!tO[tPath])tO[tPath]={};
				tO=tO[tPath];
			}
			tO[pathList[len-1]]=clz;
		}

		__proto.renderDragDrop=function(e){
			Laya.stage.focus=this.renderHit;
			var point=DisControlTool.getMousePoint(this.renderHit);
			e.data.dropX=point.x;
			e.data.dropY=point.y;
			Notice.notify("DROP_RENDER",[e]);
		}

		__proto.renderMouseHandler=function(e){
			if(!this.iframeWindow)return;
			var point;
			point=DisControlTool.getMousePoint(this.renderHit);
			var evt;
			evt=Browser.document.createEvent("MouseEvents");
			evt.initMouseEvent(
			e.type,
			true,
			true,
			Browser.document.defaultView,
			0,
			point.x,
			point.y,
			point.x,
			point.y);
			this.iframeWindow.dispatchEvent(evt);
		}

		// trace("re patch event:",evt,point.x,point.y);
		__proto.loaded=function(){
			console.log("IFrameRenderItem loaded");
			Notice.listen("RenderInited",null,this.renderInited);
			if(this.render)
				this.render.setNotice(Notice.I);
			this.eDispatcher.event("complete");
			this.adpt();
			Laya.stage.event("focus");
			this.isLoaded=true;
		}

		__proto.renderInited=function(){
			console.log("renderInited");
		}

		/**
		*调整iframe位置
		*
		*/
		__proto.adpt=function(){
			if (this.renderFrame){
				var pos=new Point();
				pos=this.targetParent.localToGlobal(pos);
				var dLen=0;
				dLen=25;
				this.renderHit.width=this.targetParent.width;
				this.renderHit.height=this.targetParent.height-dLen;
				this.renderHit.x=this.targetParent.x;
				this.renderHit.y=this.targetParent.y+dLen;
				var style;
				style=this.renderFrame.style;
				IFrameRenderItem.offPos.setTo(pos.x,pos.y+dLen);
				style.top=pos.y+dLen+"px";
				style.left=(pos.x)+"px";
				this.renderFrame.width=this.renderHit.width;
				this.renderFrame.height=this.renderHit.height;
				this.hitBounds.width=this.renderHit.width;
				this.hitBounds.height=this.renderHit.height;
				this.hitBounds.x=0;
				this.hitBounds.y=0;
				this.renderHit.setBounds(this.hitBounds);
			}
		}

		/**
		*设置渲染器的url
		*@param url
		*
		*/
		__proto.setRender=function(url){
			if(this.isLoaded)return;
			this.renderFrame.src=url;
		}

		/**
		*显示
		*
		*/
		__proto.show=function(){
			if(!this.renderFrame.parentNode)
				Browser.container.appendChild(this.renderFrame);
			this.setVisible(true);
			this.targetParent.parent.addChild(this.renderHit);
			this.adpt();
		}

		/**
		*隐藏
		*
		*/
		__proto.hide=function(clearSrc){
			(clearSrc===void 0)&& (clearSrc=false);
			this.setVisible(false);
			if(clearSrc){
				this.renderFrame.src="";
			}
			this.renderHit.removeSelf();
		}

		__proto.setVisible=function(visible){
			var style;
			style=this.renderFrame.style;
			if(visible){
				style.display="";
				}else{
				style.display="none";
			}
		}

		IFrameRenderItem.offPos=null
		IFrameRenderItem.isFromMe=false;
		return IFrameRenderItem;
	})()


	/**
	*...
	*@author WW
	*/
	//class viewRender.EditorRenderBase
	var EditorRenderBase=(function(){
		function EditorRenderBase(){
			this.initFuns();
		}

		__class(EditorRenderBase,'viewRender.EditorRenderBase');
		var __proto=EditorRenderBase.prototype;
		__proto.initFuns=function(){
			Browser.window.renderBinds={};
			Browser.window.renderBinds.setData=Utils.bind(this.setData,this);
			Browser.window.renderBinds.updateData=Utils.bind(this.updateData,this);
			Browser.window.renderBinds.clearRender=Utils.bind(this.clearRender,this);
			Browser.window.renderBinds.sizeRender=Utils.bind(this.sizeRender,this);
			Browser.window.renderBinds.posRender=Utils.bind(this.posRender,this);
			Browser.window.renderBinds.getRenderData=Utils.bind(this.getRenderData,this);
			Browser.window.renderBinds.getStage=Utils.bind(this.getStage,this);
			Browser.window.renderBinds.setNotice=Utils.bind(this.setNotice,this);
			Browser.window.renderBinds.firstInit=Utils.bind(this.firstInit,this);
		}

		__proto.getRenderData=function(){
			return null;
		}

		__proto.setData=function(data){}
		__proto.updateData=function(data){}
		__proto.clearRender=function(){}
		__proto.sizeRender=function(width,height){}
		__proto.posRender=function(x,y){}
		__proto.getStage=function(){
			return Laya.stage;
		}

		__proto.setNotice=function(notice){
			Notice.I=notice;
			Notice.notify("RenderInited");
		}

		__proto.firstInit=function(complete,param){}
		return EditorRenderBase;
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


	/**拖动条
	*@author ww
	*/
	//class platform.layout.DragBar extends laya.ui.Component
	var DragBar=(function(_super){
		function DragBar(mouseType){
			this._map={"R":"WE","L":"WE","T":"NS","B":"NS","BL":"NESW","BR":"NWSE"};
			this._cursorType=null;
			this.isDraging=false;
			DragBar.__super.call(this);
			this._bitmap=new Image();
			(mouseType===void 0)&& (mouseType="R");
			switch(mouseType){
				case "R":
					this._cursorType="e-resize";
					break ;
				case "T":
					this._cursorType="n-resize";
					break ;
				default :
				this._cursorType="default";
				}
			this.on("mouseover",this,this.onRollOver);
			this.on("mouseout",this,this.onRollOut);
			this.mouseEnabled=true;
			Laya.stage.on("mouseout",this,this.onRollOut);
			this.on("dragstart",this,this.dragingBegin);
			this.on("dragend",this,this.dragingEnd);
		}

		__class(DragBar,'platform.layout.DragBar',_super);
		var __proto=DragBar.prototype;
		__proto.dragingBegin=function(e){
			this.isDraging=true;
			PlatformVars.isDragingLayout=true;
			LayoutRecManager.containerBox.mouseEnabled=false;
			this.onRollOver(null);
		}

		__proto.dragingEnd=function(e){
			this.isDraging=false;
			CursorManager.setType("default");
			PlatformVars.isDragingLayout=false;
			LayoutRecManager.containerBox.mouseEnabled=true;
		}

		__proto.onStageMouseLeave=function(e){
			this.onRollOut();
		}

		__proto.onRollOut=function(e){
			if (this.isDraging)return;
			CursorManager.setType("default");
		}

		__proto.onRollOver=function(e){
			CursorManager.setType(this._cursorType);
		}

		__getset(0,__proto,'cusorType',function(){
			return this._cursorType;
		});

		return DragBar;
	})(Component)


	/**
	*编辑页基类
	*@author ww
	*/
	//class platform.editzone.SceneBase extends laya.ui.Box
	var SceneBase=(function(_super){
		function SceneBase(){
			this.data=null;
			this._path=null;
			this._title=null;
			this._scaleView=1;
			this._changed=false;
			SceneBase.__super.call(this);
		}

		__class(SceneBase,'platform.editzone.SceneBase',_super);
		var __proto=SceneBase.prototype;
		Laya.imps(__proto,{"platform.editzone.IEditViewer":true})
		__proto.setUp=function(parent){}
		//trace("SceneBase setUp");
		__proto.save=function(){}
		__proto.open=function(){}
		__proto.clears=function(){}
		__proto.onActive=function(){}
		__proto.changeDataO=function(dataO){}
		__proto.focusDesign=function(){}
		__proto.dealAction=function(funName,param){
			if ((typeof (this[funName])=='function')){
				this[funName].apply(this,param);
			}
		}

		__proto.show=function(){}
		__proto.renderDragDrop=function(e){}
		__proto.propChange=function(key,data){}
		__proto.onResClick=function(data){}
		__proto.getDesignData=function(){
			return {};
		}

		__proto.goBack=function(){}
		__proto.goForward=function(){}
		__getset(0,__proto,'pagePath',function(){
			return this._path;
			},function(path){
			this._path=path;
			this._title=FileTools.getFileName(this._path);
		});

		__getset(0,__proto,'scaleView',function(){
			return this._scaleView;
			},function(value){
			this._scaleView=value;
		});

		__getset(0,__proto,'canSetPageInfo',function(){
			return false;
		});

		__getset(0,__proto,'useDesignChangeEvent',function(){
			return false;
		});

		__getset(0,__proto,'title',function(){
			return this._title;
		});

		__getset(0,__proto,'design',function(){
			return this;
		});

		__getset(0,__proto,'hasChange',function(){
			return this._changed;
		});

		return SceneBase;
	})(Box)


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
	*布局框的拖动条
	*@author ww
	*/
	//class platform.layout.LayoutDragBar extends platform.layout.DragBar
	var LayoutDragBar=(function(_super){
		function LayoutDragBar(mouseType){
			this.type=0;
			this.mId=0;
			this.walked=false;
			this._updaters=[];
			this.relativeO={};
			this.sortByXFun=MathUtil.sortByKey("x",false,true);
			this.sortByYFun=MathUtil.sortByKey("y",false,true);
			(mouseType===void 0)&& (mouseType="R");
			LayoutDragBar.__super.call(this,mouseType);
			this.mId=LayoutDragBar.ID;
			LayoutDragBar.ID++;
			this.hitArea=new HitArea();
			this.zOrder=99;
		}

		__class(LayoutDragBar,'platform.layout.LayoutDragBar',_super);
		var __proto=LayoutDragBar.prototype;
		/**
		*获取可拖动范围
		*@return
		*
		*/
		__proto.getDragArea=function(){
			var area;
			area=new Rectangle();
			var borderVar=NaN;
			switch (this.type){
				case 0:
					area.y=this.y;
					area.height=0;
					area.x=this.getBorderVar("right","left",0,false)+220;
					borderVar=this.x+this.getBorderVar("left","width",999,true);
					borderVar-=220;
					if (borderVar < this.x)
						borderVar=this.x;
					area.width=borderVar-area.x;
					break ;
				case 1:
					area.y=this.getBorderVar("down","top",0,false)+220;
					borderVar=this.y+this.getBorderVar("up","height",999,true);
					borderVar-=220;
					if (borderVar < this.y)
						borderVar=this.y;
					area.height=borderVar-area.y;
					area.x=this.x;
					area.width=0;
					break ;
				}
			return area;
		}

		__proto.changeSize=function(){
			laya.ui.Component.prototype.changeSize.call(this);
			var g=this.graphics;
			g.clear();
			var hArea;
			hArea=this.hitArea;
			hArea.hit.clear();
			if(this.width<this.height){
				hArea.hit.drawRect(-4,0,4*2,this.height,"#ff0000");
				}else{
				hArea.hit.drawRect(0,-4,this.width,4*2,"#ff0000");
			}
			this.updates();
		}

		__proto.updates=function(){
			var i=0,len=0;
			len=this._updaters.length;
			for (i=0;i < len;i++){
				this._updaters[i].update();
			}
		}

		__proto.getBorderVar=function(type,sign,sValue,isMin){
			(isMin===void 0)&& (isMin=true);
			var i=0,len=0;
			var uList=this._updaters;
			len=uList.length;
			var tValue=NaN;
			tValue=sValue;
			var tUpdater;
			var tFun;
			tFun=RelativePos.typeToFunO[type];
			if (isMin){
				for (i=0;i < len;i++){
					tUpdater=uList[i];
					if (tUpdater._fun==tFun){
						if (tUpdater.tar[sign] < tValue){
							tValue=tUpdater.tar[sign];
						}
					}
				}
			}
			else{
				for (i=0;i < len;i++){
					tUpdater=uList[i];
					if (tUpdater._fun==tFun){
						if (tUpdater.tar[sign] > tValue){
							tValue=tUpdater.tar[sign];
						}
					}
				}
			}
			return tValue;
		}

		__proto.clear=function(){
			this._updaters.length=0;
		}

		/**
		*
		*@param tar
		*
		*/
		__proto.mergeUpdates=function(tar){
			if (!tar)
				return;
			var i=0,len=0;
			var tarUpdaters;
			tarUpdaters=tar._updaters;
			tarUpdaters=ObjectTools.setValueArr([],tarUpdaters);
			len=tarUpdaters.length;
			var tR;
			var tType;
			for (i=0;i < len;i++){
				tR=tarUpdaters[i];
				tType=RelativePos.getTypeByFun(tR._fun);
				if(tR.tar==this||tR.to==this)continue ;
				RelativePos.addRelative(tR.tar,this,tType,tR.d);
			}
			this.updates();
		}

		__proto.copyUpdates=function(tar,side){
			var i=0,len=0;
			var tarUpdaters;
			tarUpdaters=tar._updaters;
			tarUpdaters=ObjectTools.setValueArr([],tarUpdaters);
			len=tarUpdaters.length;
			var tR;
			var tType;
			for (i=0;i < len;i++){
				tR=tarUpdaters[i];
				tType=RelativePos.getTypeByFun(tR._fun);
				if(tR.tar==this||tR.to==this)continue ;
				if(side==tType){
					RelativePos.addRelative(tR.tar,this,tType,tR.d);
				}
			}
			this.updates();
		}

		/**
		*
		*@param tar
		*
		*/
		__proto.removeTarget=function(tar){
			var i=0,len=0;
			len=this._updaters.length;
			for (i=len-1;i >=0;i--){
				if (this._updaters[i].tar==tar){
					this._updaters.splice(i,1);
				}
			}
		}

		__proto.findTarType=function(tar){
			var i=0,len=0;
			len=this._updaters.length;
			var tR;
			for (i=0;i < len;i++){
				tR=this._updaters[i];
				if (tR.tar==tar){
					return tR._fun;
				}
			}
			return null;
		}

		__proto.canMove=function(dirType,len){
			if (!LayoutDragBar.canMoveO){
				LayoutDragBar.canMoveO={};
				var tO;
				tO={};
				tO["left"]=true;
				tO["right"]=true;
				LayoutDragBar.canMoveO[0]=tO;
				tO={};
				tO["up"]=true;
				tO["down"]=true;
				LayoutDragBar.canMoveO[1]=tO;
			}
			if (!LayoutDragBar.canMoveO[this.type][dirType])return false;
			return false;
		}

		/**
		*对象所在的方向是否只有它一个对象
		*@param tar
		*@return
		*
		*/
		__proto.isOnly=function(tar){
			if (this.type==2)
				return false;
			var i=0,len=0;
			len=this._updaters.length;
			var fun=this.findTarType(tar);
			if (fun==null)
				return false;
			var tR;
			for (i=0;i < len;i++){
				tR=this._updaters[i];
				if ((tR._fun==fun)&& (tR.tar !=tar)){
					return false;
				}
				if (tR.tar !=tar){
					if ((tR.tar instanceof platform.layout.LayoutRec )){
						if ((tR.tar).disMode==1){
							return false;
						}
					}
				}
			}
			return true;
		}

		__proto.getSideType=function(){
			if(this._updaters.length>0){
				return RelativePos.getTypeByFun(this._updaters[0]._fun);
			}
			return null;
		}

		__proto.addItem=function(tar,fun,d){
			(d===void 0)&& (d=0);
			var updater;
			updater=new RelativePos(fun,tar,this,0);
			this._updaters.push(updater);
		}

		__proto.clears=function(){
			this.clear();
			this.destroy(false);
		}

		__proto.getTarsByType=function(type){
			var i=0,len=0;
			len=this._updaters.length;
			var tR;
			var tFun;
			tFun=tFun=RelativePos.typeToFunO[type];
			var rst;
			rst=[];
			for (i=0;i < len;i++){
				tR=this._updaters[i];
				if (tR._fun==tFun){
					rst.push(tR.tar);
				}
			}
			return rst;
		}

		__proto.getDragBarInfo=function(type){
			var rsts;
			rsts=[];
			var i=0,len=0;
			len=this._updaters.length;
			var tR;
			var dragBarList;
			dragBarList=[];
			var tDragBar;
			for (i=len-1;i >=0;i--){
				tR=this._updaters[i];
				if((tR.tar instanceof platform.layout.LayoutRec )){
					if(type&&type==RelativePos.getTypeByFun(tR._fun))
						rsts.push((tR.tar).tTabTxt);
				}
			}
			return "id:"+this.mId+"_"+rsts.join(",");
		}

		/**
		*调整垂直方向的拖动条
		*@param dis
		*@return
		*
		*/
		__proto.tryMoveRight=function(dis){
			if(this.walked)return false;
			this.walked=true;
			var i=0,len=0;
			len=this._updaters.length;
			var tR;
			var dragBarList;
			dragBarList=[];
			var tDragBar;
			for (i=len-1;i >=0;i--){
				tR=this._updaters[i];
				if((tR.tar instanceof platform.layout.LayoutDragBar )){
					tDragBar=tR.tar;
					if(tDragBar.cusorType=="e-resize"&&RelativePos.getTypeByFun(tR._fun)=="up"){
						dragBarList.push(tDragBar);
					}
				}
			}
			if(dragBarList.length<2){
				return false;
			}
			dragBarList.sort(this.sortByXFun);
			var tWidth=NaN;
			tWidth=0;
			var maxWidth=NaN;
			maxWidth=0;
			var tSelecteDragBar;
			len=dragBarList.length;
			for(i=1;i<len;i++){
				tWidth=dragBarList[i].x-dragBarList[i-1].x;
				if(tWidth>maxWidth){
					maxWidth=tWidth;
					tSelecteDragBar=dragBarList[i];
				}
			}
			if(tSelecteDragBar){
				tSelecteDragBar.moveRightWork(dis);
			}
			return true;
		}

		/**
		*调整水平方向的拖动条
		*@param dis
		*
		*/
		__proto.moveRightWork=function(dis){
			if(this.walked)return;
			this.walked=true;
			var i=0,len=0;
			len=this._updaters.length;
			var tR;
			var dragBarList;
			dragBarList=[];
			var tDragBar;
			for (i=len-1;i >=0;i--){
				tR=this._updaters[i];
				if((tR.tar instanceof platform.layout.LayoutDragBar )){
					tDragBar=tR.tar;
					if(tDragBar.cusorType=="n-resize"&&RelativePos.getTypeByFun(tR._fun)=="right"){
						dragBarList.push(tDragBar);
					}
				}
			};
			var tSelecteDragBar;
			dragBarList.sort(this.sortByYFun);
			len=dragBarList.length;
			for(i=0;i<len;i++){
				tSelecteDragBar=dragBarList[i];
				tSelecteDragBar.tryMoveRight(dis);
			}
			this.left+=dis;
		}

		/**
		*调整垂直方向的拖动条
		*@param dis
		*@return
		*
		*/
		__proto.tryMoveDown=function(dis){
			var i=0,len=0;
			len=this._updaters.length;
			var tR;
			var dragBarList;
			dragBarList=[];
			var tDragBar;
			for (i=len-1;i >=0;i--){
				tR=this._updaters[i];
				if((tR.tar instanceof platform.layout.LayoutDragBar )){
					tDragBar=tR.tar;
					if(tDragBar.cusorType=="n-resize"){
						dragBarList.push(tDragBar);
					}
				}
			}
			if(dragBarList.length<2){
				return false;
			}
			dragBarList.sort(this.sortByYFun);
			var tWidth=NaN;
			tWidth=0;
			var maxWidth=NaN;
			maxWidth=0;
			var tSelecteDragBar;
			len=dragBarList.length;
			for(i=1;i<len;i++){
				tWidth=dragBarList[i].y-dragBarList[i-1].y;
				if(tWidth>maxWidth){
					maxWidth=tWidth;
					tSelecteDragBar=dragBarList[i];
				}
			}
			if(tSelecteDragBar){
				tSelecteDragBar.moveDownWork(dis);
			}
			return true;
		}

		/**
		*调整水平方向的拖动条
		*@param dis
		*
		*/
		__proto.moveDownWork=function(dis){
			if(this.walked)return;
			this.walked=true;
			var i=0,len=0;
			len=this._updaters.length;
			var tR;
			var dragBarList;
			dragBarList=[];
			var tDragBar;
			for (i=len-1;i >=0;i--){
				tR=this._updaters[i];
				if((tR.tar instanceof platform.layout.LayoutDragBar )){
					tDragBar=tR.tar;
					if(tDragBar.cusorType=="e-resize"&&RelativePos.getTypeByFun(tR._fun)=="down"){
						if(!tDragBar.walked)
							dragBarList.push(tDragBar);
					}
				}
			};
			var tSelecteDragBar;
			dragBarList.sort(this.sortByXFun);
			len=dragBarList.length;
			for(i=0;i<len;i++){
				tSelecteDragBar=dragBarList[i];
				tSelecteDragBar.tryMoveDown(dis);
			}
			this.top+=dis;
		}

		__getset(0,__proto,'_dragX',function(){
			return this.x;
			},function(value){
			this.x=value;
			this.left=value;
			this.updates();
		});

		__getset(0,__proto,'_dragY',function(){
			return this.y;
			},function(value){
			this.y=value;
			this.top=value;
			this.updates();
		});

		LayoutDragBar.hasFreeTar=function(items){
			var i=0,len=0;
			len=items.length;
			var tRec;
			for (i=0;i < len;i++){
				tRec=items[i];
				if ((tRec instanceof platform.layout.LayoutRec )){
					if(tRec.sizeFree){
						return true;
					}
				}
			}
			return false;
		}

		LayoutDragBar.ID=1;
		LayoutDragBar.debugMode=true;
		LayoutDragBar.BarDragAreaLen=4;
		LayoutDragBar.minWidth=220;
		LayoutDragBar.canMoveO=null;
		return LayoutDragBar;
	})(DragBar)


	/**
	*
	*@author ww
	*@version 1.0
	*
	*@created 2018-5-25 上午10:02:33
	*/
	//class platform.editzone.CustomIFrameRender extends platform.editzone.SceneBase
	var CustomIFrameRender=(function(_super){
		function CustomIFrameRender(){
			this.renderPagePath="renders/design3d/index.html";
			this.iframeSprite=null;
			CustomIFrameRender.__super.call(this);
			this.iframeSprite=new EditViewerIFrameSprite();
			this.iframeSprite.bottom=this.iframeSprite.top=this.iframeSprite.left=this.iframeSprite.right=0;
			this.addChild(this.iframeSprite);
			this.iframeSprite.on("loaded",this,this.onIFrameLoaded);
		}

		__class(CustomIFrameRender,'platform.editzone.CustomIFrameRender',_super);
		var __proto=CustomIFrameRender.prototype;
		__proto.initIframe=function(){
			this.iframeSprite.setUrl(this.renderPagePath);
		}

		__proto.onIFrameLoaded=function(){
			this.initPage();
		}

		__proto.initPage=function(){
			this._changed=false;
			var data;
			if(this.pagePath){
				if(StateManager.has(this.pagePath)){
					data=StateManager.getState(this.pagePath).now();
					}else{
					try{
						var jsonStr=FileTools.readFile(this.pagePath);
						data=ObjectTools.getObj(jsonStr);
						StateManager.updateState(this.pagePath,data);
						}catch(e){
						Alert.show(Sys.lang("读取数据出错，请查看文件是否已损坏:"+this.pagePath));
						return;
					}
				}
				}else{
				data=this.iframeSprite.renderItem.getRenderData();
			}
			try{
				Laya.timer.frameOnce(1,this,this.renderByData,[data]);
			}
			catch(e){}
		}

		__proto.save=function(){
			_super.prototype.save.call(this);
			if (this.pagePath){
				this.saveFile(this.pagePath);
			}
		}

		__proto.saveFile=function(file){
			if(file){
				var data=StateManager.getState(this.pagePath).now();
				FileManager.createTxtFile(file,JsonTool.getJsonString(data,false));
				MessageManager.instance.show(Sys.lang("保存成功"));
				this._changed=false;
				StateManager.setChangeState(this.pagePath,false);
				Laya.stage.event("pageSaved");
				Laya.stage.event(/*no*/this.IDEEvent.PAGE_CHANGED);
			}
		}

		__proto.renderByData=function(data){
			var updateData;
			updateData={};
			updateData.type="init";
			updateData.url=FileTools.getAbsPath(this.pagePath);
			updateData.base=FileTools.getAbsPath(SystemSetting.assetsPath+FileTools.getSep());
			updateData.projectPath=SystemSetting.workPath;
			updateData.data=data;
			try{
				this.iframeSprite.renderItem.updateData(updateData);
				}catch(e){
			}
		}

		__proto.goBack=function(){
			_super.prototype.goBack.call(this);
			var data=StateManager.getState(this.pagePath).back();
			if(!data){
				console.log("当前不可回退");
				return;
			};
			this.setRenderData(data);
		}

		__proto.goForward=function(){
			_super.prototype.goForward.call(this);
			var data=StateManager.getState(this.pagePath).forward();
			if(!data){
				console.log("当前不可前进");
				return;
			};
			this.setRenderData(data);
		}

		__proto.dataChanged=function(){
			this._changed=true;
			StateManager.setChangeState(this.pagePath,true);
			StateManager.updateState(this.pagePath,this.iframeSprite.renderItem.getRenderData());
			Laya.stage.event("pageChanged");
		}

		__proto.setRenderData=function(data){
			this.renderByData(data);
			this._changed=true;
			StateManager.setChangeState(this.pagePath,true);
			Laya.stage.event("pageChanged");
		}

		__getset(0,__proto,'hasChange',function(){
			return StateManager.hasChange(this.pagePath);
		});

		return CustomIFrameRender;
	})(SceneBase)


	//class ui.edit.EditTabUI extends laya.ui.View
	var EditTabUI=(function(_super){
		function EditTabUI(){
			this.btn=null;
			this.close=null;
			EditTabUI.__super.call(this);
		}

		__class(EditTabUI,'ui.edit.EditTabUI',_super);
		var __proto=EditTabUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(EditTabUI.uiView);
		}

		EditTabUI.uiView={"type":"View","props":{"scenecolor":"#dddddd"},"child":[{"type":"Button","props":{"y":0,"x":0,"width":75,"var":"btn","skin":"view/tab_uipanel.png","labelMargin":"0,0,15,0","labelColors":"#dddddd,#888888,#e0e0e0","label":"label","height":25}},{"type":"Button","props":{"y":9,"x":59,"var":"close","skin":"view/btn_close1.png","scaleX":0.5,"scaleY":0.5,"stateNum":2}}]};
		return EditTabUI;
	})(View)


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
			this.div.addEventListener("load",Utils.bind(this.onIFrameLoaded,this),false)
		}

		__proto.onIFrameLoaded=function(){}
		__proto.setUrl=function(path){
			this.div.src=path;
		}

		__getset(1,IFrameSprite,'I',function(){
			if (!IFrameSprite._I)IFrameSprite._I=new IFrameSprite();
			return IFrameSprite._I;
		},platform.extenddisplay.HtmlSprite._$SET_I);

		IFrameSprite._I=null
		return IFrameSprite;
	})(HtmlSprite)


	/**
	*可拖动布局框的基类
	*@author ww
	*/
	//class platform.layout.DragView extends laya.ui.View
	var DragView=(function(_super){
		function DragView(){
			this.minWidth=50;
			this.minHeight=50;
			this.defaultWidth=100;
			this.defaultHeight=100;
			this.title="";
			this.helpUrl="";
			this.canClose=true;
			this.canMix=true;
			this.freeSize=false;
			this.layoutTab=null;
			DragView.__super.call(this);
		}

		__class(DragView,'platform.layout.DragView',_super);
		return DragView;
	})(View)


	//class ui.layout.LayoutRecUI extends laya.ui.View
	var LayoutRecUI=(function(_super){
		function LayoutRecUI(){
			this.back=null;
			this.tab=null;
			this.tipIcon=null;
			this.actionIcon=null;
			LayoutRecUI.__super.call(this);
		}

		__class(LayoutRecUI,'ui.layout.LayoutRecUI',_super);
		var __proto=LayoutRecUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(LayoutRecUI.uiView);
		}

		LayoutRecUI.uiView={"type":"View","props":{"hitTestPrior":true},"child":[{"type":"Image","props":{"y":0,"x":0,"width":600,"var":"back","top":0,"skin":"view/bg_panel_layoutrec.png","right":0,"left":0,"height":25}},{"type":"Tab","props":{"y":0,"x":0,"var":"tab","skin":"view/tab_panel.png","labelColors":"#61737C,#c5c5c5,#c5c5c5,#c5c5c5"}},{"type":"Image","props":{"y":6,"x":581,"visible":false,"var":"tipIcon","skin":"comp/iconhelp.png","scaleX":0.5,"scaleY":0.5}},{"type":"Image","props":{"y":9,"x":5,"visible":false,"var":"actionIcon","skin":"view/arrow_down.png","scaleY":0.5,"scaleX":0.5}}]};
		return LayoutRecUI;
	})(View)


	//class ui.layout.LayoutTabUI extends laya.ui.View
	var LayoutTabUI=(function(_super){
		function LayoutTabUI(){
			this.btn=null;
			this.close=null;
			LayoutTabUI.__super.call(this);
		}

		__class(LayoutTabUI,'ui.layout.LayoutTabUI',_super);
		var __proto=LayoutTabUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(LayoutTabUI.uiView);
		}

		LayoutTabUI.uiView={"type":"View","props":{"scenecolor":"#dddddd"},"child":[{"type":"Button","props":{"y":0,"x":0,"width":75,"var":"btn","skin":"view/tab_panel.png","labelColors":"#dddddd,#888888,#e0e0e0","label":"label","height":25}},{"type":"Button","props":{"y":10,"x":60,"var":"close","skin":"view/btn_close1.png","scaleX":0.5,"scaleY":0.5,"stateNum":2}}]};
		return LayoutTabUI;
	})(View)


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


	/**视图标签
	*@author ww
	*/
	//class platform.editzone.EditTab extends ui.edit.EditTabUI
	var EditTab=(function(_super){
		function EditTab(viewer,tip){
			this._uiViewer=null;
			EditTab.__super.call(this);
			this._uiViewer=viewer;
			var comp;
			comp=viewer;
			comp.left=comp.right=comp.bottom=0;
			comp.top=0;
			if (viewer.useDesignChangeEvent){
				viewer.design.on("change",this,this.onDesignChange);
				}else{
				Laya.stage.on("pageChanged",this,this.onDesignChange);
			}
			this.onDesignChange(null);
			this.close.on("click",this,this.onCloseClick);
			this.btn.labelAlign="left";
			this.btn.labelPadding="-2,5,0,5"
			this.btn.labelColors=StyleConsts.LayoutTabTitleBtnColors;
			this.toolTip=tip?tip:FileManager.getRelativePath(SystemSetting.assetsPath,viewer.pagePath);
		}

		__class(EditTab,'platform.editzone.EditTab',_super);
		var __proto=EditTab.prototype;
		__proto.onCloseClick=function(e){
			EditZone.instance.tryToClose(this._uiViewer);
		}

		//e.stopPropagation();
		__proto.onDesignChange=function(e){
			var len=ObjectUtils.getTextField(null,"*"+this._uiViewer.title).width+25;
			this.btn.width=len;
			this.close.x=len-this.close.displayWidth-8;
			this.btn.label=(this._uiViewer.hasChange ? "*" :"")+this._uiViewer.title;
		}

		__getset(0,__proto,'width',function(){
			return this.btn.width;
		},_super.prototype._$set_width);

		__getset(0,__proto,'uiViewer',function(){
			return this._uiViewer;
		});

		/**点击处理器(无默认参数)*/
		__getset(0,__proto,'clickHandler',function(){
			return this.btn.clickHandler;
			},function(value){
			this.btn.clickHandler=value;
		});

		/**是否是选择状态*/
		__getset(0,__proto,'selected',function(){
			return this.btn.selected;
			},function(value){
			this.btn.selected=value;
		});

		return EditTab;
	})(EditTabUI)


	/**
	*...
	*@author ww
	*/
	//class platform.editzone.EditViewerIFrameSprite extends platform.extenddisplay.IFrameSprite
	var EditViewerIFrameSprite=(function(_super){
		function EditViewerIFrameSprite(){
			this.renderFrame=null;
			this.renderItem=null;
			this.style=null;
			this.iframeWindow=null;
			EditViewerIFrameSprite.__super.call(this);
		}

		__class(EditViewerIFrameSprite,'platform.editzone.EditViewerIFrameSprite',_super);
		var __proto=EditViewerIFrameSprite.prototype;
		__proto.onIFrameLoaded=function(){
			_super.prototype.onIFrameLoaded.call(this);
			this.iframeWindow=this.div.contentWindow;
			this.renderItem=this.iframeWindow.renderBinds;
			if (!this.renderItem)return;
			Notice.listen("RenderInited",null,this.renderInited);
			if(this.renderItem)
				this.renderItem.setNotice(Notice.I);
			this.event("loaded");
		}

		__proto.renderInited=function(){
			console.log("renderInited");
		}

		return EditViewerIFrameSprite;
	})(IFrameSprite)


	//class ui.edit.EditZoneUI extends platform.layout.DragView
	var EditZoneUI=(function(_super){
		function EditZoneUI(){
			this.tab=null;
			EditZoneUI.__super.call(this);
		}

		__class(EditZoneUI,'ui.edit.EditZoneUI',_super);
		var __proto=EditZoneUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(EditZoneUI.uiView);
		}

		EditZoneUI.uiView={"type":"DragView","props":{"title":"UI","scenecolor":"#dddddd","recTabSkin":"view/tab_uipanel.png","recBarSkin":"view/bg_uipanel_bar.png","hitTestPrior":true},"child":[{"type":"Image","props":{"y":0,"x":0,"top":0,"skin":"view/bg_uiviewer.png","right":0,"left":0,"bottom":0}},{"type":"Image","props":{"y":0,"x":0,"width":164,"skin":"view/bg_uipanel.png","sizeGrid":"0,3,0,3","right":0,"left":0,"height":25}},{"type":"Tab","props":{"y":0,"x":0,"var":"tab","skin":"view/tab_uipanel.png"}}]};
		return EditZoneUI;
	})(DragView)


	/**
	*布局框
	*@author ww
	*/
	//class platform.layout.LayoutRec extends ui.layout.LayoutRecUI
	var LayoutRec=(function(_super){
		function LayoutRec(){
			this.disList=null;
			this._backHeight=NaN;
			this.preWidth=0;
			this.preHeight=0;
			this.preMoveLen=0;
			this._curUI=null;
			this._curMenuBox=null;
			this.tTabTxt=null;
			this.tTabHelpUrl=null;
			this.curActionType=null;
			this.relativeO={};
			this._disMode=2;
			LayoutRec.__super.call(this);
			this.tab.on("change",this,this.onTabChange);
			this.back.on("mousedown",this,this.onBackDown);
			this.back.on("doubleclick",this,this.onBackDoubleDown);
			this.disList=[this.tab];
			this._backHeight=this.back.height;
			this.on("Draging_Hit",this,this._$7_onMouseOver);
			this.on("mouseover",this,this.onMouseOverThis);
			this.on("mouseout",this,this.onMouseOutThis);
			this.updateUIState();
			this.on("added",this,this._$7_onAdded);
			Notice.listen("SHOW_LayoutTab_By_Name",this,this.showTabByName);
			this.tab.labelColors=StyleConsts.TreeItemColor;
			this.tipIcon.on("mousedown",this,this.onTipClick);
			this.tipIcon.toolTip=Sys.lang("点击打开帮助文档");
			var hArea;
			hArea=new HitArea();
			this.actionIcon.hitArea=hArea;
			hArea.hit.clear();
			hArea.hit.drawRect(-10,-16,60,40,"#ff0000");
			this.actionIcon.on("mousedown",this,this.onActionIconClick);
		}

		__class(LayoutRec,'platform.layout.LayoutRec',_super);
		var __proto=LayoutRec.prototype;
		__proto.onActionIconClick=function(e){
			e.stopPropagation();
			console.log("onActionIconClick:",this.curActionType);
			switch(this.curActionType){
				case "toBottom":
					LayoutRecManager.minToBottom(this);
					break ;
				case "toLeft":
					LayoutRecManager.minToLeft(this);
					break ;
				case "toRight":
					LayoutRecManager.minToRight(this);
					break ;
				}
		}

		__proto.onTipClick=function(){
			if(!this._curUI)return;
			var className;
			className=ClassTool.getClassName(this._curUI);
			var tUrl;
			tUrl=LayoutRec.PanelTips[className];
			if(tUrl){
				Browser.window.open(tUrl);
			}
		}

		__proto.getCurTipUrl=function(){
			if(!this._curUI)return null;
			var className;
			className=ClassTool.getClassName(this._curUI);
			var tUrl;
			tUrl=LayoutRec.PanelTips[className];
			return tUrl;
		}

		__proto.onMouseOutThis=function(){}
		__proto._$7_onAdded=function(){}
		__proto.updateUIState=function(){
			this.back.visible=this.tab.visible=this.canAddTab;
		}

		__proto.onMouseOverThis=function(E){
			if(this.isMinRecState)return;
			if(this._curMenuBox){
				this._curMenuBox.visible=true;
			}
			if (this.parent==LayerManager.stage){
				DisResizer.setUp(this,true);
			}
		}

		__proto.onThisDown=function(e){
			if (this.parent==LayerManager.stage){
				DisResizer.setUp(this,true);
			}
		}

		__proto.onBackDown=function(e){
			if (this.parent==LayerManager.stage){
				this.startDrag();
				this.once("dragend",this,this.stopDrag);
				}else{
				this.startDragMe();
			}
		}

		__proto.updateUIMinStates=function(){
			var isMinRec=false;
			isMinRec=this.isMinRecState;
			if(isMinRec){
				if(this._curMenuBox){
					this._curMenuBox.visible=false;
				}
				if(this._curUI){
					this._curUI.visible=false;
				}
				this.tipIcon.visible=false;
				}else{
				if(this._curMenuBox){
				}
				if(this._curUI){
					this._curUI.visible=true;
				}
			}
			this.tab.visible=this.canAddTab&&(this.width>30);
		}

		__proto.updateActionIcon=function(){
			if(this._disMode==1){
				switch(this.curActionType){
					case "toBottom":
						this.actionIcon.skin="view/arrow_up.png";
						break ;
					case "toLeft":
						this.actionIcon.skin="view/arrow_right.png";
						break ;
					case "toRight":
						this.actionIcon.skin="view/arrow_left.png";
						break ;
					default :
						this.actionIcon.skin=null;
					}
				}else{
				switch(this.curActionType){
					case "toBottom":
						this.actionIcon.skin="view/arrow_down.png";
						break ;
					case "toLeft":
						this.actionIcon.skin="view/arrow_left.png";
						break ;
					case "toRight":
						this.actionIcon.skin="view/arrow_right.png";
						break ;
					default :
						this.actionIcon.skin=null;
					}
			}
		}

		__proto.onBackDoubleDown=function(e){
			if(/*no*/this.IDEVars.disableTabDrag)return;
			if (this.parent !=LayerManager.stage){
				LayoutRecManager.popRec(this);
			}
			else{
			}
		}

		//DisResizer.setUp(this);
		__proto.goMinState=function(){
			DisControlTool.removeItems(this.disList);
		}

		//back.bottom=0;
		__proto.goMaxState=function(){
			DisControlTool.addItems(this.disList,this);
		}

		//Laya.timer.once(100,this,later);
		__proto.later=function(){
			this.back.height=this._backHeight;
		}

		__proto._$7_onMouseOver=function(e){
			if (!DragManager.isDraging)return;
			if (!(DragManager.getDragType()=="LayoutRec" || DragManager.getDragType()=="LayoutTab"))return;
			var type=RelativePos.getDisMouseRelativePos(this);
			if(DragManager.getDragTarget()==this){
				if(type=="up"){
					type="center";
				}
			}
			if(DragManager.getDragType()=="LayoutTab"){
				if(type=="up"){
					type="center";
				}
			};
			var focusWidth=NaN;
			switch (type){
				case "right":
				case "left":
					focusWidth=0.5*this.width;
					FocusManager.showBorder(this,type,true,null,focusWidth);
					break ;
				case "up":
				case "down":
					focusWidth=0.5*this.height;
					FocusManager.showBorder(this,type,true,null,focusWidth);
					break ;
				case "center":
					FocusManager.showFocus(this);
					break ;
				}
			DisControlTool.setTop(this);
		}

		__proto._$7_onMouseOut=function(e){}
		__proto.onDragDown=function(e){
			e.stopPropagation();
			this.startDragMe();
		}

		__proto.startDragMe=function(self){
			(self===void 0)&& (self=false);
			if(LayoutRecManager.popLocked())return;
			if(!this.canDragMe)return;
			if(PlatformVars.disableTabDrag)return;
			var clip=new Clip(SkinDefines.LayoutRecDragIcon,1,3);
			clip.index=2;
			var type="LayoutRec";
			DragManager.I.doDrag(this,self?null:clip,{type:type,target:this},DragManager.dragOffset);
		}

		__proto.closeHandler=function(e){
			LayoutRecManager.removeRec(this);
		}

		__proto.changeSize=function(){
			laya.ui.Component.prototype.changeSize.call(this);
			if(this.tab){
				var rec;
				rec=this.tab.scrollRect||new Rectangle();
				rec.setTo(0,0,this.width,25);
				this.tab.scrollRect=rec;
			}
			this.updateUIMinStates();
		}

		__proto.getTabSkin=function(){
			return this.getTabProp("recTabSkin");
		}

		__proto.getTabAction=function(){
			return this.getTabProp("recActionType");
		}

		__proto.getTabActionPos=function(){
			return this.getTabProp("recActionPos");
		}

		__proto.getTabProp=function(key){
			var tabList;
			tabList=this.tab.items;
			var i=0,len=0;
			len=tabList.length;
			for(i=0;i<len;i++){
				if(tabList[i]&&tabList[i].ui&&tabList[i].ui[key])return tabList[i].ui[key];
			}
			return null;
		}

		__proto.onTabChange=function(e){
			if (this._curUI){
				this._curUI.removeSelf();
				if(this._curMenuBox){
					this._curMenuBox.removeSelf();
				}
				this._curUI=null;
			}
			if (this.tab.selectedIndex !=-1){
				this._curUI=(this.tab.selection).ui;
				if(PlatformVars.enableTabMenu){
					this._curMenuBox=this._curUI["menuBox"];
					if(this._curMenuBox){
						this._curMenuBox.left=80;
						this._curMenuBox.right=0;
						this._curMenuBox.bottom=NaN;
						this._curMenuBox.top=NaN;
						this._curMenuBox.y=0;
						this._curMenuBox.visible=false;
						this.addChild(this._curMenuBox);
					}
				}
				if(this._curUI["recBarSkin"]){
					this.back.skin=this._curUI["recBarSkin"];
				}
				this.curActionType=this.getTabAction();
				if(this.curActionType){
					this.actionIcon.visible=true;
					switch(this.getTabActionPos()){
						case "right":
							this.tab.left=0;
							this.actionIcon.right=9;
							this.actionIcon.left=NaN;
							break ;
						default :
							this.tab.left=this.actionIcon.x+this.actionIcon.displayWidth+6;
							this.actionIcon.left=5;
							this.actionIcon.right=NaN;
						}
					this.updateActionIcon();
					}else{
					this.actionIcon.visible=false;
					this.tab.left=0;
				}
				this.addChildAt(this._curUI,0);
				this.tTabTxt=this._curUI["title"];
				this.tTabHelpUrl=this._curUI["helpUrl"];
				if(Laya.__typeof(this._curUI,this.UIPanel)){
					this.cacheAsBitmap=false;
					(this.tab.selection).cacheAsBitmap=false;
				}
			}
		}

		__proto.addUI=function(ui){
			var uiTab=new LayoutTab(ui);
			if(!uiTab.hasTabSkin){
				if(this.getTabSkin()){
					uiTab.setTabSkin(this.getTabSkin());
				}
			}
			this.addTab(uiTab);
		}

		__proto.addTab=function(uiTab){
			var index=0;
			index=this.tab.addItem(uiTab);
			this.tab.selectedIndex=index;
			uiTab._rec=this;
			this.updateUIState();
		}

		__proto.removeTab=function(uiTab,autoRemove){
			(autoRemove===void 0)&& (autoRemove=false);
			this.tab.delItem(uiTab);
			uiTab._rec=null;
			this.updateUIState();
			if(autoRemove&&this.tab.items.length<1){
				LayoutRecManager.removeRec(this);
			}
		}

		// onTabChange(null);
		__proto.removeUI=function(ui,autoRemove){
			(autoRemove===void 0)&& (autoRemove=false);
			var tabList;
			tabList=this.tab.items;
			var i=0,len=0;
			len=tabList.length;
			for(i=0;i<len;i++){
				if(tabList[i].ui==ui){
					this.removeTab(tabList[i],autoRemove);
					return;
				}
			}
		}

		__proto.getUIs=function(){
			var i=0,len=0;
			var items;
			items=this.tab.items;
			len=items.length;
			var rst;
			rst=[];
			for (i=0;i < len;i++){
				rst.push((items [i]).ui);
			}
			return rst;
		}

		__proto.clearRelative=function(){
			RelativePos.clearBar(this);
		}

		__proto.showTabByName=function(tabName){
			if(this._curUI&&this._curUI["title"]==tabName)return;
			var tabList;
			tabList=this.tab.items;
			var i=0,len=0;
			len=tabList.length;
			for(i=0;i<len;i++){
				if(tabList[i].ui&&tabList[i].ui["title"]==tabName){
					this.tab.selectedIndex=i;
					return;
				}
			}
		}

		__proto.clears=function(){
			Notice.cancel("SHOW_LayoutTab_By_Name",this,this.showTabByName);
			this.clearRelative();
			this.tab.destroy();
			this.destroy(false);
		}

		__getset(0,__proto,'disMode',function(){
			return this._disMode;
			},function(type){
			if (this._disMode !=1){
				this.preWidth=this.width;
				this.preHeight=this.height;
			}
			if (this._disMode==type)
				return;
			this._disMode=type;
			this.updateActionIcon();
			return;
			switch (this._disMode){
				case 1:
					this.goMinState();
					LayoutRecManager.minRec(this);
					this.back.off("mousedown",this,this.onBackDown);
					this.back.on("mousedown",this,this.onBackDown);
					break ;
				default :
					this.back.off("mousedown",this,this.onBackDown);
					this.goMaxState();
					LayoutRecManager.recoverRec(this);
				}
		});

		__getset(0,__proto,'isMinRecState',function(){
			return this.width<30||this.height<30;
		});

		__getset(0,__proto,'canAddTab',function(){
			var tabList;
			tabList=this.tab.items;
			var i=0,len=0;
			len=tabList.length;
			for(i=0;i<len;i++){
				if(!tabList[i].canMix)return false;
			}
			return true;
		});

		__getset(0,__proto,'canClose',function(){
			var tabList;
			tabList=this.tab.items;
			var i=0,len=0;
			len=tabList.length;
			for(i=0;i<len;i++){
				if(!tabList[i].canClose)return false;
			}
			return true;
		});

		__getset(0,__proto,'hasFree',function(){
			var tabList;
			tabList=this.tab.items;
			var i=0,len=0;
			len=tabList.length;
			for(i=0;i<len;i++){
				if(tabList[i].freeSize)return true;
			}
			return false;
		});

		__getset(0,__proto,'canDragMe',function(){
			return this.canAddTab;
		});

		__getset(0,__proto,'sizeFree',function(){
			if(this.hasFree){
				return true;
			}
			return !this.canAddTab;
		});

		LayoutRec.Min=1;
		LayoutRec.Normal=2;
		LayoutRec.Max=3;
		LayoutRec.preTipIcon=null
		__static(LayoutRec,
		['PanelTips',function(){return this.PanelTips={
		};}

		]);
		return LayoutRec;
	})(LayoutRecUI)


	/**
	*布局框标签
	*@author ww
	*/
	//class platform.layout.LayoutTab extends ui.layout.LayoutTabUI
	var LayoutTab=(function(_super){
		function LayoutTab(tabUI){
			this._ui=null;
			this._rec=null;
			LayoutTab.__super.call(this);
			this._ui=tabUI;
			this._ui.left=this._ui.right=this._ui.bottom=0;
			if(Laya.__typeof(this._ui,this.HtmlSprite)){
				this._ui.left=this._ui.right=this._ui.bottom=5;
			}
			this._ui.top=25;
			if(!this.canMix){
				this._ui.top=0;
			}
			this._ui["layoutTab"]=this;
			this.btn.skin=this.tabSkin;
			this.close.on("click",this,this.onCloseClick);
			this.btn.on("mousedown",this,this.onBtnDown);
			this.onTitleChange();
			if(!this.canClose){
				this.close.visible=false;
			}
			if(PlatformVars.disableTabClose){
				this.close.visible=false;
				}else{
				this.btn.labelAlign="left";
				this.btn.labelPadding="-2,5,0,5";
			}
			this.btn.labelColors=StyleConsts.LayoutTabTitleBtnColors;
		}

		__class(LayoutTab,'platform.layout.LayoutTab',_super);
		var __proto=LayoutTab.prototype;
		//cacheAsBitmap=true;
		__proto.setTabSkin=function(skin){
			this.btn.skin=skin;
		}

		__proto.onBtnDown=function(e){
			if(LayoutRecManager.popLocked())return;
			if(this._rec&&!this._rec.canDragMe)return;
			if(PlatformVars.disableTabDrag)return;
			var clip=new Clip(/*no*/this.SkinDefines.LayoutTabDragIcon,1,3);
			clip.index=2;
			var type="LayoutTab";
			DragManager.I.doDrag(this ,clip,{type:type,target:this._rec},DragManager.dragOffset);
		}

		__proto.onCloseClick=function(e){
			if(this._rec)
				this._rec.removeTab(this,true);
			this.clears();
		}

		__proto.onTitleChange=function(e){
			var title;
			title=this._ui["title"]?this._ui["title"]:"我是标题啊";
			var len=ObjectUtils.getTextField(null,"*"+title).width+20;
			this.btn.width=len;
			this.close.x=len-this.close.displayWidth-3;
			this.btn.label=title;
		}

		__proto.clears=function(){
			this._ui=null;
		}

		__getset(0,__proto,'recActionPos',function(){
			if(this._ui&&this._ui["recActionPos"]){
				return this._ui["recActionPos"];
			}
			return null;
		});

		__getset(0,__proto,'recActionType',function(){
			if(this._ui&&this._ui["recActionType"]){
				return this._ui["recActionType"];
			}
			return null;
		});

		__getset(0,__proto,'canClose',function(){
			if(!this._ui)return true;
			return this._ui["canClose"];
		});

		__getset(0,__proto,'recBarSkin',function(){
			if(this._ui&&this._ui["recBarSkin"]){
				return this._ui["recBarSkin"];
			}
			return "view/bg_panel_layoutrec.png";
		});

		__getset(0,__proto,'canMix',function(){
			if(!this._ui||!this._ui.hasOwnProperty("canMix"))return true;
			return this._ui["canMix"];
		});

		__getset(0,__proto,'recLineSkin',function(){
			if(this._ui&&this._ui["recLineSkin"]){
				return this._ui["recLineSkin"];
			}
			return null;
		});

		__getset(0,__proto,'freeSize',function(){
			if(!this._ui||!this._ui.hasOwnProperty("freeSize"))return false;
			return this._ui["freeSize"];
		});

		__getset(0,__proto,'hasTabSkin',function(){
			if(this._ui&&this._ui["recTabSkin"]){
				return true;
			}
			return false;
		});

		__getset(0,__proto,'tabSkin',function(){
			if(this._ui&&this._ui["recTabSkin"]){
				return this._ui["recTabSkin"];
			}
			return "view/tab_panel.png";
		});

		__getset(0,__proto,'width',function(){
			return this.btn.width;
		},_super.prototype._$set_width);

		/**点击处理器(无默认参数)*/
		__getset(0,__proto,'clickHandler',function(){
			return this.btn.clickHandler;
			},function(value){
			this.btn.clickHandler=value;
		});

		/**是否是选择状态*/
		__getset(0,__proto,'selected',function(){
			return this.btn.selected;
			},function(value){
			this.btn.selected=value;
		});

		__getset(0,__proto,'ui',function(){
			return this._ui;
		});

		return LayoutTab;
	})(LayoutTabUI)


	//class ui.deskplatform.ResPanelUI extends platform.layout.DragView
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

		ResPanelUI.uiView={"type":"DragView","props":{"width":200,"title":"资源","scenecolor":"#dddddd","hitTestPrior":true,"height":300},"child":[{"type":"Image","props":{"y":48,"x":415,"width":200,"top":0,"skin":"view/bg_panel.png","right":0,"left":0,"height":300,"bottom":0}},{"type":"TreeEx","props":{"y":552,"x":173,"width":196,"var":"resTree","top":112,"scrollBarSkin":"comp/vscroll.png","right":2,"left":2,"hitTestPrior":true,"height":136,"bottom":29},"child":[{"type":"Box","props":{"right":0,"name":"render","left":0},"child":[{"type":"Clip","props":{"y":0,"x":13,"skin":"comp/clip_selectBox.png","right":0,"name":"selectBox","left":9,"height":25,"clipY":2}},{"type":"Image","props":{"y":4,"x":14,"skin":"comp/folder.png","name":"icon","width":16,"height":16}},{"type":"Label","props":{"y":1,"width":150,"text":"label","right":0,"padding":"4,0,0,0","name":"label","left":38,"height":22,"color":"#d8d8d8"}},{"type":"Clip","props":{"y":6,"x":0,"skin":"comp/clip_tree.png","name":"arrow","clipY":2,"width":11,"height":12}}]}]},{"type":"Image","props":{"y":3,"x":222,"width":198,"var":"resViewer","right":1,"left":1,"height":100}},{"type":"Image","props":{"y":106,"x":2,"skin":"comp/line.png","right":0,"left":0,"height":1}},{"type":"Box","props":{"y":271,"x":1,"width":198,"var":"opBox","right":0,"left":0,"height":28,"bottom":0},"child":[{"type":"Image","props":{"width":191,"top":0,"skin":"view/bg_panel_bar.png","right":0,"left":0,"bottom":0}},{"type":"TextInput","props":{"y":4,"x":80,"width":148,"var":"fliterTxt","toolTip":"输入关键词过滤","skin":"comp/input_22.png","right":5,"padding":"0,10,0,20","left":80,"color":"#dddddd","sizeGrid":"0,3,0,3","height":22}},{"type":"Button","props":{"y":3,"x":3,"toolTip":"打开所在目录","stateNum":3,"skin":"view/login2.png","name":"openDirBtn","scaleX":0.5,"scaleY":0.5}},{"type":"Button","props":{"y":3,"x":29,"toolTip":"设置默认属性","stateNum":3,"skin":"view/settings2.png","name":"setPropBtn","scaleX":0.5,"scaleY":0.5}},{"type":"Button","props":{"y":4,"x":55,"toolTip":"刷新资源树","stateNum":3,"skin":"view/refresh2.png","name":"refreshBtn","scaleX":0.5,"scaleY":0.5}},{"type":"Clip","props":{"y":7,"x":82,"skin":"view/search.png","clipY":1,"index":0,"scaleX":0.5,"scaleY":0.5}},{"type":"Button","props":{"y":12,"var":"clearSearchBtn","skin":"view/btn_close1.png","right":9,"scaleX":0.5,"scaleY":0.5,"stateNum":2}}]},{"type":"Label","props":{"y":82,"x":6,"width":162,"var":"sizeTxt","text":"512*512","padding":"4,0,0,0","name":"label","height":19,"color":"#d8d8d8","align":"left"}}]};
		return ResPanelUI;
	})(DragView)


	//class ui.deskplatform.AddDirectoryUI extends laya.ui.Dialog
	var AddDirectoryUI=(function(_super){
		function AddDirectoryUI(){
			this.titleTxt=null;
			this.nameTip=null;
			this.nameTxt=null;
			AddDirectoryUI.__super.call(this);
		}

		__class(AddDirectoryUI,'ui.deskplatform.AddDirectoryUI',_super);
		var __proto=AddDirectoryUI.prototype;
		__proto.createChildren=function(){
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(AddDirectoryUI.uiView);
		}

		AddDirectoryUI.uiView={"type":"Dialog","props":{"width":500,"scenecolor":"#dddddd","height":250},"child":[{"type":"Image","props":{"y":0,"x":0,"width":500,"skin":"view/bg_dialog.png","height":250,"sizeGrid":"47,20,22,37"}},{"type":"Button","props":{"skin":"view/btn_close.png","name":"close","scaleX":0.5,"scaleY":0.5,"right":11,"y":7}},{"type":"Image","props":{"y":7,"x":9,"width":438,"skin":"comp/blank_title_dragrec.png","name":"drag","height":36}},{"type":"Label","props":{"x":28,"width":140,"var":"titleTxt","text":"新增目录","styleSkin":"comp/label_panel_title.png","height":18,"fontSize":14,"align":"center","color":"#ffffff","centerX":0,"y":16}},{"type":"Label","props":{"y":86,"x":51,"width":92,"var":"nameTip","text":"目录名称：","styleSkin":"comp/label_intro.png","height":18,"fontSize":14,"color":"#C8C8C8"}},{"type":"TextInput","props":{"y":117,"x":51,"width":400,"var":"nameTxt","skin":"comp/input_32.png","color":"#dddddd","sizeGrid":"0,3,0,3","fontSize":14,"padding":"0,4,0,4","height":32}},{"type":"Button","props":{"y":175,"x":190,"skin":"comp/button.png","name":"sure","label":"新增","labelColors":"#FFFFFF,#FFFFFF,#FFFFFF,#c5c5c5","labelSize":16,"sizeGrid":"0,4,0,4"}}]};
		return AddDirectoryUI;
	})(Dialog)


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


	/**编辑区分页管理器
	*@author ww
	*/
	//class platform.editzone.EditZone extends ui.edit.EditZoneUI
	var EditZone=(function(_super){
		function EditZone(){
			this._currViewer=null;
			this._copyTemp=null;
			this.tabEx=null;
			this._menu=null;
			EditZone.__super.call(this);
			this._container=new Box();
			this._mScrollRec=new Rectangle();
			this.init();
			this.canClose=false;
			this.canMix=false;
			this.tabEx=this.tab;
			this._container.width=100;
			this._container.height=100;
			this._container.top=25;
			this._container.bottom=0;
			this._container.left=0;
			this._container.right=0;
			this._container.mouseEnabled=true;
			this.tab.labelColors=StyleConsts.LayoutTabTitleBtnColors;
			this.addChild(this._container);
			this.on("mousewheel",this,this.mouseWheel);
		}

		__class(EditZone,'platform.editzone.EditZone',_super);
		var __proto=EditZone.prototype;
		__proto.mouseWheel=function(e){
			platform.editzone.EditZone.instance.setScale(2*e.delta/100);
		}

		__proto.initListener=function(){
			Notice.listen("closePage",this,this.closePage);
			Notice.listen("openPAGE",this,this.openPage);
			Notice.listen("Focus_design",this,this.focusDesign);
			Notice.listen("FRESH_CurView",this,this.refreshCurrView);
		}

		__proto.init=function(){
			this.tab.on("change",this,this.onTabChange);
			this.tab.on("doubleclick",this,this.onTabDoubleClick);
			this.on("mouseover",this,this.onRollOver);
			this.initTabMenu();
		}

		__proto.hasPageOpen=function(){
			return this.tabEx.items.length>0;
		}

		__proto.changeSize=function(){
			laya.ui.Component.prototype.changeSize.call(this);
			this.tabEx.maxLen=this.width;
			this.tabEx.updateUI();
			this._mScrollRec.setTo(0,0,this._container.width,this._container.height);
			this._container.scrollRect=this._mScrollRec;
		}

		__proto.onRollOver=function(e){}
		/**双击关闭页面*/
		__proto.onTabDoubleClick=function(e){
			if (this._currViewer){
				this.tryToClose(this._currViewer);
			}
		}

		/**如果内容没有保存，提示保存*/
		__proto.tryToClose=function(uiViewer){
			console.log("tryToClose");
			if (uiViewer.hasChange){
				}else {
				this.closeBack(uiViewer);
			}
		}

		/**保存后关闭*/
		__proto.saveBack=function(uiViewer){
			uiViewer.save();
			this.closePage(uiViewer.pagePath);
		}

		/**处理页面关闭*/
		__proto.closeBack=function(uiViewer){
			if(uiViewer==this._currViewer){
				this.clearPanelsData();
			}
			this.closePage(uiViewer.pagePath);
		}

		__proto.clearPanelsData=function(){}
		/**切换标签时刷新页面*/
		__proto.onTabChange=function(e){
			if (this._currViewer){
				this._currViewer.removeSelf();
				this._currViewer=null;
			}
			this.clearPanelsData();
			if (this.tab.selectedIndex !=-1){
				this._currViewer=(this.tab.selection).uiViewer;
				if(this._currViewer){
					this._container.addChild(this._currViewer);
					this._currViewer.onActive();
				}
			}
		}

		/**初始化右键菜单*/
		__proto.initTabMenu=function(){
			var menu=ContextMenu$1.createMenu("关闭","关闭其他","关闭全部");
			menu.on("select",this,this.onEmunSelect);
			this._menu=menu;
			this.tab.on("rightmousedown",this,this.onTabRightMouseDown);
		}

		__proto.onTabRightMouseDown=function(e){
			for (var i=0,n=this.tab.numChildren;i < n;i++){
				var viewTab=this.tab.getChildAt(i);
				if (viewTab && e.target.parent==viewTab){
					if(this.tab.selectedIndex!=i)
						this.tab.selectedIndex=i;
					this._menu.show();
					break ;
				}
			}
		}

		__proto.onEmunSelect=function(name){
			switch (name){
				case "关闭":
					this.closePage(this._currViewer.pagePath);
					break ;
				case "关闭其他":
					this.closeAll(null,null,this.tab.selectedIndex);
					break ;
				case "关闭全部":
					this.closeAll();
					break ;
				}
		}

		/**关闭页面*/
		__proto.closePage=function(pagePath){
			pagePath=FileManager.adptToCommonUrl(pagePath);
			StateManager.removeState(pagePath);
			StateManager.setChangeState(pagePath,false);
			var index=this.getTabIndex(pagePath);
			if (index !=-1){
				if(this.tab.items[index]){
					var viewTab=this.tab.items [index];
					if(viewTab&&viewTab.uiViewer&&viewTab.uiViewer.clears!=null){
						viewTab.uiViewer.clears();
					}
				}
				this.tab.delItem(this.tab.items[index]);
				this.onTabChange(null);
				if (this.tab.items.length==0){}
					return true;
			}
			return false;
		}

		/**获得页面索引*/
		__proto.getTabIndex=function(pagePath){
			for (var i=0,n=this.tab.items.length;i < n;i++){
				var viewTab=this.tab.items [i];
				if (pagePath==viewTab.uiViewer.pagePath){
					return i;
				}
			}
			return-1;
		}

		/**显示页面*/
		__proto.openPage=function(pagePath,title){
			pagePath=FileManager.adptToCommonUrl(pagePath);
			var index=this.getTabIndex(pagePath);
			var viewTab;
			var viewer;
			if (index==-1){
				if(EditRenderManager.hasCustomRenderByPath(pagePath)){
					var customIFrameRender;
					customIFrameRender=EditRenderManager.createCustomRenderByPath(pagePath);
					viewer=customIFrameRender;
					viewer.pagePath=pagePath;
					viewTab=new EditTab(viewer);
					index=this.tab.addItem(viewTab);
					}else{
					return;
				}
			}
			this._currViewer=viewer;
			this.tab.selectedIndex=index;
		}

		/**保存当前页面*/
		__proto.save=function(){
			if (this._currViewer !=null){
				this._currViewer.save();
			}
		}

		/**刷新当前视图*/
		__proto.refreshCurrView=function(){
			if (this._currViewer !=null){
				this.stage.focus=this._currViewer.design;
				this._currViewer.dealAction("refresh");
			}
		}

		/**恢复*/
		__proto.goBack=function(){
			if (this._currViewer !=null){
				this._currViewer.dealAction("goBack");
			}
		}

		/**重置*/
		__proto.goForward=function(){
			if (this._currViewer !=null){
				this._currViewer.dealAction("goForward");
			}
		}

		/**保存所有*/
		__proto.saveAll=function(){
			var viewTab;
			for(var $each_viewTab in this.tab.items){
				viewTab=this.tab.items[$each_viewTab];
				viewTab.uiViewer.save();
			}
		}

		__proto.hasNotSavedFile=function(){
			for (var j=0;j < this.tab.items.length;j++){
				var viewTab=this.tab.items [j];
				if (viewTab.uiViewer.hasChange){
					return true;
				}
			}
			return false;
		}

		/**关闭所有*/
		__proto.closeAll=function(complete,args,exceptIndex){
			var _$this=this;
			(exceptIndex===void 0)&& (exceptIndex=-1);
			for (var j=0;j < this.tab.items.length;j++){
				if (j !=exceptIndex){
					var viewTab=this.tab.items [j];
					if (viewTab.uiViewer.hasChange){
						return;
					}
				}
			}
			closeAllBack();
			function saveAllBack (){
				_$this.saveAll();
				closeAllBack();
			}
			function closeAllBack (){
				for (var i=_$this.tab.items.length-1;i >-1;i--){
					if (i !=exceptIndex){
						var view=/*no*/this.ViewTab(_$this.tab.items[i]).uiViewer;
						_$this.closePage(view.pagePath);
					}
				}
				if (complete !=null){
					complete.apply(null,args);
				}
			}
		}

		/**关闭当前页面*/
		__proto.closeCurrPage=function(){
			this.onTabDoubleClick(null);
		}

		/**更改同层先后顺序*/
		__proto.sortComp=function(up){
			(up===void 0)&& (up=true);
			if (this._currViewer !=null){
				this._currViewer.dealAction("sortComp",[up]);
			}
		}

		/**改变层*/
		__proto.moveLayer=function(up){
			(up===void 0)&& (up=true);
			if (this._currViewer !=null){
				this._currViewer.dealAction("moveLayer",[up]);
			}
		}

		/**获得ui视图*/
		__proto.getUIViewer=function(pagePath){
			pagePath=FileManager.adptToCommonUrl(pagePath);
			var viewTab;
			for(var $each_viewTab in this.tab.items){
				viewTab=this.tab.items[$each_viewTab];
				if (viewTab.uiViewer.pagePath==pagePath){
					return viewTab.uiViewer;
				}
			}
			return null;
		}

		/**设置焦点*/
		__proto.focusDesign=function(){
			if (this._currViewer !=null){
				if(! (this._currViewer instanceof laya.display.Sprite )){
					Laya.stage.focus=this;
				}
				this._currViewer.focusDesign();
			}
		}

		__getset(0,__proto,'currViewer',function(){
			return this._currViewer;
		});

		/**是否有变化*/
		__getset(0,__proto,'hasChange',function(){
			var viewTab;
			for(var $each_viewTab in this.tab.items){
				viewTab=this.tab.items[$each_viewTab];
				if (viewTab.uiViewer.design&&viewTab.uiViewer.design.hasChange){
					return true;
				}
			}
			return false;
		});

		/**打开的页面*/
		__getset(0,__proto,'openPages',function(){
			var arr=[];
			var viewTab;
			for(var $each_viewTab in this.tab.items){
				viewTab=this.tab.items[$each_viewTab];
				arr.push(viewTab.uiViewer.pagePath);
			}
			return arr;
		});

		__getset(1,EditZone,'instance',function(){
			return EditZone._instance ? EditZone._instance :EditZone._instance=new EditZone();
		},ui.edit.EditZoneUI._$SET_instance);

		EditZone._instance=null
		EditZone.borderWidth=1;
		EditZone.topLen=25;
		return EditZone;
	})(EditZoneUI)


	/**资源面板
	*@author ww
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

		__proto.initListener=function(){
			Notice.listen("ADD_COMMON_RES",this,this.onCreateNewResBack);
			Notice.listen("adddir",this,this.addDirectory);
		}

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
			var menu=ContextMenu$1.createMenu("打开所在目录","","重命名","删除","新建目录");
			menu.on("select",this,this.onEmunSelect);
			this._menu=menu;
			menu.nativeMenu.append(this.createNewMenu());
			this._menuDir=ContextMenu$1.createMenu("打开所在目录","","重命名","删除");
			this._menuDir.on("select",this,this.onEmunSelect);
			this._mutiMenu=ContextMenu$1.createMenu("删除");
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

		__proto.createNewMenu=function(){
			const remote=require("electron").remote;;
			const Menu=remote.Menu;;
			const MenuItem=remote.MenuItem;
			var MenuClz;
			MenuClz=Menu;
			var MenuItemClz;
			MenuItemClz=MenuItem;
			var menus;
			menus=EditRenderManager._createMenuS;
			var i=0,len=0;
			len=menus.length;
			debugger;
			var scriptList;
			scriptList=[];
			var tDataO;
			for(i=0;i<len;i++){
				tDataO=menus[i];
				tDataO.name=tDataO.title;
				scriptList.push(tDataO);
			}
			scriptList.sort(MathUtil.sortByKey("name",false,false));
			len=scriptList.length;
			var tMenu;
			var mainMenu;
			mainMenu=new MenuClz({label:"New"});
			var menuList;
			menuList=[];
			var _menuClick;
			_menuClick=Utils.bind(this.onCreateNewMenu,this);
			var tFilePath;
			for(i=0;i<len;i++){
				tDataO=scriptList[i];
				tMenu=new MenuItemClz({label:tDataO.name,click:_menuClick,dataO:tDataO});
				mainMenu.append(tMenu);
			}
			tMenu=new MenuItemClz({label:"New",submenu:mainMenu});
			return tMenu;
		}

		__proto.onCreateNewMenu=function(dataO){
			dataO=dataO.dataO;
			Notice.notify("OPEN_ADD_COMMON_RES_DIALOG",dataO);
		}

		__proto.onCreateNewResBack=function(dataO){
			var folder;
			folder=this.currDirectory;
			var sourcePath;
			sourcePath=dataO.tplFile;
			var tarPath;
			tarPath=FileManager.getPath(folder,dataO.fileName+"."+dataO.extension);
			FileManager.copyFile(sourcePath,tarPath);
			this.refresh(null,true,false);
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

		/**增加目录*/
		__proto.addDirectory=function(name){
			if (!Boolean(name)){
				return Alert.show(Sys.lang("新建目录名称不能为空"));
			};
			var path=FileManager.getPath(this.currDirectory,name);
			if (this.hasFile(path)){
				return Alert.show(Sys.lang("已经此名字的目录了，请换个名字试试"),Sys.lang("命名重复"));
			}
			FileManager.createDirectory(path);
			this.refresh();
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
				case "新建目录":
					Notice.notify("open_adddir");
					break ;
				}
		}

		__proto.checkRename=function(){
			if (Boolean(this.resTree.selectedPath)){
				var fileName=this.resTree.selectedItem.path;
				RenameRes.instance.start(fileName);
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
				var clip=new Clip(SkinDefines.ResDragIcon,1,3);
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
			console.log("onResTreeRightMouseDown");
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
			if (e.target.parent==this.resTree.list.content && this.resTree.selectedItem){
				debugger;
				Notice.notify("openPAGE",[this.resTree.selectedItem.path]);
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


	/**添加目录
	*@author ww
	*/
	//class view.AddDirectory extends ui.deskplatform.AddDirectoryUI
	var AddDirectory=(function(_super){
		function AddDirectory(){AddDirectory.__super.call(this);;
		};

		__class(AddDirectory,'view.AddDirectory',_super);
		var __proto=AddDirectory.prototype;
		__proto.initListener=function(){
			Notice.listen("open_adddir",this,this.start);
		}

		__proto.start=function(){
			this.nameTxt.restrict=StyleConsts.fileNameRestrict;
			this.nameTxt.text="";
			this.popup();
			this.nameTxt.focus=true;
		}

		__proto.close=function(type){
			if (type=="sure"){
				if (this.nameTxt.text){
					laya.ui.Dialog.prototype.close.call(this,type);
					Notice.notify("adddir",[this.nameTxt.text]);
					}else {
					Alert.show(Sys.lang("目录名称不能为空"));
				}
				}else{
				laya.ui.Dialog.prototype.close.call(this,type);
			}
		}

		__getset(1,AddDirectory,'instance',function(){
			return AddDirectory._instance ? AddDirectory._instance :AddDirectory._instance=new AddDirectory();
		},ui.deskplatform.AddDirectoryUI._$SET_instance);

		AddDirectory._instance=null
		return AddDirectory;
	})(AddDirectoryUI)


	/**
	*
	*@author ww
	*@version 1.0
	*
	*@created 2017-10-23 下午8:59:35
	*/
	//class view.AddResCommomDialog extends ui.deskplatform.AddDirectoryUI
	var AddResCommomDialog=(function(_super){
		function AddResCommomDialog(){
			this.dataO=null;
			AddResCommomDialog.__super.call(this);
		}

		__class(AddResCommomDialog,'view.AddResCommomDialog',_super);
		var __proto=AddResCommomDialog.prototype;
		__proto.initListener=function(){
			Notice.listen("OPEN_ADD_COMMON_RES_DIALOG",this,this.start);
		}

		__proto.start=function(dataO){
			if(!dataO)return;
			this.dataO=dataO;
			this.titleTxt.text=Sys.lang("新建");
			this.nameTip.text=Sys.lang("名称：");
			this.nameTxt.text="";
			this.popup();
			this.nameTxt.focus=true;
		}

		__proto.close=function(type){
			if (type=="sure"){
				if (this.nameTxt.text){
					laya.ui.Dialog.prototype.close.call(this,type);
					this.dataO.fileName=this.nameTxt.text;
					Notice.notify("ADD_COMMON_RES",[this.dataO]);
					}else {
					Alert.show(Sys.lang("名称不能为空"));
				}
				}else{
				laya.ui.Dialog.prototype.close.call(this,type);
			}
		}

		__getset(1,AddResCommomDialog,'instance',function(){
			return AddResCommomDialog._instance ? AddResCommomDialog._instance :AddResCommomDialog._instance=new AddResCommomDialog();
		},ui.deskplatform.AddDirectoryUI._$SET_instance);

		AddResCommomDialog._instance=null
		return AddResCommomDialog;
	})(AddDirectoryUI)


	/**提示框
	*@author ww
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
				title=Sys.lang("提示");
			}
			Alert.instance.start(msg,title);
		}

		Alert._instance=null
		return Alert;
	})(AlertUI)


	/**确认框
	*@author ww
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
			if(!okName)okName=Sys.lang("确定");
			if(!cancelName)cancelName=Sys.lang("取消");
			Confirm.instance.okBtn.label=okName;
			Confirm.instance.cancelBtn.label=cancelName;
			Confirm.instance.start(msg,title,handler,args);
		}

		Confirm._instance=null
		return Confirm;
	})(ConfirmUI)


	/**重命名资源
	*@author ww
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
					if(FileTools.isPathSame(this.nameTxt.text,this.resLbl.text)){
						Alert.show(/*no*/this.Sys.lang("文件名不能相同！！"));
						return;
					}
					laya.ui.Dialog.prototype.close.call(this,type);
					}else{
					Alert.show(/*no*/this.Sys.lang("文件名不合法"));
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
