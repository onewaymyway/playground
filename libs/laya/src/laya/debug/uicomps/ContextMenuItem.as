package laya.debug.uicomps 
{
	import laya.debug.data.Base64AtlasManager;
	import laya.ui.Button;
	import laya.ui.Image;

	/**
	 * ...
	 * @author ww
	 */
	public class ContextMenuItem extends Button
	{
		public var data:Object;
		private var img:Image;
		public static var lineSkin:String;
		public static var btnSkin:String;
		public static var labelColors:String;
		public function ContextMenuItem(txt:String,isSeparator:Boolean) 
		{
			super();
			if(!img)img=new Image();
			//trace("create ContextMenuItem");
			if(txt!="")
			{
				label = txt;
				name = txt;
				
			}else
			{
				label = "------";
				height = 5;
				this.mouseEnabled=false;
//				this.skin = "comp/button1.png";
				img.skin = lineSkin||Base64AtlasManager.base64.getAdptUrl("comp/line2.png");
				img.sizeGrid = "0,2,0,2";
				this.addChild(img);
				
			}
			labelColors = labelColors||"#000000,#000000,#000000,#000000";
			_text.x = 10;
			_text.padding = [-2,0,0,0];
			_text.align = "left";
			_text.wordWrap=false;
			_text.typeset();
             width = _text.width+25;
			 //img.top=img.bottom=1;
			 //img.left=img.right=5;
			this.sizeGrid = "3,3,3,3";
			this.skin = btnSkin||Base64AtlasManager.base64.getAdptUrl("comp/button1.png");
		}
		
		override public function set width(v:Number):void
		{
			super.width=v;
			img.width=width;
			img.x=0;
		}
		
	}

}
