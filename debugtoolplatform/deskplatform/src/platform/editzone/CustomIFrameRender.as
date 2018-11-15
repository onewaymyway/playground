///////////////////////////////////////////////////////////
//  CustomIFrameRender.as
//  Macromedia ActionScript Implementation of the Class CustomIFrameRender
//  Created on:      2018-5-25 上午10:02:33
//  Original author: ww
///////////////////////////////////////////////////////////

package platform.editzone
{
	

	
	import electrontools.MessageManager;
	import laya.debug.tools.JsonTool;
	import laya.debug.tools.ObjectTools;
	import laya.display.Node;
	import laya.events.Event;
	import nodetools.devices.FileManager;
	import nodetools.devices.FileTools;
	import nodetools.devices.Sys;
	import nodetools.devices.SystemSetting;
	import platform.extenddisplay.IFrameSprite;
	import platform.interfaces.PlatformEvents;
	import platform.managers.StateManager;
	import view.Alert;
	
	/**
	 * 
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2018-5-25 上午10:02:33
	 */
	public class CustomIFrameRender extends SceneBase
	{
		public function CustomIFrameRender()
		{
			iframeSprite = new EditViewerIFrameSprite();
			iframeSprite.bottom = iframeSprite.top = iframeSprite.left = iframeSprite.right = 0;
			addChild(iframeSprite);
			iframeSprite.on(Event.LOADED, this, onIFrameLoaded);
		}
		
		public var renderPagePath:String = "renders/design3d/index.html";
		public var iframeSprite:EditViewerIFrameSprite;
		
		public function initIframe():void
		{
			iframeSprite.setUrl(renderPagePath);
		}
		private function onIFrameLoaded():void
		{
			initPage();
		}
		private function initPage():void
		{
			
			_changed = false;
			var data:Object;
			if(pagePath)
			{
				//				trace("dataFromFile:",pagePath);
				iframeSprite.renderItem.setPagePath(pagePath);
				if(StateManager.has(pagePath))
				{
					data=StateManager.getState(pagePath).now();
				}else
				{
					try{
						var jsonStr:String=FileTools.readFile(pagePath);
						data=ObjectTools.getObj(jsonStr);
						StateManager.updateState(pagePath,data);
					}catch(e:*)
					{
						Alert.show(Sys.lang("读取数据出错，请查看文件是否已损坏:"+pagePath));
						return;
					}
					
				}
				
			}else
			{
				//				trace("dataFromRender");
				data=iframeSprite.renderItem.getRenderData();
			}
			
			
			try{
				Laya.timer.frameOnce(1,this,renderByData,[data]);
				//				renderByData(data);
			}
			catch(e:*){}
			
			
		}
		
		
		override public function save():void
		{
			// TODO Auto Generated method stub
			super.save();
			//DialogTools.showSaveDialog(null,null,);
			if (pagePath)
			{
				saveFile(pagePath);
			}
			
		}
		
		private function saveFile(file:String):void
		{
			//			trace("saveParticleFile:",file);
			if(file)
			{
				//				var data:Object=ViewRenderManager.render.getRenderData();
				var data:Object=StateManager.getState(pagePath).now();
				
				//				FileTools.createFile(file, ObjectTools.getJsonString(data));
				FileManager.createTxtFile(file, JsonTool.getJsonString(data,false));
				MessageManager.instance.show(Sys.lang("保存成功"));
				_changed = false;
				StateManager.setChangeState(pagePath,false);
				Laya.stage.event("pageSaved");
				//Laya.stage.event("pageChanged");
				Laya.stage.event(PlatformEvents.PAGE_CHANGED);
			}
		}
		
		private function renderByData(data:Object):void
		{
			//			return;
			var updateData:Object;
			updateData={};
			updateData.type="init";
			//updateData.url = "file:///" + pagePath;
			//updateData.base = "file:///" +SystemSetting.assetsPath + "\\";
			
			updateData.url =FileTools.getAbsPath(pagePath);
			updateData.base = FileTools.getAbsPath(SystemSetting.assetsPath+FileTools.getSep());
			updateData.projectPath=SystemSetting.workPath;
			updateData.data = data;
			try
			{
				iframeSprite.renderItem.updateData(updateData);
			}catch(e:*)
			{
				
			}
			
		}
		
		override public function goBack():void
		{
			// TODO Auto Generated method stub
			super.goBack();
			var data:Object=StateManager.getState(pagePath).back();
			if(!data) 
			{
				trace("当前不可回退");
				return;
			};
			
			setRenderData(data);
			
		}
		
		override public function goForward():void
		{
			// TODO Auto Generated method stub
			super.goForward();
			var data:Object=StateManager.getState(pagePath).forward();
			if(!data) 
			{
				trace("当前不可前进");
				return;
			};
			setRenderData(data);
		}
		
		override public function get hasChange():Boolean
		{
			// TODO Auto Generated method stub
			return StateManager.hasChange(pagePath);
		}
		
		private function dataChanged():void
		{
			_changed = true;
			StateManager.setChangeState(pagePath,true);
			StateManager.updateState(pagePath,iframeSprite.renderItem.getRenderData());
			Laya.stage.event(PlatformEvents.PAGE_CHANGED);
		}
		private function setRenderData(data:Object):void
		{
			renderByData(data);
			//ViewRenderManager.render.setData(data);
			_changed = true;
			StateManager.setChangeState(pagePath,true);
			//			trace("configJson:", ObjectTools.getJsonString(data));
			//Laya.stage.event("pageChanged");
			Laya.stage.event(PlatformEvents.PAGE_CHANGED);
		}
	}
}