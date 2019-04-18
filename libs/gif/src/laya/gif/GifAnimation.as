package laya.gif
{
	import laya.display.Animation;
	import laya.display.Graphics;
	import laya.net.Loader;
	import laya.renders.Render;
	import laya.resource.HTMLCanvas;
	import laya.resource.HTMLImage;
	import laya.resource.Texture;
	import laya.utils.Browser;
	import laya.utils.Handler;
	
	/**
	 * Gif播放类
	 * @author ww
	 */
	public class GifAnimation extends Animation
	{
		
		public function GifAnimation()
		{
		
		}
		
		/**
		 * 加载gif动画
		 * @param path gif url
		 *
		 */
		public function loadGif(path:String):void
		{
			Laya.loader.load(path, Handler.create(this, _dataLoaded, null, false), null, Loader.BUFFER);
		}
		
		/**
		 * @private
		 */
		private function _dataLoaded(data:*):void
		{
			var gif:GifReader = new GifReader(new Uint8Array(data));
			var graphicList:Array = [];
			var i:int, len:int = gif.numFrames();
			var g:Graphics;
			var frameInfo:Object;
			var mainCanvas:HTMLCanvas;
			mainCanvas = new HTMLCanvas("2D");
			var ctx:* = mainCanvas.getContext('2d');
			mainCanvas.size(gif.width, gif.height);
			var canvas:HTMLCanvas;
			for (i = 0; i < len; i++)
			{
				frameInfo = gif.frameInfo(i);
				//trace("frameInfo:",frameInfo,frameInfo.disposal);
				__JS__("frameInfo.pixels = new Uint8ClampedArray(gif.width * gif.height * 4);");
				gif.decodeAndBlitFrameRGBA(i, frameInfo.pixels);
				g = new Graphics();
				canvas = _createBufferCanvas(frameInfo, gif.width, gif.height, canvas);
				if (frameInfo.disposal == 2)
				{
					mainCanvas.size(1, gif.height);
					mainCanvas.size(gif.width, gif.height);
				}
				else if (frameInfo.disposal == 3)
				{
					
				}
				else
				{
					
				}
				ctx.drawImage(canvas.source, frameInfo.x, frameInfo.y, frameInfo.width, frameInfo.height);
				var drawCanvas:HTMLCanvas;
				drawCanvas = _cloneCanvas(mainCanvas);
				if (Render.isWebGL)
				{
					var img:HTMLImage;
					img = HTMLImage.create(drawCanvas.source.toDataURL("image/png"));
					img._w = gif.width;
					img._h = gif.height;
					g.drawTexture(new Texture(img), 0, 0, gif.width, gif.height);
				}
				else
				{
					g.drawTexture(new Texture(drawCanvas), 0, 0, gif.width, gif.height);
				}
				
				graphicList.push(g);
			}
			frames = graphicList;
			this.size(gif.width, gif.height);
		}
		
		/**
		 * @private
		 */
		private static function _createBufferCanvas(frame:Object, width:Number = -1, height:Number = -1, canvas:HTMLCanvas = null):*
		{
			var imageData:*;
			if (!canvas)
				canvas = new HTMLCanvas("2D");
			var ctx:* = canvas.getContext('2d');
			canvas.size(frame.width, frame.height);
			if (width < 0)
				width = frame.width;
			if (height < 0)
				height = frame.height;
			imageData = ctx.createImageData(width, height);
			imageData.data.set(frame.pixels);
			ctx.putImageData(imageData, -frame.x, -frame.y);
			return canvas;
		}
		
		/**
		 * @private
		 */
		private static function _cloneCanvas(srcCanvas:HTMLCanvas):HTMLCanvas
		{
			var canvas:HTMLCanvas = new HTMLCanvas("2D");
			var ctx:* = canvas.getContext('2d');
			canvas.size(srcCanvas.width, srcCanvas.height);
			ctx.drawImage(srcCanvas.source, 0, 0);
			return canvas;
		}
	
	}

}