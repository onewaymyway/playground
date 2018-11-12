package view {

	
	import configs.StyleConsts;
	import electrontools.drags.DragEvent;
	import electrontools.drags.DragManager;
	import electrontools.menus.ContextMenu;
	import electrontools.MessageManager;
	import extendui.FocusManager;
	import extendui.KeyManager;
	import extendui.ui.ListEx;
	import extendui.ui.NodeTree;
	import extendui.ui.TreeEx;
	import laya.debug.tools.DisControlTool;
	import laya.display.Node;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.events.Keyboard;
	import laya.maths.Point;
	import laya.resource.Texture;
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Clip;
	import laya.ui.Component;
	import laya.ui.Image;
	import laya.ui.Label;
	import laya.utils.Handler;
	import laya.utils.Utils;
	import nodetools.devices.File;
	import nodetools.devices.FileManager;
	import nodetools.devices.FileTools;
	import nodetools.devices.Sys;
	import nodetools.devices.SystemSetting;
	import platform.interfaces.PlatformEvents;
	import platform.interfaces.SkinDefines;
	import platform.tools.Notice;
	import ui.deskplatform.ResPanelUI;
	
	
	/**资源面板
	 * @author yung
	 */
	public class ResPanel extends ResPanelUI {
		private static var _instance:ResPanel;
		
		public static function get instance():ResPanel {
			return _instance ? _instance : _instance = new ResPanel();
		}
		//public var title:String = "资源";
		private var _resPath:String;
		private var _refreshComplete:Handler
		private var _mouseIndex:int;
		private var _dirWatcherWrap:*;
		public function ResPanel() {
//			tabChildren = tabEnabled = false
			initPanel();
			resTree.spaceLeft=NodeTree.TreeSpaceLeft;
			resTree.mList.onlySameParentSelect=true;

		}
		
		private function onDirFileChanged():void
		{
			refresh(null,false,false);
		}
		override public function get visible():Boolean {
			return super.visible;
		}
		
		override public function set visible(value:Boolean):void {
			super.visible = value;
		}
		
		public function initListener():void
		{

		}
		/**刷新资源树*/
		public function init(resPath:String, complete:Handler = null):void {
			var force:Boolean;
			force=_resPath==resPath;
			_resPath = resPath;
			refresh(complete,force);
		}
		private function onTreeMouse(e:Event, index:int):void
		{
			var cell:Box = resTree.list.getCell(index);
			if(!cell) return;
			var label:Label = cell.getChildByName("label") as Label;

				if (e.type == Event.MOUSE_OVER)
				{
					
					label.color=StyleConsts.TreeSelectColor;
				}else
					if (e.type == Event.MOUSE_OUT)
					{
						var item:Object = cell.dataSource;
						if (!item) return;
						label.color=item.hasChild?StyleConsts.TreeFolderColor:StyleConsts.TreeItemColor;
					}
		}
		public function selecteByFile(file:String):void
		{
			var arr:Array;
			arr=resTree.source;

			parseOpen(arr,file.split("/"),null,true);
			resTree.fresh();
			
		}
		private function parseOpen(tree:Array,arr:Array,parentPath:String=null,flashSelected:Boolean=false):void
		{
			if(arr.length<1) return;
			var tStr:String=arr.shift();
			var i:int,len:int;
			len=tree.length;
			var tItem:Object;
			if(!parentPath)
			{
				parentPath=_resPath;
			}
			var tPath:String;
			tPath=FileManager.getPath(parentPath,tStr);
			tPath=FileManager.adptToCommonUrl(tPath);
			for(i=0;i<len;i++)
			{
				tItem=tree[i];
				if(tItem.label==tStr)
				if(FileManager.adptToCommonUrl(tItem.path)==tPath)
				{
					if(arr.length>0)
					{
						tItem.isOpen = true;
						resTree.fresh();
						parseOpen(tItem.childs,arr,tPath,flashSelected);
					}else
					{
						resTree.selectedItem=tItem;
						//debugger;
						if(flashSelected){
							if(resTree.mList.selection)
							FocusManager.flashItem(resTree.mList.selection);
						}
					}
					
					return;
				}
			}
		}
		public var isRefreshing:Boolean=false;
		private var _withTip:Boolean=true;
		/**刷新*/
		public function refresh(refreshComplete:Handler = null,force:Boolean=false,withTip:Boolean=true):void {

			if(isRefreshing&&!force) return;
			_refreshComplete = refreshComplete;

			
			isRefreshing=true;
			_withTip=withTip;
			createComplete();
			//createComplete(null);
		}
		
		private function createComplete():void {
			//resTree.xml = xml;
//			trace("refreshRes complete");
			isRefreshing=false;
			var arr:Array;
			arr=FileTools.getFileTreeArr(SystemSetting.assetsPath);
			var i:int,len:int;

			resTree.array = arr;
			onFliterTxtChange(null);

			onResTreeChange(null);

			if (_refreshComplete != null) {
				_refreshComplete.run();
			} else {
				if(this.displayedInStage&&_withTip)
				MessageManager.I.show(Sys.lang("资源刷新完毕"));
			}
		}
		private var _menu:ContextMenu;
		private var _mutiMenu:ContextMenu;
		private var _menuDir:ContextMenu;
		private function initPanel():void {
			resTree.array = [];

			resTree.on(Event.DOUBLE_CLICK, this, onResTreeDoubleClick);

			resTree.on(Event.RIGHT_CLICK, this,onResTreeRightMouseDown);
			resTree.mouseHandler = new Handler(this,onResTreeMouse);
			var menu:ContextMenu = ContextMenu.createMenu("设置默认属性", "打开所在目录","查找引用","替换选中对象", "", "重命名", "删除");
			menu.on(Event.SELECT, this,onEmunSelect);
			_menu=menu;
			
//			_menuDir=ContextMenu.createMenu("设置默认属性", "打开所在目录","重新打包", "", "重命名", "删除");
			_menuDir=ContextMenu.createMenu("设置默认属性", "打开所在目录", "", "重命名", "删除");
			_menuDir.on(Event.SELECT, this,onEmunSelect);
			_mutiMenu= ContextMenu.createMenu("设置默认属性","删除");
			_mutiMenu.on(Event.SELECT, this,onEmunSelect);
		
			//筛选
			fliterTxt.on(Event.INPUT,this, onFliterTxtChange);
			fliterTxt.color=StyleConsts.TextInputColor;
			//快捷工具栏
			opBox.on(Event.CLICK,this, onOpBoxClick);
			//切换预览
			resTree.on(Event.CHANGE, this,onResTreeChange);
			//渲染
			resTree.renderHandler = new Handler(this,resTreeRender);

			//资源快捷键
			resTree.on(Event.KEY_DOWN,this, onResTreeKeyDown);
			//处理资源拖动移动
			on(DragEvent.DRAG_DROP,this, onResTreeDragDrop);
			
//			fliterTxt.restrict = "^"
			
			//页面快捷键
			resTree.on(Event.KEY_DOWN, this, onTreeKeyDown);
			
			//点击取消页面选择
			on(Event.CLICK, this, onClick);
			clearSearchBtn.on(Event.MOUSE_DOWN,this,onClearSearch);
		}
		
		private function onClearSearch():void
		{
			if(fliterTxt.text!="")
			{
				fliterTxt.text="";
				onFliterTxtChange(null);
			}
		}
		private function onClick(e:Event):void
		{
			var target:Node = e.target as Node;
			if (!DisControlTool.isChildE(this, target)||target==resTree.mList.content)
			{
//				resTree.selectedIndex = -1;
				resTree.mList.clearSelect(true);
			}
			
		}
		
		private function systemDrag(data:Object,dir:String):void
		{
//			trace("systemDrag:",data,dir);
			var files:Array;
			files=data.files;
			var i:int,len:int=files.length;
			for(i=0;i<len;i++)
			{
				var tFile:String;
				tFile=files[i].path;
				var fileName:String;
				fileName=files[i].name;
				FileTools.copyE(tFile,FileManager.getPath(dir,fileName));
			}
			refresh();
		}
		private function onResTreeDragDrop(e:DragEvent):void {
			
//			trace("onResTreeDragDrop", e);
			if (!e.data) return;
			if (!(e.data.type == DragEvent.Res || e.data.type == DragEvent.ResDir||e.data.type==DragEvent.MULTI_RESFILE||e.data.type==DragEvent.DisplayDrag||e.data.type==DragEvent.SystemDrag)) return;
			
			
			var targetFile:File;
			
			debugger;
			var hitList:Array;
//			hitList = DisControlTool.getObjectsUnderGlobalPoint(resTree);
			hitList=e.hitList;
//			trace("hitList:",hitList);
			var i:int, len:int;
			len = hitList.length;
			for (i = 0; i < len; i++)
			{
				if (hitList[i].dataSource && hitList[i].dataSource.path)
				{
					targetFile = new File(hitList[i].dataSource.path);
//					trace("targetFile:",hitList[i].dataSource.path);
					break;
				}
			}
			var targetDir:File;
			if (!targetFile)
			{
				targetFile = targetDir = new File(_resPath);
			}else
			{
				targetDir=targetFile.isDirectory ? targetFile : targetFile.parent;
			}
			

			if(e.data.type==DragEvent.SystemDrag)
			{
				
				systemDrag(e.data,targetDir.nativePath);
				return;
			}
			//return;
			
			
//			if(targetDir.nativePath.indexOf(oldFile.nativePath)>=0)
//			{
//				return;
//			}
			var selectList:Array;
			selectList=resTree.mList.selectItems;
			
			len=selectList.length;
			var fileList:Array;
			fileList=[];
			var tFile:String;
			var tarForder:String;
			tarForder=FileManager.adptToCommonUrl(targetDir.nativePath);
			for(i=0;i<len;i++)
			{
				tFile=selectList[i].path;
				fileList.push(tFile);
				if(FileTools.getFolder(tFile)==tarForder)
				{
					
					return;
				}
				if(targetDir.nativePath.indexOf(tFile)>=0)
				{
					MessageManager.I.show(Sys.lang("不能把文件拖动到子文件夹中"));
					return;
				}
			}
			if(!fileList||fileList.length<1) return;
			if(fileList.length==1)
			{
				
			}
			resTree.mList.clearSelect();
			moveFileList(fileList, targetDir.nativePath);
			

			
		}
		
		/**移动资源*/
		public function move(oldFile:File, newFile:File, isUpdate:Boolean):void {
			oldFile.moveTo(newFile.nativePath);
			refresh();
		}
		private function moveByFilePath(oldPath:String,tarDir:String,isUpdate:Boolean=true):void
		{
			var oldFile:File=new File(oldPath);
			var newFile:File = new File(FileManager.getPath(tarDir, oldFile.name));
			move(oldFile,newFile,isUpdate);
		}
		public function moveFileList(fileList:Array,tarDir:String,isUpdate:Boolean=true):void
		{
			var i:int,len:int;
			len=fileList.length;
			for(i=0;i<len;i++)
			{
				moveByFilePath(fileList[i],tarDir,isUpdate);
			}
		}
		/**快捷键*/
		private function onResTreeKeyDown(e:Event):void {
			if (e.keyCode == Keyboard.DELETE||e.keyCode == Keyboard.MacDELETE) {
				deleteRes();
			}
			if (e.keyCode == Keyboard.F2) {
				checkRename();
			}
			//e.stopPropagation();
		}
		
		/**删除资源*/
		private function deleteRes():void {
			if(resTree.mList.selectItems&&resTree.mList.selectItems.length>1)
			{
				Confirm.show(Sys.lang("确定要删除所选的文件吗？(删除后可以在回收站里找回)"), Sys.lang("确定删除资源吗"), Utils.bind(delSelectItems,this));
				return;
			}
			if (Boolean(resTree.selectedPath)) {
				var filePath:String = FileManager.getRelativePath(_resPath, resTree.selectedPath);
				var type:String = resTree.selectedItem.isDirectory ? Sys.lang("目录" ): Sys.lang("资源");
				Confirm.show(Sys.lang("确定要删除{0}({1})吗？(删除后可以在回收站里找回)", type, filePath), Sys.lang("确定删除资源吗"), Utils.bind(delBack,this));
			}
		}
		
		/**处理资源删除*/
		private function delBack(sure:Boolean):void {
			if (sure) {
				//删除原有资源
				FileManager.removeFile(resTree.selectedPath);
				//刷新tree
				refresh();
			}
			Laya.stage.focus = resTree;
		}
		private function delSelectItems(sure:Boolean):void
		{
			if (sure) {
				//删除原有资源
				var selectList:Array;
				selectList=resTree.mList.plainSelectItems;
				var i:int,len:int;
				len=selectList.length;
				for(i=0;i<len;i++)
				{
					FileManager.removeFile(selectList[i].path);		
				}
				//刷新tree
				resTree.mList.clearSelect();
				refresh();
			}
			Laya.stage.focus = resTree;
		}
		private function onResTreeChange(e:Event):void {
			//return;
			cleanViewer();
//			trace("onResTreeChange");
			if (resTree.selectedItem && !resTree.selectedItem.isDirectory) {
				var asset:String = resTree.selectedItem.path;
			
				var extension:String;
				extension = FileTools.getExtensionName(asset);
				extension = extension.toLocaleLowerCase();
				if (extension != "jpg" && extension != "png") return;
			    var img:Image = new Image();
				img.visible = false;
				img.once(Event.LOADED,this, setResSize, [img]);
				var tImgPath:String;
				tImgPath=FileTools.getAbsPath(asset);
				var changeTime:String;
				changeTime=FileTools.getMTime(tImgPath).toString();
//				changeTime="123";
				img.skin =tImgPath+"?v="+changeTime;
				resViewer.addChild(img);
				
				
//				Laya.timer.once(200, this, setResSize, [img], true);
			}
		}
		
		/**设置资源大小*/
		private function setResSize(target:Sprite):void {
			var scale:Number = Math.min(resViewer.width / target.width, resViewer.height / target.height, 1);
			target.scaleX = target.scaleY = scale;
			target.x = (resViewer.width - scale*target.width) / 2;
			target.y = (resViewer.height - scale*target.height) / 2;
			sizeTxt.text=target.width +" x "+target.height;
			target.visible = true;
		}
		
		override public function set dataSource(value:*):void
		{
			// TODO Auto Generated method stub
			super.dataSource = value;
		}
		
		override protected function changeSize():void
		{
			// TODO Auto Generated method stub
			super.changeSize();
			if(resViewer&&resViewer.numChildren>0)
			{
				setResSize(resViewer.getChildAt(0) as Sprite);
			}
		}
		
		
		/**清理resViewer*/
		private function cleanViewer():void {
			sizeTxt.text="";
			for (var i:int = resViewer.numChildren - 1; i > -1; i--) {
				resViewer.removeChildAt(i).offAll(Event.RESIZE);
			}
		}
		
		private function onOpBoxClick(e:Event):void {
			var btn:Button = e.target as Button;
			if (btn) {
				switch (btn.name) {

					case "openDirBtn": 
						openCurrDirectory();
						break;
					case "refreshBtn": 
						refresh();
						break;
				}
			}
		}
		

		
		/**打开当前资源所在的文件夹*/
		private function openCurrDirectory():void {
			FileTools.openItem(currDirectory);
		}
		
		/**获取当前目录*/
		private function get currDirectory():String {
			
			var directory:String = _resPath;
			//trace("selectedItem:",pageTree.selectedItem );
			if (resTree.selectedItem != null)
			{
				var path:String = resTree.selectedItem.path;
				//trace("path:"+path);
				return FileTools.getFileDir(path);
			}
			return directory;
		}
		private function openCurrPath():void
		{
			var directory:String = _resPath;
			//trace("selectedItem:",pageTree.selectedItem );
			if (resTree.selectedItem != null)
			{
				var path:String = resTree.selectedItem.path;
				//trace("path:"+path);
				FileTools.showItemInFolder(path);
				return;
			}
			FileTools.openItem(directory);
			
			
		}
		private function onFliterTxtChange(e:Event):void {
			resTree.filter(fliterTxt.text);
		}
		
		private function onEmunSelect(name:String):void {			
			switch (name) {
				case "设置默认属性": 

					break;
				case "打开所在目录": 
					openCurrPath();
					break;
				case "重命名": 
					checkRename();
					break;
				case "删除": 
					deleteRes();
					break;
				
			}
		}


		private function checkRename():void {
			if (Boolean(resTree.selectedPath)) {
				var fileName:String = resTree.selectedItem.path;
//				fileName=FileTools.getFileName(fileName);
				RenameRes.instance.start(fileName);
			}
		}
		
		public function rename(prePath:String,newName:String, isUpdate:Boolean):void {
			if (!Boolean(newName)) {
				return Alert.show(Sys.lang("新名称不能为空"));
			}
			var oldFile:File = new File(resTree.selectedPath);
			if (!oldFile.isDirectory) {
				newName += "." + oldFile.extension;
			}
			var oldName:String = resTree.selectedItem.label;
			if (oldFile.name != newName) {
				var oldPath:String = oldFile.nativePath;
				var newPath:String = (oldPath + "##").replace(oldFile.name + "##", newName);
				if (hasFile(newPath)) {
					Alert.show(Sys.lang("已经有同名字的资源了，请换个名字试试"), Sys.lang("命名重复"));
				} else {
					//重命名文件
					FileManager.rename(oldPath, newPath);

					//刷新资源列表
					refresh();
				}
			}
		}
		


		
		/**是否已经存在同路径文件*/
		private function hasFile(path:String):Boolean {
			var arr:Array = resTree.source;
			for each (var item:Object in arr) {
				//trace(item.path == path, item.path, path);
				if (item.path == path) {					
					return true;
				}
			}
			return false;
		}

		private function getSelectFiles():Array
		{
			var i:int,len:int;
			var selectList:Array;
			selectList=resTree.mList.selectItems;
			
			len=selectList.length;
			var fileList:Array;
			fileList=[];
			var tFile:String;
			for(i=0;i<len;i++)
			{
				tFile=selectList[i].path;
				fileList.push(tFile);

			}
			return fileList;
		}
		private function onResTreeMouse(e:Event, index:int):void {
			//return;
			if (e.type == Event.MOUSE_DOWN) {
				Laya.stage.focus = resTree;
				_mouseIndex = index;
				var clip:Clip = new Clip(SkinDefines.ResDragIcon, 1, 3);
				clip.index = 2;				
				if(resTree.mList.selectItems&&resTree.mList.selectItems.length>1)
				{
					DragManager.I.doDrag(e.currentTarget as Sprite, clip, {type: DragEvent.MULTI_RESFILE,fileList:getSelectFiles()}, DragManager.dragOffset);
					return;
				}
				var asset:String = resTree.array[index].path;
				if (resTree.array[index].isDirectory) {
					DragManager.I.doDrag(e.currentTarget as Sprite, clip, {type: DragEvent.ResDir,asset: asset}, DragManager.dragOffset);
				}else {

					var dragType:String;
					dragType=DragEvent.Res;
					if(compType==DragEvent.Props)
					{
						dragType=DragEvent.Props;
					}
					DragManager.I.doDrag(e.currentTarget as Sprite, clip, {type: dragType, asset: asset}, DragManager.dragOffset);
				}
			}
			var cell:Box = resTree.list.getCell(index);
			var label:Label = cell.getChildByName("label") as Label;
			
			if (e.type == Event.MOUSE_OVER)
			{
				TreeEx.onItemCellMouseOver(index,cell,resTree);
				label.color=StyleConsts.TreeSelectColor;
			}else
				if (e.type == Event.MOUSE_OUT)
				{
					var item:Object = cell.dataSource;
					if (!item) return;
					label.color=item.hasChild?StyleConsts.TreeFolderColor:StyleConsts.TreeItemColor;
				}
		}
		
		private function onResTreeRightMouseDown(e:Event):void {
			if(resTree.mList.selectItems&&resTree.mList.selectItems.length>1)
			{
				_mutiMenu.show();
				return;
			}
			var comp:Component = e.target as Component;
			if (comp && comp.dataSource) {
				resTree.selectedItem = comp.dataSource;
			}
			if(resTree.selectedPath&&FileTools.isDirectory(resTree.selectedPath))
			{
				_menuDir.show();
				return;
			}

			_menu.show();
		}
		
		private function onResTreeDoubleClick(e:Event):void {
//			trace("onResTreeDoubleClick");
			if (e.target.parent == resTree.list.content && resTree.selectedItem)
			{
				debugger;
				Notice.notify(PlatformEvents.OPEN_PAGE, [resTree.selectedItem.path]);
			}
		}
		/**页面快捷键*/
		private function onTreeKeyDown(e:Event):void
		{
			//trace("onTreeKeyDown:", e, e.keyCode);
			if(KeyManager.isABC(e.keyCode)&&!KeyManager.I.isCommandKeyDown)
			{
				ListEx.dealAbcKey(e.keyCode,resTree.list);
			}
			switch(e.keyCode)
			{
				case Keyboard.DELETE:
				case Keyboard.MacDELETE:
//					trace("key action deletePage");
//				    deletePage();
					break;
				case Keyboard.F2:
//					trace("key action checkRename");
				    checkRename();
					break;
				case Keyboard.LEFT:
//					trace("key action LEFT");
				    resTree.setItemState(resTree.list.selectedIndex, false);
					break;
				case Keyboard.RIGHT:
//					trace("key action RIGHT");
				    resTree.setItemState(resTree.list.selectedIndex, true);
					break;
				case Keyboard.UP:
//					trace("key action UP");
					 if (resTree.list.selectedIndex > 0)
					 {
						  resTree.list.selectedIndex--;
						  //resTree.list.scrollTo();
					 }
				    
					break;
				case Keyboard.DOWN:
//					trace("key action DOWN");
					if (resTree.list.selectedIndex < resTree.list.length - 1)
					{
						resTree.list.selectedIndex++;
						//resTree.list.scrollTo();
					}
				     
					 
					break;
			}
		}
		/**属性更改后，属性列表*/
		public function refreshProp():void {
			//resTree.xml = resTree.xml;
			resTree.array = resTree.source;
		}

		
		private function resTreeRender(cell:Box, index:int):void {
			var item:Object = cell.dataSource;
//			trace("resTreeRender");
			var compStr:String;
			if (item) {
				var icon:Image = cell.getChildByName("icon") as Image;
				var isDirectory:Boolean = item.child || item.isDirectory;
				var label:Label = cell.getChildByName("label") as Label;
				icon.width=StyleConsts.DisplayIconWidth;
				icon.height=StyleConsts.DisplayIconHeight;

				if (isDirectory) {
//					icon.skin = "comp/folder.png";
					if(item.isOpen)
					{
						icon.skin = "view/folder_open.png";
					}else
					{
						icon.skin = "view/folder_close.png";
					}
					label.color=StyleConsts.TreeFolderColor;
					compStr=FileManager.adptToCommonUrl(FileManager.getResRelativePath(item.path));

				} else {
					
					label.text = item.label;
					
					compStr=FileManager.adptToCommonUrl(FileManager.getResRelativePath(item.path));


					label.color = StyleConsts.TreeItemColor;
					icon.skin = "view/ui.png";



				}
			}
		}
	}
}