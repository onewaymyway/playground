package commonui.colorpanel 
{
	import laya.debug.tools.ColorTool;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.MathUtil;
	import laya.maths.Point;
	import laya.ui.Box;
	import laya.utils.Ease;
	import laya.utils.HitArea;
	import laya.utils.Tween;
	/**
	 * ...
	 * @author ww
	 */
	public class ColorRing extends Sprite
	{
		public var circleSplit:int = 32;
		public var depthSplit:int = 8;
		public var startS:Number=0.2;
		public var endS:Number=1;
		public var startB:Number=0.1;
		public var endB:Number = 1;
		
		public var ringSprite:Sprite;
		
		public function ColorRing() 
		{
			ringSprite = new Sprite();
			initSize(200,200);
			this.addChild(ringSprite);
			initeMouseEvents();
			this.on("click", this, onClick);
		}
		
		private function onClick(e:Event):void {
			e.stopPropagation();
		}
		
		
		private function initeMouseEvents():void
		{
			this.on(Event.MOUSE_DOWN, this, _onMouseDown);
			
		}
		
		private function _addMoveEvents():void
		{
			_removeMoveEvents();
			this.on(Event.MOUSE_MOVE, this, _onMouseMove);
			Laya.stage.on(Event.MOUSE_OUT, this, _onMouseOut);
			Laya.stage.on(Event.MOUSE_UP, this, _onMouseUp);
		}
		
		private function _removeMoveEvents():void
		{
			_isMoving = false;
			this.off(Event.MOUSE_MOVE, this, _onMouseMove);
			Laya.stage.off(Event.MOUSE_OUT, this, _onMouseOut);
			Laya.stage.off(Event.MOUSE_UP, this, _onMouseUp);
		}
	
		private var _isMoving:Boolean = false;
		private function getCurMouseInfo(mouseInfo:RingMouseInfo):RingMouseInfo
		{
			if(!mouseInfo)
			mouseInfo = new RingMouseInfo();
			var mousePoint:Point;
			mousePoint = this.getMousePoint();
			mouseInfo.rotation = MathUtil.getRotation(ringSprite.x, ringSprite.y, mousePoint.x, mousePoint.y);
			mouseInfo.r = Math.sqrt((ringSprite.x - mousePoint.x) * (ringSprite.x - mousePoint.x) + (ringSprite.y - mousePoint.y) * (ringSprite.y - mousePoint.y));
			return mouseInfo;
		}
		
		private var _curMouseInfo:RingMouseInfo;
		private var _mouseDonwMouseInfo:RingMouseInfo;
		private var _preMouseInfo:RingMouseInfo = new RingMouseInfo();
		
		private var _selectColorO:Object;
		private function _onMouseDown(e:Event):void
		{
			e.stopPropagation();
			leftRotation = 0;
			_mouseDonwMouseInfo= getCurMouseInfo(_mouseDonwMouseInfo);
			_preMouseInfo.rotation = ringSprite.rotation;
			_preMouseInfo.r = getMoveRate();
			_isMoving = false;
			
			var tColorO:Object;
			tColorO = getColorOByPoint(ringSprite.mouseX, ringSprite.mouseY);
			setSelectColor(tColorO);
			_addMoveEvents();
		}
		
		private function setSelectColor(colorO:Object):void
		{
			if (colorO == _selectColorO) return;
			_selectColorO = colorO;
			drawCircle();
			event(Event.CHANGE, [selectColor]);
		}
		
		public function selectColorRec(color:String):void
		{
			if (_selectColorO && _selectColorO.color == color) return;
			var key:String;
			var tColorO:Object;
			for (key in colorInfoDic)
			{
				tColorO = colorInfoDic[key];
				if (tColorO.color == color)
				{
					_selectColorO = tColorO;
					drawCircle();
				}
			}
		}
		
		private function findColorO(color:String):Object
		{
			var key:String;
			var tColorO:Object;
			var _color:Object;
			for (key in colorInfoDic)
			{
				tColorO = colorInfoDic[key];
				if (tColorO.color == color)
				{
					_color = tColorO;
				}
			}
			return _color;
			
		}
		public function findColorPos(color:String):void
		{
			var colorO:Object;
			colorO = findColorO(color);
			if (!colorO) return;
			selectColorRec(color);
			var key:int;
			key = parseInt(colorO.key);
			var rot:int;
			rot = key / 1000;
			var depth:int;
			depth = key % 1000;
			
			rot = rot / circleSplit * 360;
			var depthRate:Number;
			depthRate = depth / depthSplit;
			
			setRingRotation( -((rot + 96) % 360));
			setMoveRate(depthRate + 0.2 );
			drawCircle();
			event(Event.CHANGE, [selectColor]);
		}
		
		private var leftRotation:Number;
		private function _onMouseMove(e:Event):void
		{
			e.stopPropagation();
			_curMouseInfo = getCurMouseInfo(_curMouseInfo);
			
			if (!_isMoving)
			{
				if (Math.abs(_curMouseInfo.r - _mouseDonwMouseInfo.r) > 5 || Math.abs(_mouseDonwMouseInfo.rotation - _curMouseInfo.rotation) > 5)
				{
					_isMoving = true;
				}else
				{
					return;
				}
			}
			var targetRotation:Number;
			targetRotation = _preMouseInfo.rotation - _mouseDonwMouseInfo.rotation + _curMouseInfo.rotation;
			var dRotation:Number;
			dRotation = targetRotation - ringSprite.rotation;
			//ringSprite.rotation = _preMouseInfo.rotation - _mouseDonwMouseInfo.rotation + _curMouseInfo.rotation;
			ringSprite.rotation += 0.25 * dRotation;
			leftRotation = dRotation;
			setMoveRate(_preMouseInfo.r - (_curMouseInfo.r - _mouseDonwMouseInfo.r) / 100);
			drawCircle();
		}
		
		private var _preTween:Tween;
		private function _onMouseUp(e:Event):void
		{
			_removeMoveEvents();	
			if (_preTween) Tween.clear(_preTween);
			
			if(leftRotation)
			_preTween=Tween.to(this,{ringRotation:this.ringRotation+leftRotation*5},500,Ease.circOut);
		}
		
		private function set ringRotation(value:Number):void
		{
			if (ringSprite.rotation != value)
			{
				ringSprite.rotation = value;
				drawCircle();
			}
		}
		private function get ringRotation():Number
		{
			return ringSprite.rotation;
		}
		private function _onMouseOut(e:Event):void
		{
			_removeMoveEvents();
		}
		
		public function get selectColor():String
		{
			if (_selectColorO) return _selectColorO.color;
			return null;
		}
		public function initSize(width:int, height:int):void
		{
			initColorValueList();
			ringSprite.pos(width * 0.5, height * 0.5);
			var maxR:Number;
			maxR = Math.min(width, height) * 0.5;
			ringSprite.pivot(maxR, maxR);
			drawStartR = maxR*0.7;
			drawEndR = maxR;
			this.size(width, height);
			drawCircle();
		}
		private var hueList:Array;
		private var saturationList:Array;
		private var birghtList:Array;
		private var grayList:Array;
		
		private function initList(start:Number, end:Number, count:int,includEnd:Boolean=true):Array
		{
			var i:int, len:int;
			len = count;
			var d:Number;
			d = (end - start) / count;
			var rst:Array;
			rst = [];
			if (includEnd)
			{
				start += d;
			}
			for (i = 0; i < len; i++)
			{
				rst.push(start+i*d);
			}
			return rst;
		}
		
		public function setRingRotation(rotation:Number):void
		{
			ringSprite.rotation = rotation;
		}
		public function initColorValueList():void
		{
			grayList = ColorTableTool.createGrayColor(depthSplit);
			hueList = initList(0, 360, circleSplit-1,false);
			saturationList = initList(startS, endS, depthSplit);
			birghtList = initList(startB, endB, depthSplit);
		}
		
		private var minAngle:Number;
		private var maxAngle:Number;
		private var middleAngle:Number;
		public function drawCircle():void
		{
			ringSprite.graphics.clear();
			var i:int, len:int;
			var j:int, jLen:int;
			len = circleSplit;
			jLen = depthSplit;
			var recWidth:int = 20;
			
			middleAngle =-Math.PI*0.5 -ringSprite.rotation * Math.PI / 180 ;
			//middleAngle = 0;
			for (i = 0; i < len; i++)
			{
				//if (i > 0) return;
				for (j = 0; j < jLen; j++)
				{
					drawCirclePart(i,j);
					//this.graphics.drawRect(i * recWidth, j * recWidth, recWidth, recWidth, ColorTool.getRGBStr(ColorTool.hsb2rgb(hueList[i],saturationList[j],birghtList[j])));
				}
			}
		}
		public var drawStartR:Number = 100;
		public var drawEndR:Number = 200;
		public function get drawDR():Number
		{
			return drawEndR - drawStartR;
		}
		public var logicalStartR:Number = 100;
		public var logicalEndR:Number = 300;
		public function get logicalLen():Number
		{
			return logicalEndR - logicalStartR;
		}
		
		public var logicalShowStartR:Number = 100;
		public var logicalShowLen:Number = 100;
		public function get logicalShowEndR():Number
		{
			return logicalShowStartR + logicalShowLen;
		}
		
		public function get moveAbleLen():Number
		{
			return logicalLen - logicalShowLen;
		}
		public function setMoveRate(rate:Number):void
		{
			if (rate < 0) rate = 0;
			if (rate > 1) rate = 1;
			logicalShowStartR = logicalStartR + moveAbleLen * rate;
		}
		
		public function getMoveRate():Number
		{
			return (logicalShowStartR - logicalStartR) / moveAbleLen;
		}
		private function getMapedR(r:Number):Number
		{
			var rate:Number;
			rate = (r - logicalShowStartR) / logicalShowLen;
			var angle:Number;
			angle = Math.PI * rate;
			rate=(1-Math.cos(angle))/2
			return drawStartR + drawDR * rate;
		}
		
		private var colorInfoDic:Object = { };
		
		
		private function addColorInfo(key:String, color:String, poly:Array):void
		{
			if (!colorInfoDic[key])
			{
				colorInfoDic[key] = { };
				colorInfoDic[key].key = key;
			}
			var tObj:Object;
			tObj = colorInfoDic[key];
			if(color)
			tObj.color = color;
			tObj.poly = poly;
		}
		
		public function getColorOByPoint(x:Number, y:Number):Object
		{
			var key:String;
			var tColorO:Object;
			for (key in colorInfoDic)
			{
				tColorO = colorInfoDic[key];
				if (!tColorO.poly) continue;
				if (HitArea._ptInPolygon(x, y, tColorO.poly))
				{
					return tColorO;
				}
			}
			return null
		}
		
		private function getColorByHD(hue:int, depth:int):String
		{
			if (hue == circleSplit - 1)
			{
				return ColorTableTool.changeColor(this.grayList[depth]);
			}
			return ColorTableTool.changeColor(ColorTool.getRGBStr(ColorTool.hsb2rgb(hueList[hue], saturationList[depth], birghtList[depth])));
		}
		private function drawCirclePart(hue:int, depth:int,force:Boolean=false):void
		{
			var dR:Number;
			dR = logicalLen / depthSplit;
			var tR:Number;
			tR = logicalStartR + dR * depth;
			var tEndR:Number;
			tEndR = tR + dR;
			
			var key:String;
			key = (hue * 1000 + depth) + '';
			
			if (tR > logicalShowEndR || tEndR < logicalShowStartR)
			{
				//var temp:String = ColorTool.getRGBStr(ColorTool.hsb2rgb(hueList[hue], saturationList[depth], birghtList[depth]));
				addColorInfo(key,getColorByHD(hue,depth),null);
				return;
			} 
			
		
			tR = Math.max(tR, logicalShowStartR);
			tEndR = Math.min(tEndR, logicalShowEndR);
			
			
			tR = getMapedR(tR);
			tEndR = getMapedR(tEndR);
			var dAngle:Number;
			dAngle = Math.PI*2 / circleSplit;
			var tAngle:Number;
			tAngle = hue * dAngle;
			var tColor:String;
			
			//tColor = ColorTool.getRGBStr(ColorTool.hsb2rgb(hueList[hue], saturationList[depth], birghtList[depth]));
			//tColor = ColorTableTool.changeColor(tColor);
			tColor = getColorByHD(hue, depth);
			
			if (_selectColorO && _selectColorO.key == key)
			{
				if (!force)
				{
					callLater(drawCirclePart, [hue,depth,true]);
					return;
				}
				addColorInfo(key,tColor,drawCircleRec(tR, tEndR, tAngle, tAngle + dAngle, tColor,"#ff0000"));
			}else
			{
				addColorInfo(key,tColor,drawCircleRec(tR, tEndR, tAngle, tAngle + dAngle, tColor));
			}
			
		}
		
		private function drawCircleRec(startR:Number, endR:Number, startAngle:Number, endAngle:Number, color:String,lineColor:String=null):Array
		{
			var posList:Array;
			posList = [startR, startAngle, endR, startAngle, endR, endAngle, startR, endAngle];
			var i:int, len:int;
			len = posList.length;
			
			var pointList:Array;
			pointList = [];
			//pointList.length = posList.length;
			pointList = posList;
			var tR:Number;
			var tAngle:Number;
			
			var cx:Number;
			var cy:Number;
			cx = ringSprite.pivotX;
			cy = ringSprite.pivotY;
			
			for (i = 0; i < len; i += 2)
			{
				tR = posList[i];
				tAngle = posList[i + 1];
				pointList[i] = cx + tR * Math.cos(tAngle);
				pointList[i+1] = cy + tR * Math.sin(tAngle);
			}
			
			var dAngle:Number;
			dAngle = Math.abs((startAngle + endAngle) * 0.5 - middleAngle);
			dAngle = dAngle % (Math.PI*2);
			dAngle = dAngle > Math.PI * 2?dAngle-Math.PI * 2:dAngle;
			dAngle = dAngle > Math.PI?Math.PI * 2 - dAngle:dAngle;
			
			if(dAngle<Math.PI*0.5+0.2)
			{
				ringSprite.graphics.drawPoly(0, 0, pointList, color,lineColor,4);
			}
			
			return pointList;
		}
		
	}

}