package platform.extenddisplay 
{
	/**
	 * ...
	 * @author ww
	 */
	public class IFrameUtils 
	{
		
		public function IFrameUtils() 
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
		
		public static function insertClassListByFullName(clzList:Array,namelist:Array,tarWindow:*=null):void
		{
			var i:int,len:int;
			len=clzList.length;
			for(i=0;i<len;i++)
			{
				insertClassByFullName(clzList[i],tarWindow,namelist[i]);
			}
		}
		public static function insertClassByFullName(clz:Object,tarWindow:*=null,tName:String=null):void
		{
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
	}

}