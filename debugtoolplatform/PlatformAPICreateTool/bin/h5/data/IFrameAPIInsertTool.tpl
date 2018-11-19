///////////////////////////////////////////////////////////
//  IFrameAPIInsertTool.as
//  Macromedia ActionScript Implementation of the Class IFrameAPIInsertTool
//  Created on:      2018-5-28 下午4:54:05
//  Original author: ww
///////////////////////////////////////////////////////////

package platform.tools
{
{#@imports#}
	/**
	 * 
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2018-5-28 下午4:54:05
	 */
	public class IFrameAPIInsertTool
	{
		public function IFrameAPIInsertTool()
		{
		}
		
		public static function insertClassList(clsList:Array,tarWindow:*=null):void
		{
			if(!tarWindow) tarWindow=window;
			var i:int,len:int;
			len=clsList.length;
			var tClz:*;
			for(i=0;i<len;i++)
			{
				tClz=clsList[i];
				insertClass(tClz,tarWindow);
			}
		}
		
		public static function insertClass(clz:Object,tarWindow:*=null):void
		{
			if(!tarWindow) tarWindow=window;
			var tName:String;
			tName=clz.__className;
			var pathList:Array
			pathList=tName.split(".");
			var i:int,len:int;
			len=pathList.length;
			var tPath:String;
			var tO:Object;
			tO=tarWindow;
			for(i=0;i<len-1;i++)
			{
				tPath=pathList[i];
				if(!tO[tPath]) tO[tPath]={};
				tO=tO[tPath];
			}
			tO[pathList[len-1]]=clz;
		}
		
		public static function insertAPI(tarWindow:*):void
		{
			var clzList:Array;
			clzList=[{#@inserts#}];
			insertClassList(clzList,tarWindow);
		}
	}
}