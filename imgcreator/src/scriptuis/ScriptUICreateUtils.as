package scriptuis 
{
	import laya.display.Sprite;
	import laya.maths.Rectangle;
	/**
	 * ...
	 * @author ww
	 */
	public class ScriptUICreateUtils 
	{
		
		public function ScriptUICreateUtils() 
		{
			
		}
		public static const ImgHeight:int = 40;
		public static const AngleDepth:int = 10;
		public static const AngleWidth:int = 20;
		public static const AngleStart:int = 10;
		public static const ImgWidth:int = 100;
		public static const SideBarWidth:int = 10;
		
		public static const logicSideLen:int = 15;
		/**
		 * 带上下插槽的多边形
		 */
		public static var normalPoly:Array;
		
		/**
		 * 带下插槽的多边形
		 */
		public static var noUpPoly:Array;
		/**
		 * 没有上下插槽的多边形
		 */
		public static var noAnglePoly:Array;
		
		/**
		 * 多行侧边条
		 */
		public static var sideBarPoly:Array;
		
		/**
		 * 多行开始条
		 */
		public static var multilineStartPoly:Array;
		
		/**
		 * 逻辑条
		 */
		public static var logicPoly:Array;
		
		initPolys();
		private static function initPolys():void
		{
			noUpPoly = [
			0, 0,
			ImgWidth, 0,
			ImgWidth, ImgHeight,
			AngleStart+AngleWidth, ImgHeight,
			AngleStart+AngleWidth*0.5, ImgHeight+AngleDepth,
			AngleStart, ImgHeight,
			0, ImgHeight];
			
			normalPoly = [
			0, 0,
			AngleStart, 0,
			AngleStart+AngleWidth*0.5, AngleDepth,
			AngleStart+AngleWidth, 0,
			ImgWidth, 0,
			ImgWidth, ImgHeight,
			AngleStart+AngleWidth, ImgHeight,
			AngleStart+AngleWidth*0.5, ImgHeight+AngleDepth,
			AngleStart, ImgHeight,
			0, ImgHeight];
			
			noAnglePoly = [
			0, 0,
			ImgWidth, 0,
			ImgWidth, ImgHeight,
			0, ImgHeight];
			
			sideBarPoly = [
			0, 0,
			AngleStart, 0,
			AngleStart + AngleWidth * 0.5, AngleDepth,
			AngleStart + AngleWidth * 0.5, ImgHeight,
			0, ImgHeight,
			];
			
			multilineStartPoly = [
			0, AngleDepth,
			AngleWidth*0.5, 0,
			ImgWidth, 0,
			ImgWidth, ImgHeight,
			AngleStart+AngleWidth, ImgHeight,
			AngleStart+AngleWidth*0.5, ImgHeight+AngleDepth,
			AngleStart, ImgHeight,
			0, ImgHeight];
			
			logicPoly = createLogicPoly(100, 22, 15);
			
		}
		
		public static function createLogicPoly(width:int, height:int, sideLen:int):Array
		{
			var rst:Array;
			rst = [
			0, height * 0.5,
			sideLen, 0,
			width - sideLen, 0,
			width, height * 0.5,
			width - sideLen, height,
			sideLen,height
			];
			
			return rst;
		}
		
		public static function createTriangle(width:int, height:int):Array
		{
			var rst:Array;
			rst = [
			0, 0,
			width, 0,
			width*0.5,height
			];
			
			return rst;
		}
		
		public static function createComboxSprite(name:String,width:int=40,height:int=26,arrowWidth:int=14,arrowHeight:int=12,arrowRight:int=10):Sprite
		{
			var radius:int;
			radius = 5;
			var sp:Sprite;
			sp = createRoundCornerRec(name, width - radius, height, radius, "#ffffff", "#000000", 1);
			var triangleSp:Sprite;
			triangleSp = createNormalSprite("", createTriangle(arrowWidth, arrowHeight), "#000000", "#000000", 0);
			triangleSp.x = sp.width - triangleSp.width - arrowRight;
			triangleSp.y = (height - arrowHeight) * 0.5;
			//triangleSp.blendMode = "destination-out";
			sp.addChild(triangleSp)
			sp.name = name;
			
			return sp;
		}
		public static function createNormalSprite(name:String,points:Array,fillColor:String,lineColor:String,lineWidth:int=1):Sprite
		{
			var sp:Sprite;
			sp = new Sprite();
			sp.graphics.drawPoly(0, 0, points, fillColor, lineColor, lineWidth);
			sp.name = name;
			var bounds:Rectangle;
			bounds = sp.getSelfBounds();
			sp.width = bounds.width+lineWidth;
			sp.height = bounds.height+lineWidth;
			
			return sp;
		}
		
		
		private static function createSpsByColor(spList:Array,fillColor:String,lineColor:String,lineWidth:int=1):void
		{
			var i:int, len:int;
			len = defines.length;
			for (i = 0; i < len; i++)
			{
				tDis = defines[i];
				tSp = createNormalSprite(tDis[0], tDis[1], tDis[3]||fillColor, lineColor, tDis[2]);
				spList.push(tSp);
			}
		}
		
		
		private static function createRoundCornerRec(name:String="",width:int=80,height:int=40,radius:int=10,fillColor:String=null,lineColor:String=null,lineWidth:int=1):Sprite
		{
			var sp:Sprite;
			sp = new Sprite();
			
			var pen:Object;
			if (lineColor)
			{
				pen = { };
				pen.strokeStyle = lineColor;
				pen.lineWidth = lineWidth;
			}

			sp.graphics.drawPath(0, 0, [
            ["moveTo", radius, 0],
            ["lineTo", width+radius, 0],
            ["arcTo", width+radius*2, 0, width+radius*2, radius, radius],
            ["lineTo", width+radius*2, height-radius],
            ["arcTo", width+radius*2, height, width+radius, height, radius],
            ["lineTo", radius, height],
            ["arcTo", 0, height, 0, height-radius, radius],
            ["lineTo", 0, radius],
            ["arcTo", 0, 0, radius, 0, radius],
            ["closePath"]
        ],
        {
            fillStyle: fillColor
        },pen);
		sp.name = name;
		sp.height = height;
		sp.width = width + radius * 2;
		return sp;
		}
		public static var defines:Array;
		public static function createSpForRender():Sprite
		{
			var sp:Sprite;
			sp = new Sprite();
			
			
			defines = [];
			defines.push(["script_bgud.png", normalPoly,1]);
			defines.push(["script_bgd.png", noUpPoly, 1]);
			defines.push(["script_bgevent.png", noUpPoly,1,"#608fee"]);
			defines.push(["script_bg.png", noAnglePoly, 1]);
			defines.push(["script_bglogic.png", logicPoly, 1, "#fbba9d"]);
		
			defines.push(["script_sidebar.png", sideBarPoly,0,"#68cdff"]);
			defines.push(["script_multistart.png", multilineStartPoly, 0,"#68cdff"]);
			defines.push(["script_multimid.png", normalPoly,0,"#68cdff"]);
			defines.push(["script_multiend.png", noUpPoly,0,"#68cdff"]);
			var spList:Array;
			spList = [];
			var tDis:Array;
			var i:int, len:int;
			
			var tSp:Sprite;
			
			var fillColor:String;
			var lineColor:String;
			var lineWidth:int;
			
			fillColor = "#f46767";
			lineColor = "#cccccc";
			lineWidth = 1;
			
			createSpsByColor(spList, fillColor, lineColor);
			
			
			spList.push(createRoundCornerRec("script_valuebg", 80 - 10 * 2, 30, 10, "#fbc2c2", "#ffffff", 1));
			spList.push(createRoundCornerRec("script_valueitembg", 80 - 10 * 2, 30, 10, "#fffcfa", "#ffffff", 1));
			
			spList.push(createComboxSprite("script_combox"));
			
			spList.push(UICreateUtils.createHeadIcon("home_headmask",50));
			len = spList.length;
			
			var tY:Number;
			tY = 0;
			for (i = 0; i < len; i++)
			{
				tSp = spList[i];
				tSp.y = tY;
				tY += tSp.height + 10;
				sp.addChild(tSp);
			}
			return sp;
			
		}
		
	}

}