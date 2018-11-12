package platform.layout
{
	import electrontools.DisTools;
	import electrontools.drags.DragEvent;
	import electrontools.drags.DragManager;
	import extendui.layout.RelativePos;
	import laya.debug.tools.ClassTool;
	import laya.debug.tools.DTrace;
	import laya.debug.tools.DisControlTool;
	import laya.debug.tools.IDTools;
	import laya.debug.tools.ObjectTools;
	import laya.debug.tools.Watcher;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	import laya.ui.Box;
	import laya.ui.Component;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	import laya.utils.Utils;
	import nodetools.devices.FileManager;
	import nodetools.devices.FileTools;
	import platform.editzone.EditZone;
	import platform.extenddisplay.IFrameSprite;
	import platform.interfaces.Paths;
	import platform.managers.CursorManager;
	import platform.managers.LayerManager;
	import platform.viewers.IFrameRenderItem;
	import view.ResPanel;
	
	/**
	 * 布局管理类
	 * @author ww
	 */
	public class LayoutRecManager
	{
		
		public function LayoutRecManager()
		{
		
		}
		private static var target:Component;
		/**
		 * 最边缘的拖动条
		 */
		public static const Side:int = 2;
		/**
		 * 垂直方向的拖动条
		 */
		public static const Vertical:int = 1;
		/**
		 * 水平方向的拖动条
		 */
		public static const Horizon:int = 0;
		
		public static function popLocked():Boolean
		{
			//return CodeViewManager.showed;
			return false;
		}
		
		protected static function onMouseDown(e:Event):void
		{
			target = e.currentTarget as Component;
			//target.startDrag();
			dragItem(target, target["type"]);
			LayerManager.stage.on(Event.MOUSE_UP, null, onMouseUp);
			LayerManager.stage.on(Event.MOUSE_MOVE, null, onMouseMove);
		}
		
		private static function dragItem(target:Sprite, type:int = 0):void
		{
			var option:Object = {};
			var area:Rectangle = new Rectangle();
			if (type == Horizon)
			{
				area = (target as LayoutDragBar).getDragArea();
			}
			else if (type == Vertical)
			{
				area = (target as LayoutDragBar).getDragArea();
			}
			else
			{
				return;
			}
			//trace("dragArea:", area);
			option.area = area;
			DisControlTool.setTop(target);
			//target.startDrag(option);
			target.startDrag(area,false,0,300,{useDlen:true});
		}
		
		protected static function onMouseUp(e:Event):void
		{
			LayerManager.stage.off(Event.MOUSE_UP, null, onMouseUp);
			LayerManager.stage.off(Event.MOUSE_MOVE, null, onMouseMove);
			doLayOut();
			target.stopDrag();
			target.left = Math.ceil(target.x);
			target.top = Math.ceil(target.y);
		}
		
		protected static function onMouseMove(e:Event):void
		{
			Laya.timer.callLater(this,updateTargetPosAndDoLayout);
//			target.left = Math.ceil(target.x);
//			target.top = Math.ceil(target.y);
//			doLayOut();
		}
		
		private static function updateTargetPosAndDoLayout():void
		{
			target.left = Math.ceil(target.x);
			target.top = Math.ceil(target.y);
			doLayOut();
		}
		
		
		private static function doLayOut():void
		{
						
			(target as LayoutDragBar).updates();
			//trace("doLayOut from LayoutRecManager");
		}
		private static var _ct:Box;
		
		public static var ctOffSetX:int=0;
		public static var ctOffSetY:int=0;
		
		public static function get containerBox():Box
		{
			return _ct;
		}
		public static function init():void
		{
			//return;
			_ct = new Box();
			_ct.mouseEnabled = true;
			_ct.name = "LayoutRecManager_Container";
			
			//_ct.left = 0;
			//_ct.right = 0;
			//_ct.top = 30;
			//_ct.bottom = 20;
			_ct.width = 800;
			_ct.height = 800;
			LayerManager.stage.addChild(_ct);
			//_ct.width = LayerManager.stage.width;
			//_ct.height = LayerManager.stage.height;
			LayerManager.stage.on(Event.RESIZE, null, resizeWork);
			_ct.on(DragEvent.DRAG_DROP, null, onDragDrop);
			

		}
		//public static var dToQuickTool:int=32;
		/**
		 * 处理舞台大小变化
		 * @param e
		 *
		 */
		private static function resizeWork(e:Event = null):void
		{
			_ct.x = ctOffSetX;
//			_ct.y = 57;
			_ct.y=ctOffSetY;
			
			Laya.timer.once(50,null,tryResizeSafe,null,true);
//			tryResizeNoScale();
			return;
			

		
		}
		
		private static function tryResizeSafe():void
		{
			try
			{
				tryResizeNoScale();
			}catch(e:*)
			{
				createDefault();
			}
			
		}
		public static var ctOffHeight:int=5;
		private static function scaleResize():void
		{
//			trace("scaleResize");
			var nW:Number = LayerManager.stage.width-ctOffSetX;
			var nH:Number = LayerManager.stage.height - 30+ctOffHeight;
			if ((nW * nH * _ct.width * _ct.height) != 0)
			{
				var scaleX:Number = nW / _ct.width;
				var scaleY:Number = nH / _ct.height;
				adptScales(scaleX, scaleY);
				
			}
			_ct.width = LayerManager.stage.width-ctOffSetX;
			_ct.height = LayerManager.stage.height - _ct.y+ctOffHeight;
			//adptAll();
			Laya.timer.once(100, null, adptAll);
			
			//MenuBar.instance.width = LayerManager.stage.width - 2;			
			//QuickTool.instance.width = LayerManager.stage.width - 2;
		}
		private static function tryResizeNoScale():void
		{
//			trace("tryResizeNoScale");
			var items:Array;
			items = DisControlTool.getAllChild(_ct);
			var i:int, len:int;
			len = items.length;
			var tRec:LayoutRec;
			var tRecHeight:int=0;
			var maxFree:LayoutRec;
			for (i = 0; i < len; i++)
			{
				tRec = items[i];
				if (tRec is LayoutRec)
				{
					if(tRec.sizeFree)
					{
						if(!maxFree||maxFree.height<tRec.height)
						{
							maxFree=tRec;
						}
					}
				}
				
			}
			tRec=maxFree;
			if(!tRec||!tRec.sizeFree)
			{
//				trace("no size Free rec try scale method");
				scaleResize();
				return;
			}else
			{
//				trace("find size free rec:",tRec);
			}
			
			var nW:Number = LayerManager.stage.width-ctOffSetX+3;
			var nH:Number = LayerManager.stage.height - _ct.y+ctOffHeight;
			var pW:Number=_ct.width;
			var pH:Number=_ct.height;
			var dW:Number;
			var dH:Number;
			dW=nW-pW;
			dH=nH-pH;
			if ((nW * nH *pW *pH) != 0)
			{

				if(dW+tRec.width<0)
				{
					trace("width not availeble");
					scaleResize();
					return;
				}
				if(dH+tRec.height<0)
				{
					trace("height not availeble");
					scaleResize();
					return;
				}
				
			}else
			{
				trace("wrong size");
				scaleResize();
				return;
			}
			var tDragBar:LayoutDragBar;
			var barList:Array;
			barList=[];
			var resizeStruct:ResizeRecStruct;
			resizeStruct=new ResizeRecStruct();
//			trace("resize");
			var workDragBar:LayoutDragBar;
			for (i = 0; i < len; i++)
			{
				tDragBar = items[i];
				if (tDragBar is LayoutDragBar)
				{
					tDragBar.walked=false;
                    if(tDragBar.cusorType==CursorManager.HResize)
					{
//						if(tDragBar.x>=tRec.x+tRec.width)
						if(tDragBar.x>=tRec.x+10)
						{
							barList.push(tDragBar);
//							tDragBar.left+=dW;
						}
						
					}
					if(tDragBar.type==Side)
					{
//						trace("workBar:",tDragBar);
						workDragBar=tDragBar;
						switch(tDragBar.getSideType())
						{
							case RelativePos.Right:
								resizeStruct.rightSide=tDragBar;
								break;
							case RelativePos.Left:
								resizeStruct.leftSide=tDragBar;
								break;
							case RelativePos.Up:
								resizeStruct.upSide=tDragBar;
								break;
							case RelativePos.Down:
								resizeStruct.downSide=tDragBar;
								break;
						}
					}
				}
				
			}
			resizeStruct.isRoot=true;
			resizeStruct.resizeItems=[];
			resizeStruct.tryMoveRight(dW);
//			if(workDragBar)
//			{
//				workDragBar.moveRightWork(dW);
//			}
			barList=[];
			for (i = 0; i < len; i++)
			{
				tDragBar = items[i];
				if (tDragBar is LayoutDragBar)
				{
					tDragBar.walked=false;
					if(tDragBar.cusorType==CursorManager.VResize)
					{
						if(tDragBar.y>=tRec.y+tRec.height||tDragBar.y+200>nH)
						{
							barList.push(tDragBar);
							tDragBar.top+=dH;
						}
						if(tDragBar.type==Side&&tDragBar.getSideType()==RelativePos.Down&&tDragBar.cusorType==CursorManager.VResize)
						{
//							trace("workBar:",tDragBar);
							workDragBar=tDragBar;
						}
					}
				}
				
			}
			if(workDragBar)
			{
//				workDragBar.moveDownWork(dH);
			}
			_ct.width=nW;
			_ct.height=nH;
			
			Laya.timer.once(100, null, adptAll);
			//MenuBar.instance.width = LayerManager.stage.width - 2;
			//QuickTool.instance.width = LayerManager.stage.width - 2;
//			adptAll();
		}
		/**
		 * 根据缩放调整对象的布局
		 * @param dis
		 * @param scaleX
		 * @param scaleY
		 *
		 */
		private static function adptDis(dis:Component, scaleX:Number, scaleY:Number):void
		{
			dis.left *= scaleX;
			dis.right *= scaleX;
			dis.top *= scaleY;
			dis.bottom *= scaleY;
		}
		
		/**
		 * 调整所有对象的缩放数据
		 * @param scaleX
		 * @param scaleY
		 *
		 */
		private static function adptScales(scaleX:Number, scaleY:Number):void
		{
			var items:Array;
			items = DisControlTool.getAllChild(_ct);
			var i:int, len:int;
			len = items.length;
			var tDragBar:LayoutDragBar;
			for (i = 0; i < len; i++)
			{
				tDragBar = items[i];
				if (tDragBar is LayoutDragBar)
				{
					adptDis(tDragBar, scaleX, scaleY);
				}
				
			}
		}
		
		public static function getAllDragBars(type:String):Array
		{
			var rst:Array;
			rst=[];
			var items:Array;
			items = DisControlTool.getAllChild(_ct);
			var i:int, len:int;
			len = items.length;
			var tDragBar:LayoutDragBar;
			for (i = 0; i < len; i++)
			{
				tDragBar = items[i];
				if (tDragBar is LayoutDragBar)
				{
					if(tDragBar.type==type)
					rst.push(tDragBar);
				}
				
			}
			return rst;
		}
		/**
		 *  调整全体的布局
		 *
		 */
		private static function adptAll():void
		{
			var items:Array;
			items = DisControlTool.getAllChild(_ct);
			var i:int, len:int;
			len = items.length;
			var tDragBar:LayoutDragBar;
			for (i = 0; i < len; i++)
			{
				tDragBar = items[i];
				if (tDragBar is LayoutDragBar)
				{
					tDragBar.updates();
				}
				
			}
		}
		
		/**
		 * 保存布局信息
		 *
		 */
		public static function saveLayoutInfo():void
		{
			var items:Array;
			items = DisControlTool.getAllChild(_ct);
			var i:int, len:int;
			len = items.length;
			for (i = 0; i < len; i++)
			{
				IDTools.idObj(items[i]);
				
			}
			var rst:Array = [];
			
			var tDis:Component;
			for (i = 0; i < len; i++)
			{
				tDis = items[i];
				if (tDis is LayoutDragBar)
				{
					rst.push(getInfoO(tDis));
				}
				else if (tDis is LayoutRec)
				{
					rst.push(saveRecInfo(tDis as LayoutRec));
				}
			}
//			trace("save rst:", rst);
			
			var saveO:Object;
			saveO = {};
			saveO.width = _ct.width;
			saveO.height = _ct.height;
			saveO.items = rst;
			FileManager.createTxtFile(FileManager.getDataPath(tLayoutFile), ObjectTools.getJsonString(saveO));
		}
		
		/**
		 * 根据类名显示尚未显示的面板
		 * @param className
		 *
		 */
		public static function showPanelByClassName(className:String):void
		{
			if(popLocked()) return;
			initClassToUIO();
			var tPanel:Box;
			tPanel = classToUIO[className];
			
			showPanelToStage(tPanel);
		}
		public static function showPanelToStage(tPanel:Box):void
		{
			if (!tPanel)
				return;
			if (isPanelInStage(tPanel))
				return;
			var rec:LayoutRec = new LayoutRec();
			
			if (tPanel.width > 0 && tPanel.height > 0 && 0)
			{
				rec.width = tPanel.width + 5;
				rec.height = tPanel.height + 20;
				
			}
			else
			{
				rec.width = tPanel["minWidth"]?  tPanel["minWidth"]:200;
				if(rec.width<200) rec.width=200;
				rec.height = 300;
			}
			addPanelToRec(tPanel, rec);
			DisTools.showToCenter(rec, LayerManager.stage);
		}
		public static function removePanel(tPanel:Box):void
		{
			var rec:LayoutRec;
			rec=findPanelRec(tPanel);
			if(rec)
			{
				rec.removeUI(tPanel,true);
			}
		}
		/**
		 * 判断面板是否已经在舞台上
		 * @param panel
		 * @return
		 *
		 */
		public static function isPanelInStage(panel:Sprite):Boolean
		{
			var i:int, len:int;
			var childs:Array;
			
			var layouts:Array;
			layouts = [];
			childs = DisControlTool.getAllChild(_ct);
			len = childs.length;
			for (i = 0; i < len; i++)
			{
				if (childs[i] is LayoutRec)
				{
					ObjectTools.concatArr(layouts, childs[i].getUIs());
				}
			}
			childs = DisControlTool.getAllChild(LayerManager.stage);
			len = childs.length;
			for (i = 0; i < len; i++)
			{
				if (childs[i] is LayoutRec)
				{
					ObjectTools.concatArr(layouts, childs[i].getUIs());
				}
			}
			
			len = layouts.length;
			for (i = 0; i < len; i++)
			{
				if (layouts[i] == panel)
					return true;
			}
			return false;
		}
		public static function findPanelRec(panel:Sprite):LayoutRec
		{
			var i:int, len:int;
			var childs:Array;
			
			var layouts:Array;
			layouts = [];
			childs = DisControlTool.getAllChild(_ct);
			len = childs.length;
			for (i = 0; i < len; i++)
			{
				if (childs[i] is LayoutRec)
				{
					if(isPanelInRec(panel,childs[i]))
					{
						return childs[i];
					}
				}
			}
			childs = DisControlTool.getAllChild(LayerManager.stage);
			len = childs.length;
			for (i = 0; i < len; i++)
			{
				if (childs[i] is LayoutRec)
				{
					if(isPanelInRec(panel,childs[i]))
					{
						return childs[i];
					}
				}
			}
			
			return null;
		}
		private static function isPanelInRec(panel:Sprite,rec:LayoutRec):Boolean
		{
			var layouts:Array;
			layouts=rec.getUIs();
			if(!layouts) return false;
		    return layouts.indexOf(panel)>=0;
		}
		/**
		 * 布局类表
		 */
		private static const itemClassO:Object = {"LayoutDragBar": LayoutDragBar, "LayoutRec": LayoutRec};
		/**
		 * 参与布局的面板表
		 */
		private static var classToUIO:Object={};
		private static var _classInited:Boolean=false;
		
		private static function initClassToUIO():void
		{
			if (!_classInited)
			{
				_classInited=true;
//				classToUIO = {};
				classToUIO["ResPanel"] = ResPanel.instance;

			}
		}
		
		public static function regLayoutPanel(name:String,panel:*):void
		{
			classToUIO[name] = panel;
		}
		private static var _layoutFile:String=null;
		public static function get tLayoutFile():String
		{
			return _layoutFile?_layoutFile:Paths.LayoutFile_Default;
		}

		/**
		 * 根据配置文件恢复布局
		 *
		 */
		public static function recoverLayoutInfo(layoutFile:String=Paths.LayoutFile_Default,force:Boolean=false,isDebug:Boolean=false):void
		{
//			trace("recoverLayoutInfo:",layoutFile);
			if((!force)&&(_layoutFile==layoutFile)) return;
			if(_layoutFile)
			{
				saveLayoutInfo();
			}
			clearAll();
			initClassToUIO();
			_layoutFile=layoutFile;
			var path:String;
			path = FileManager.getDataPath(tLayoutFile);
			if (!FileTools.exist(path))
			{
				createDefault();
				return;
			}
			layoutByLayoutFile(path);

		
		}
		public static function layoutByLayoutFile(path:String):void
		{
			var layoutO:Object;
			layoutO = ObjectTools.getObj(FileManager.readTxtFile(path));
			//trace("layoutO:", layoutO);
			_ct.width = layoutO.width;
			_ct.height = layoutO.height;
			var itemList:Array;
			itemList = layoutO.items;
			var i:int, len:int;
			len = itemList.length;
			var tO:Object;
			var tDis:*;
			var tClass:Class;
			var objDic:Object = {};
			
			//恢复布局对象
			for (i = 0; i < len; i++)
			{
				tO = itemList[i];
				tClass = itemClassO[tO.className];
				if (!tClass)
					continue;
				if (tClass == LayoutDragBar)
				{
					var type:String = tO.width < tO.height ? "R" : "T";
					tDis = getADragBar(type);
				}
				else
				{
					tDis = new tClass();
				}
				
				ObjectTools.copyValueByArr(tDis, tO, sizeInfos);
				//IDTools.setObjID(tDis, tO.id);
				objDic[tO.id] = tDis;
				if (tDis is LayoutDragBar)
				{
					//tDis.on(Event.MOUSE_DOWN, null, onMouseDown);
				}
				if (tDis is LayoutRec)
				{
					recoverLayoutRec(tDis as LayoutRec, tO);
				}
				_ct.addChild(tDis);
			}
			
			//重建对象之间的关系
			var key:String;
			var tar:Object;
			var relativeO:Object;
			for (i = 0; i < len; i++)
			{
				//trace("try rebuild relation");
				tO = itemList[i];
				tDis = objDic[tO.id];
				relativeO = tO.relativeO;
				if (relativeO)
				{
					//trace("relativeO:", relativeO);
					for (key in relativeO)
					{
						tar = objDic[relativeO[key]];
						if (tar)
						{
							//trace("addRelative:", tDis, tar, key);
							RelativePos.addRelative(tDis as Component, tar as LayoutDragBar, key);
						}
						else
						{
							trace("tar not find");
						}
					}
				}
				else
				{
					trace("relativeO not find");
				}
				ObjectTools.copyValueByArr(tDis, tO, sizeInfos);
			}
			//trace("objDic:", objDic);
			adptAll();
			resizeWork();
		}
		/**
		 * 重建布局框中的内容
		 * @param rec
		 * @param data
		 *
		 */
		private static function recoverLayoutRec(rec:LayoutRec, data:Object):void
		{
			var i:int, len:int;
			var uiList:Array;
			uiList = data.uiList;
			len = uiList.length;
			var tUI:Box;
			for (i = 0; i < len; i++)
			{
				tUI = classToUIO[uiList[i]];
				if (tUI)
				{
					addPanelToRec(tUI, rec);
				}
			}
			if(parseInt(data.select)>0)
			{
				rec.tab.selectedIndex=data.select;
			}else
			{
				rec.tab.selectedIndex=0;
			}
			if(data.disMode)
			{
				rec.disMode=data.disMode;
			}
			if(data.preMoveLen)
			{
				rec.preMoveLen=data.preMoveLen;
			}
			if(rec.tab.items.length<1)
			{
				Laya.timer.once(1000,null,removeRec,[rec]);
			}
			
		}
		
		private function saveDragBarInfo(dragBar:LayoutDragBar):void
		{
		
		}
		
		/**
		 * 保存布局框中的数据
		 * @param rec
		 * @return
		 *
		 */
		private static function saveRecInfo(rec:LayoutRec):Object
		{
//			trace("saveRecInfo");
			var rst:Object;
			rst = getInfoO(rec);
			var uiList:Array;
			var i:int, len:int;
			uiList = rec.tab.items as Array;
			var saveList:Array;
			len = uiList.length;
			var tab:LayoutTab;
			saveList = [];
			for (i = 0; i < len; i++)
			{
				//trace(uiList[i]);
				tab = uiList[i];
				saveList.push(ClassTool.getClassName(tab.ui));
			}
			rst.disMode=rec.disMode;
			rst.preMoveLen=rec.preMoveLen;
			rst.select=rec.tab.selectedIndex;
			rst.uiList = saveList;
			return rst;
		}
		private static const sizeInfos:Array = ["height", "width", "left", "right", "bottom", "top", "x", "y", "type"];
		
		private static function getInfoO(obj:Component):Object
		{
			var rst:Object;
			rst = {};
			ObjectTools.copyValueByArr(rst, obj, sizeInfos);
			rst.className = ClassTool.getClassName(obj);
			rst.id = IDTools.getObjID(obj);
			rst.relativeO = RelativePos.saveRelative(obj);
			
			return rst;
		}
		
		/**
		 * 处理拖动逻辑
		 * @param e
		 *
		 */
		private static function onDragDrop(e:DragEvent):void
		{
//			trace("onDragDrop", e);
//			trace("drag target:", e.target);
			
			if (!e.data)
				return;
			var tType:String;
			tType = e.data.type;
//			trace("dropType:", tType);
			if (tType != "LayoutRec" && tType != "LayoutTab")
				return;
			
			var src:LayoutRec;
			src = e.data.target;
			if (!src)
				return;
			
			var hitList:Array;
			hitList = e.hitList;
			var i:int, len:int;
			len = hitList.length;
			
			var tTarget:LayoutRec;
			if (hitList.indexOf(src) >= 0)
			{
				//如果是拖动到自己布局框中
				tTarget = src;
				if (tType != "LayoutTab")
				{
					//拖动的是标签页
					if (tType == "LayoutRec")
					{
						popRec(src);
						return;
					}
				}
			}
			else
			{
				//拖动到其他布局框中，查找目标布局框
				for (i = 0; i < len; i++)
				{
					tTarget = hitList[i];
					if (tTarget is LayoutRec)
					{
						if(RelativePos.getDisMouseRelativePos(tTarget)!=RelativePos.Out)
						{
							break;
						}
					}
						
				}
			}
			
			if (!(tTarget is LayoutRec))
				return;
			
			//如果目标布局框是悬浮的，拒绝拖放
			if(tTarget.parent!=_ct) return;
			if (src != tTarget || tType == "LayoutTab")
			{
				var posType:String;
				posType = RelativePos.getDisMouseRelativePos(tTarget);
				
				//var pos:Point;
				//pos = DisControlTool.getMousePoint(tTarget);
				
				
				if (tType == "LayoutRec")
				{
					//当前是布局框拖动到布局框
					switch (posType)
					{
						
						case RelativePos.Up: 
							removeRec(src);
							insetToBarV(RelativePos.getBar(tTarget, RelativePos.Up), src);
							break;
						case RelativePos.Down: 
							removeRec(src);
							insertV(tTarget, src);
							break;
						case RelativePos.Left: 
							removeRec(src);
							insertL(tTarget, src);
							break;
						case RelativePos.Center: 
							if(src.parent==LayerManager.stage) return;
						case RelativePos.Right: 
							
							removeRec(src);
							insert(tTarget, src);
							break;
						default: 
							return;
					}
				}
				else if (tType == "LayoutTab")
				{
					//当前是标签页拖动到布局框
					var tTab:LayoutTab;
					tTab = e.dragInitiator;
					var tRec:LayoutRec;
					tRec = tTarget;
					
					if (src == tTarget)
					{
						//拖动到自己的布局框内
						
						if (src.tab.items.length <= 1)
						{
							popRec(src);
							return;
						}
						else
						{
							if (posType == RelativePos.Center)
							{
								src.removeTab(tTab);
								tRec = new LayoutRec();
								tRec.pos(src.x,src.y);
								src.parent.addChild(tRec);
								tRec.addTab(tTab);
								popRec(tRec);
								return;
							}
							
						}
						
					}
					
					switch (posType)
					{
						
						case RelativePos.Down: 
							src.removeTab(tTab);
							tRec = new LayoutRec();
							tRec.addTab(tTab);
							insertV(tTarget, tRec);
							break;
						
						case RelativePos.Right: 
							src.removeTab(tTab);
							tRec = new LayoutRec();
							tRec.addTab(tTab);
							insert(tTarget, tRec);
							break;
						case RelativePos.Left: 
							src.removeTab(tTab);
							tRec = new LayoutRec();
							tRec.addTab(tTab);
							insertL(tTarget, tRec);
							break;
						case RelativePos.Center: 
						case RelativePos.Up: 
							if(!tRec.canAddTab) return;
							if (src != tRec)
							{
								src.removeTab(tTab);
								tRec.addTab(tTab);
							}
							else
							{
								return;
								src.removeTab(tTab);
								tRec = new LayoutRec();
								tRec.addTab(tTab);
								popRec(tRec);
							}
							break;
						default: 
							return;
					}
					
					//如果布局框中无标签页则移除
					if (src.tab.items.length < 1)
					{
						removeRec(src);
					}
					
				}
				
			}
		}
		
		public static function test():void
		{
			var _leftBar:LayoutDragBar;
			var _rightBar:LayoutDragBar;
			var _upBar:LayoutDragBar;
			var _downBar:LayoutDragBar;
			
			_leftBar = getADragBar("R");
			_leftBar.width = DragBarWidth;
			_leftBar.left = 0;
			_leftBar.top = 0;
			_leftBar.bottom = 0;
			_leftBar.type = Side;
			_ct.addChild(_leftBar);
			
			_rightBar = getADragBar("R");
			_rightBar.width = DragBarWidth;
			_rightBar.right = 0;
			_rightBar.top = 0;
			_rightBar.bottom = 0;
			_rightBar.type = Side;
			_ct.addChild(_rightBar);
			
			_upBar = getADragBar("T");
			_upBar.height = DragBarWidth;
			_upBar.left = 0;
			_upBar.top = 0;
			_upBar.right = 0;
			_upBar.type = Side;
			_ct.addChild(_upBar);
			
			_downBar = getADragBar("T");
			_downBar.height = DragBarWidth;
			_downBar.left = 0;
			_downBar.bottom = 0;
			_downBar.right = 0;
			_downBar.type = Side;
			_ct.addChild(_downBar);
			
			var rec:LayoutRec = getARec();
			_ct.addChild(rec);
			rec.left = 0;
			rec.right = 0;
			rec.top = 0;
			rec.bottom = 0;
			
			RelativePos.addRelative(rec, _leftBar, RelativePos.Left);
			RelativePos.addRelative(rec, _rightBar, RelativePos.Right);
			RelativePos.addRelative(rec, _upBar, RelativePos.Up);
			RelativePos.addRelative(rec, _downBar, RelativePos.Down);
			
			insert(rec, getARec());
			
			var tRec:LayoutRec;
			tRec = getARec();
			insertV(rec, tRec);
			insert(tRec, getARec());
			trace("onlySide:", RelativePos.getOnlySide(tRec));
			insertV(tRec, getARec());
			trace("onlySide:", RelativePos.getOnlySide(tRec));
			//removeRec(tRec);
		
		}
		
		/**
		 * 清空布局框 
		 * 
		 */
		public static function clearAll():void
		{
			clearLayoutsOfContainer(_ct);
			clearLayoutsOfContainer(LayerManager.stage);
		}
		private static function clearLayoutsOfContainer(_ct:Sprite):void
		{
			var items:Array;
			items = DisControlTool.getAllChild(_ct);
			var i:int, len:int;
			len = items.length;
			
			var tDis:Component;
			for (i = 0; i < len; i++)
			{
				tDis = items[i];
				if (tDis is LayoutDragBar)
				{
					(tDis as LayoutDragBar).clears();
					tDis.removeSelf();
				}
				else if (tDis is LayoutRec)
				{
					(tDis as LayoutRec).clears();
					tDis.removeSelf();
				}
			}
		}
		
		/**
		 * 创建默认的布局
		 *
		 */
		public static function createDefault():void
		{

			clearAll();
			resizeWork();
			var path:String;
			path = FileManager.getAppPath(Paths.LayoutFile_Static);

			if(FileTools.exist(path))
			{
				layoutByLayoutFile(path);
				return;
			}
			var _leftBar:LayoutDragBar;
			var _rightBar:LayoutDragBar;
			var _upBar:LayoutDragBar;
			var _downBar:LayoutDragBar;
			
			_leftBar = getADragBar("R");
			_leftBar.width = DragBarWidth;
			_leftBar.left = 0;
			_leftBar.top = 0;
			_leftBar.bottom = 0;
			_leftBar.type = Side;
			_ct.addChild(_leftBar);
			
			_rightBar = getADragBar("R");
			_rightBar.width = DragBarWidth;
			_rightBar.right = 0;
			_rightBar.top = 0;
			_rightBar.bottom = 0;
			_rightBar.type = Side;
			_ct.addChild(_rightBar);
			
			_upBar = getADragBar("T");
			_upBar.height = DragBarWidth;
			_upBar.left = 0;
			_upBar.top = 0;
			_upBar.right = 0;
			_upBar.type = Side;
			_ct.addChild(_upBar);
			
			_downBar = getADragBar("T");
			_downBar.height = DragBarWidth;
			_downBar.left = 0;
			_downBar.bottom = 0;
			_downBar.right = 0;
			_downBar.type = Side;
			_ct.addChild(_downBar);
			
			RelativePos.addRelative(_upBar, _leftBar, RelativePos.Left);
			RelativePos.addRelative(_upBar, _rightBar, RelativePos.Right);
			
			RelativePos.addRelative(_downBar, _leftBar, RelativePos.Left);
			RelativePos.addRelative(_downBar, _rightBar, RelativePos.Right);
			
			RelativePos.addRelative(_leftBar, _upBar, RelativePos.Up);
			RelativePos.addRelative(_leftBar, _downBar, RelativePos.Down);
			
			RelativePos.addRelative(_rightBar, _upBar, RelativePos.Up);
			RelativePos.addRelative(_rightBar, _downBar, RelativePos.Down);
			
			var rec:LayoutRec = new LayoutRec();
			_ct.addChild(rec);
			rec.left = 0;
			rec.right = 0;
			rec.top = 0;
			rec.bottom = 0;
			
			RelativePos.addRelative(rec, _leftBar, RelativePos.Left);
			RelativePos.addRelative(rec, _rightBar, RelativePos.Right);
			RelativePos.addRelative(rec, _upBar, RelativePos.Up);
			RelativePos.addRelative(rec, _downBar, RelativePos.Down);
			
			debugger;
			addPanelToRec(ResPanel.instance, rec);
			
			
			
			var uiRec:LayoutRec;
			uiRec = new LayoutRec();
			insert(rec, uiRec, 0.8);
			addPanelToRec(EditZone.instance, uiRec);
			return;
			var resRec:LayoutRec;
			resRec = new LayoutRec();
			insertV(rec, resRec);
			addPanelToRec(CompPanel.instance,resRec);
			addPanelToRec(ResPanel.instance, resRec);
			
			var propRec:LayoutRec;
			propRec = new LayoutRec();
			insert(uiRec, propRec, 0.3);
			addPanelToRec(PropPanel.instance, propRec);

			
			
			var disTreeRec:LayoutRec;
			disTreeRec = new LayoutRec();
			//insetToBar(_leftBar, disTreeRec, 0.2);
			insertV(propRec, disTreeRec);
			addPanelToRec(DisplayTreePanel.instance, disTreeRec);		
		}
		
		
		
		private static const sizePosKeys:Array = ["x", "y", "width", "height"];
		private static const emptyLayoutO:Object = {"top": NaN, "bottom": NaN, "left": NaN, "right": NaN}
		
		/**
		 * 将布局容器中的内容弹出到stage上
		 * @param tar
		 *
		 */
		public static function popRec(tar:LayoutRec):void
		{
			if (tar.parent == LayerManager.stage)
				return;
			var point:Point;
			point = new Point();
			point = tar.localToGlobal(point);
//			trace("pPos:",point.x,point.y);
			point=LayerManager.stage.globalToLocal(point);
//			trace("pPos:",point.x,point.y);
			var posInfo:Object = {};
			ObjectTools.copyValueByArr(posInfo, tar, sizePosKeys);
			posInfo.x = point.x + DragManager.dPos.x;
			posInfo.y = point.y + DragManager.dPos.y;
//			trace("dPos:", DragManager.dPos.x, DragManager.dPos.y);
			
			//posInfo.width = 200;
			//posInfo.height = 300;
//			trace("tar size:", tar.width, tar.height);
			removeRec(tar);
			DisControlTool.clearItemRelativeInfo(tar);
//			trace("tar size:", tar.width, tar.height);
			// Laya.timer.once(1000, null, addToStageLater, [tar, posInfo]);
			addToStageLater(tar, posInfo);
		}
		
		private static function addToStageLater(tar:LayoutRec, posInfo:Object):void
		{
			
//			trace("tar size:", tar.width, tar.height);
//			tar.top = NaN;
//			tar.bottom = NaN;
//			tar.left = NaN;
//			tar.right = NaN;
			
//			trace("tar size:", tar.width, tar.height);
			//Watcher.debugChange(tar, "width");
			LayerManager.stage.addChild(tar);
			if(posInfo.height<200) posInfo.height=200;
			tar.x = posInfo.x - 10;
			tar.y = posInfo.y - 10;
			tar.width = posInfo.width + 20;
			tar.height = posInfo.height + 20;
//			trace("posInfo:",posInfo.width,posInfo.height);
		
		}
		
		private static function clearRelativePosition(tar:Box):void
		{
			tar.top = NaN;
			tar.bottom = NaN;
			tar.left = NaN;
			tar.right = NaN;
		}
		
		/**
		 * 移除布局框
		 * @param tar
		 *
		 */
		public static function removeRec(tar:LayoutRec):void
		{
//			trace("removeRec");
			var onlySide:String;
			onlySide = RelativePos.getOnlySide(tar);
			if (!onlySide)
			{
				trace("无可拖动条");
				tar.removeSelf();
				RelativePos.clearBar(tar);
				//tar.clears();
				return;
			}
			
			var onlyBar:LayoutDragBar;
			onlyBar = RelativePos.getBar(tar, onlySide);
			var otherSide:String;
			otherSide = RelativePos.getOtherSide(onlySide);
			var otherBar:LayoutDragBar;
			otherBar = RelativePos.getBar(tar, otherSide);
			
//			trace("onlySide:", onlySide, "otherSide:", otherSide);
			if (onlyBar && otherBar)
			{
				otherBar.mergeUpdates(onlyBar);
				onlyBar.removeSelf();
				onlyBar.clears();
				
				RelativePos.clearBar(onlyBar);
				
				tar.removeSelf();
				RelativePos.clearBar(tar);
			}
			
			//tar.clears();
			
			adptAll();
		}
		
		public static const minRecLen:int = 4;
		public static const RecTweenTime:int=150;
		public static function minToBottom(tar:LayoutRec):void
		{
			if(isTweening) return;
			var topBar:LayoutDragBar;
			var bottomBar:LayoutDragBar;
			topBar=RelativePos.getBar(tar,"up");
			bottomBar=RelativePos.getBar(tar,"down");
			if(tar.disMode==LayoutRec.Min)
			{
				tar.disMode=LayoutRec.Normal;

				recTween(topBar,{"_dragY":bottomBar.y-tar.preMoveLen});
			}else
			{
				tar.disMode=LayoutRec.Min;

				tar.preMoveLen=bottomBar.y-topBar.y;
				recTween(topBar,{"_dragY":bottomBar.y-22});
			}
			
			
		}
		public static function minToRight(tar:LayoutRec):void
		{
			if(isTweening) return;
			var rightBar:LayoutDragBar;
			var leftBar:LayoutDragBar;
			rightBar=RelativePos.getBar(tar,"right");
			leftBar=RelativePos.getBar(tar,"left");
			if(tar.disMode==LayoutRec.Min)
			{
				tar.disMode=LayoutRec.Normal;
			
				recTween(leftBar,{"_dragX":rightBar.x-tar.preMoveLen});
			}else
			{
				tar.disMode=LayoutRec.Min;

				tar.preMoveLen=rightBar.x-leftBar.x;
				recTween(leftBar,{"_dragX":rightBar.x-22});
			}
		}
		
		public static function minToLeft(tar:LayoutRec):void
		{
			if(isTweening) return;
			var rightBar:LayoutDragBar;
			var leftBar:LayoutDragBar;
			rightBar=RelativePos.getBar(tar,"right");
			leftBar=RelativePos.getBar(tar,"left");
			if(tar.disMode==LayoutRec.Min)
			{
				tar.disMode=LayoutRec.Normal;

				recTween(rightBar,{"_dragX":leftBar.x+tar.preMoveLen});
			}else
			{
				tar.disMode=LayoutRec.Min;

				tar.preMoveLen=rightBar.x-leftBar.x;

				recTween(rightBar,{"_dragX":leftBar.x+22});
			}
		}
		
		private static function recTween(tar:*,props:Object):void
		{
			
			if(!tweenCompleteHandler) tweenCompleteHandler=new Handler(null,onTweenComplete);
			isTweening=true;
			Tween.to(tar,props,RecTweenTime,Ease.circInOut,tweenCompleteHandler);
		}
		private static var tweenCompleteHandler:Handler;
		private static var isTweening:Boolean=false;
		private static function onTweenComplete():void
		{
			isTweening=false;
		}
		/**
		 * 最小化布局框
		 * @param tar
		 *
		 */
		public static function minRec(tar:LayoutRec):void
		{
//			trace("minRec");
			var onlySide:String;
			onlySide = RelativePos.getOnlySide(tar);
			if (!onlySide)
				return;
			var onlyBar:LayoutDragBar;
			onlyBar = RelativePos.getBar(tar, onlySide);
			var otherSide:String;
			otherSide = RelativePos.getOtherSide(onlySide);
			var otherBar:LayoutDragBar;
			otherBar = RelativePos.getBar(tar, otherSide);
			
//			trace("onlySide:", onlySide, "otherSide:", otherSide);
			if (onlyBar && otherBar)
			{
				switch (onlySide)
				{
					case RelativePos.Right: 
						onlyBar.left -= tar.width - minRecLen;
						break;
					case RelativePos.Left: 
						onlyBar.left += tar.width - minRecLen;
						break;
					case RelativePos.Up: 
						onlyBar.top += tar.height - minRecLen;
						break;
					case RelativePos.Down: 
						onlyBar.top -= tar.height - minRecLen;
						break;
				}
				
			}
			
			onlyBar.updates();
		}
		
		/**
		 * 恢复最小化的布局框
		 * @param tar
		 *
		 */
		public static function recoverRec(tar:LayoutRec):void
		{
//			trace("minRec");
			var onlySide:String;
			onlySide = RelativePos.getOnlySide(tar);
			if (!onlySide)
				return;
			var onlyBar:LayoutDragBar;
			onlyBar = RelativePos.getBar(tar, onlySide);
			var otherSide:String;
			otherSide = RelativePos.getOtherSide(onlySide);
			var otherBar:LayoutDragBar;
			otherBar = RelativePos.getBar(tar, otherSide);
			
//			trace("onlySide:", onlySide, "otherSide:", otherSide);
			if (onlyBar && otherBar)
			{
				switch (onlySide)
				{
					case RelativePos.Right: 
						onlyBar.left -= tar.width - tar.preWidth;
						break;
					case RelativePos.Left: 
						onlyBar.left += tar.width - tar.preWidth;
						break;
					case RelativePos.Up: 
						onlyBar.top += tar.height - tar.preHeight;
						break;
					case RelativePos.Down: 
						onlyBar.top -= tar.height - tar.preHeight;
						break;
				}
				
			}
			
			onlyBar.updates();
		}
		
		/**
		 * 自适应到布局框
		 * @param tar
		 *
		 */
		public static function adptTo(tar:LayoutRec):void
		{
			var onlySide:String;
			onlySide = RelativePos.getOnlySide(tar);
			if (!onlySide)
				return;
			var onlyBar:LayoutDragBar;
			onlyBar = RelativePos.getBar(tar, onlySide);
			var otherSide:String;
			otherSide = RelativePos.getOtherSide(onlySide);
			var otherBar:LayoutDragBar;
			otherBar = RelativePos.getBar(tar, otherSide);
			
//			trace("onlySide:", onlySide, "otherSide:", otherSide);
			if (onlyBar && otherBar)
			{
				switch (onlySide)
				{
					case RelativePos.Right: 
						onlyBar.left = tar.left + tar.width;
						break;
					case RelativePos.Left: 
						onlyBar.left = tar.left - onlyBar.width;
						break;
					case RelativePos.Up: 
						onlyBar.top = tar.top - onlyBar.height;
						break;
					case RelativePos.Down: 
						onlyBar.top = tar.top + tar.height;
						break;
				}
				
			}
			
			onlyBar.updates();
		}
		/**
		 * 拖动条宽度
		 */
		public static const DragBarWidth:int = 0;
		
		/**
		 * 将布局框插到拖动条右侧
		 * @param tar
		 * @param insert
		 * @param rate
		 *
		 */
		public static function insetToBar(tar:LayoutDragBar, insert:LayoutRec, rate:Number = 0.4):void
		{
			var rec:Rectangle;
			rec = tar.getDragArea();
			rec.width = 200;
			if (rec.width < 20)
				return;
			
			var tLen:int;
			tLen = rec.width;
			
			var dragBar:LayoutDragBar;
			dragBar = getADragBar("R");
			dragBar.size(DragBarWidth, tar.height);
			dragBar.right = tar.right;
			dragBar.left = tar.left
			dragBar.top = tar.top;
			dragBar.bottom = tar.bottom;
			dragBar.type = Horizon;
			dragBar.mergeUpdates(tar);
			
			tar.clear();
			
			dragBar.left += rate * tLen;
			
			RelativePos.clearBar(insert);
			insert.left = tar.left
			insert.top = tar.top;
			insert.bottom = tar.bottom;
			
			if (RelativePos.getBar(tar, RelativePos.Right))
			{
				RelativePos.copyRelative(dragBar, tar, RelativePos.Right);
			}
			
			RelativePos.addRelative(insert, tar, RelativePos.Left);
			RelativePos.addRelative(insert, dragBar, RelativePos.Right);
			
			RelativePos.copyRelative(insert, tar, RelativePos.Down);
			RelativePos.copyRelative(dragBar, tar, RelativePos.Down);
			
			RelativePos.copyRelative(insert, tar, RelativePos.Up);
			RelativePos.copyRelative(dragBar, tar, RelativePos.Up);
			
			_ct.addChild(dragBar);
			_ct.addChild(insert);
			
			adptAll();
		}
		
		/**
		 * 将布局框插入到拖动条下方
		 * @param tar
		 * @param insert
		 * @param rate
		 *
		 */
		public static function insetToBarV(tar:LayoutDragBar, insert:LayoutRec, rate:Number = 0.4):void
		{
			var rec:Rectangle;
			rec = tar.getDragArea();
			rec.height = 200;
			if (rec.height < 20)
				return;
			
			var tLen:int;
			tLen = rec.height;
			
			
			//创建新的拖动条，拷贝原拖动条的数据
			var dragBar:LayoutDragBar;
			dragBar = getADragBar("T");
			dragBar.size(tar.width, DragBarWidth);
			dragBar.right = tar.right;
			dragBar.left = tar.left
			dragBar.top = tar.top;
			dragBar.bottom = tar.bottom;
			dragBar.type = Vertical;
			
			//将原拖动条下方的关系切换到新的拖动条
			dragBar.copyUpdates(tar,RelativePos.Up);
			
		    //清空原拖动条的更新列表
			//tar.clear();
			
			//将新的拖动条下移
			dragBar.top += rate * tLen;
			
			//清空要插入rec的相对信息
			RelativePos.clearBar(insert);
			
			//将rec放在合适的位置
			insert.right = tar.right;
			insert.left = tar.left
			insert.top = tar.top;
			insert.bottom = tar.bottom;
			
			
			//如果原先的拖动条有下方的相对关系，则拷贝到新的拖动条，并取消原来的
			if (RelativePos.getBar(tar, RelativePos.Down))
			{
				RelativePos.copyRelative(dragBar, tar, RelativePos.Down);
				RelativePos.cancelRelative(tar,RelativePos.Down);
			}
			
			
			
			RelativePos.addRelative(insert, tar, RelativePos.Up);
			RelativePos.addRelative(insert, dragBar, RelativePos.Down);
			
			RelativePos.copyRelative(insert, tar, RelativePos.Right);
			RelativePos.copyRelative(dragBar, tar, RelativePos.Right);
			
			RelativePos.copyRelative(insert, tar, RelativePos.Left);
			RelativePos.copyRelative(dragBar, tar, RelativePos.Left);
			
			_ct.addChild(dragBar);
			_ct.addChild(insert);
			
			adptAll();
		}
		
		/**
		 * 水平方向插入到右边
		 * @param tar
		 * @param insert
		 * @param rate
		 *
		 */
		public static function insert(tar:LayoutRec, insert:LayoutRec, rate:Number = 0.4):void
		{
			var tLen:int;
			tLen = tar.width;
			insert.right = tar.right;
			tar.right += tLen * rate;
			insert.left = tar.x + tar.width;
			insert.top = tar.top;
			insert.bottom = tar.bottom;
			var dragBar:LayoutDragBar;
			dragBar = getADragBar("R");
			dragBar.size(DragBarWidth, tar.height);
			dragBar.left = tar.x + tar.width;
			dragBar.top = tar.top;
			dragBar.bottom = tar.bottom;
			
			if (RelativePos.getBar(tar, RelativePos.Right))
			{
				RelativePos.copyRelative(insert, tar, RelativePos.Right);
				RelativePos.cancelRelative(tar, RelativePos.Right);
			}
			
			RelativePos.addRelative(tar, dragBar, RelativePos.Right);
			RelativePos.addRelative(insert, dragBar, RelativePos.Left);
			
			RelativePos.copyRelative(insert, tar, RelativePos.Down);
			RelativePos.copyRelative(dragBar, tar, RelativePos.Down);
			
			RelativePos.copyRelative(insert, tar, RelativePos.Up);
			RelativePos.copyRelative(dragBar, tar, RelativePos.Up);
			
			tar.parent.addChild(dragBar);
			tar.parent.addChild(insert);
			DisControlTool.setTop(dragBar);
			
			dragBar.type = Horizon;
			
			adptAll();
		
		}
		
		public static function insertL(tar:LayoutRec, insert:LayoutRec, rate:Number = 0.4):void
		{
			var tLen:int;
			tLen = tar.width;
			insert.right = tar.right;
			
			insert.left = tar.left;
			tar.left += tLen * rate;
			insert.top = tar.top;
			insert.bottom = tar.bottom;
			var dragBar:LayoutDragBar;
			dragBar = getADragBar("R");
			dragBar.size(DragBarWidth, tar.height);
			dragBar.left = tar.x;
			dragBar.top = tar.top;
			dragBar.bottom = tar.bottom;
			
			if (RelativePos.getBar(tar, RelativePos.Left))
			{
				RelativePos.copyRelative(insert, tar, RelativePos.Left);
				RelativePos.cancelRelative(tar, RelativePos.Left);
			}
			
			RelativePos.addRelative(tar, dragBar, RelativePos.Left);
			RelativePos.addRelative(insert, dragBar, RelativePos.Right);
			
			RelativePos.copyRelative(insert, tar, RelativePos.Down);
			RelativePos.copyRelative(dragBar, tar, RelativePos.Down);
			
			RelativePos.copyRelative(insert, tar, RelativePos.Up);
			RelativePos.copyRelative(dragBar, tar, RelativePos.Up);
			
			tar.parent.addChild(dragBar);
			tar.parent.addChild(insert);
			DisControlTool.setTop(dragBar);
			
			dragBar.type = Horizon;
			
			adptAll();
		
		}
		
		/**
		 * 垂直方向插入到下面
		 * @param tar
		 * @param insert
		 * @param rate
		 *
		 */
		public static function insertV(tar:LayoutRec, insert:LayoutRec, rate:Number = 0.4):void
		{
			
			if(tar.height<150)
			{
				var downBar:LayoutDragBar;
				downBar=RelativePos.getBar(tar,RelativePos.Down);
				if(downBar.type!=LayoutRecManager.Side)
				{
					insetToBarV(downBar,insert);
					return;
				}
			}
			var tLen:int;
			tLen = tar.height;
			insert.right = tar.right;
			insert.bottom = tar.bottom;
			tar.bottom += tLen * rate;
			insert.left = tar.left;
			insert.top = tar.y + tar.height;
			
			var dragBar:LayoutDragBar;
			dragBar = getADragBar("T");
			dragBar.size(tar.width, DragBarWidth);
			dragBar.left = tar.x;
			dragBar.top = tar.y + tar.height;
			
			if (RelativePos.getBar(tar, RelativePos.Down))
			{
				RelativePos.copyRelative(insert, tar, RelativePos.Down);
				RelativePos.cancelRelative(tar, RelativePos.Down);
				
			}
			
			RelativePos.addRelative(tar, dragBar, RelativePos.Down);
			RelativePos.addRelative(insert, dragBar, RelativePos.Up);
			
			RelativePos.copyRelative(insert, tar, RelativePos.Right);
			RelativePos.copyRelative(dragBar, tar, RelativePos.Right);
			
			RelativePos.copyRelative(insert, tar, RelativePos.Left);
			RelativePos.copyRelative(dragBar, tar, RelativePos.Left);
			
			tar.parent.addChild(dragBar);
			tar.parent.addChild(insert);
			DisControlTool.setTop(dragBar);
			
			dragBar.type = Vertical;
			
			adptAll();
		
		}
		
		public static function getADragBar(type:String):LayoutDragBar
		{
			var dragBar:LayoutDragBar = new LayoutDragBar(type);
			dragBar.on(Event.MOUSE_DOWN, null, onMouseDown);
			return dragBar;
		}
		
		public static function addPanelToRec(panel:Box, rec:LayoutRec):void
		{
			panel.top = 20;
			panel.left = 0;
			panel.right = 0;
			panel.bottom = 0;
			
			rec.addUI(panel);
		}
		
		public static function getARec():LayoutRec
		{
			var rec:LayoutRec = new LayoutRec();
			rec.addUI(getAUI("#ff00ff"));
			rec.addUI(getAUI("#ff000f"));
			return rec;
		}
		
		public static function getAUI(color:String = "#ff00ff"):Box
		{
			var box:Box = new Box();
			box.graphics.drawRect(0, 0, 20, 20, color);
			box.width = 20;
			box.height = 20;
			box.left = 5;
			box.right = 5;
			box["title"] = "tt:" + Math.ceil(Math.random() * 10);
			return box;
		}
	}

}