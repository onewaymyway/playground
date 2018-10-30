
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var Box=laya.ui.Box,CMDShell=nodetools.devices.CMDShell,ContextMenu$1=electrontools.menus.ContextMenu;
	var Device=nodetools.devices.Device,FileTools=nodetools.devices.FileTools,Handler=laya.utils.Handler,Label=laya.ui.Label;
	var List=laya.ui.List,Loader=laya.net.Loader,OSInfo=nodetools.devices.OSInfo,Paths=nodetools.devices.Paths;
	var PythonTools=nodetools.devices.PythonTools,Stage=laya.display.Stage,Styles=laya.ui.Styles,SystemDragOverManager=electrontools.drags.SystemDragOverManager;
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
			MainViewItem.__super.call(this);
		}

		__class(MainViewItem,'view.MainViewItem',_super);
		return MainViewItem;
	})(MainViewItemUI)


	/**
	*...
	*@author ZW
	*/
	//class view.MainView extends ui.deskplatform.MainViewUI
	var MainView=(function(_super){
		function MainView(){
			MainView.__super.call(this);
		}

		__class(MainView,'view.MainView',_super);
		return MainView;
	})(MainViewUI)



	new DeskPlatform();

})(window,document,Laya);
